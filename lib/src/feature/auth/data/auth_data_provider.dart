import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/exception/error_code.dart';
import 'package:ln_employee/src/common/utils/error_util.dart';
import 'package:ln_employee/src/common/utils/extensions/date_time_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

abstract interface class AuthDataProvider {
  /// Returns the current [TokenPair].
  TokenPair? getTokenPair();

  /// Refreshes the current [TokenPair].
  Future<TokenPair> refreshTokenPair();

  /// Clear the current [TokenPair].
  Future<void> signOut();

  /// Returns a stream of [TokenPair]s.
  ///
  /// The stream will emit a new [TokenPair] whenever the user's
  /// authentication state changes.
  ///
  /// If the user is not authenticated, the stream will emit `null`.
  ///
  /// If the user is authenticated, the stream will emit a [TokenPair]
  ///
  /// When listener is added to the stream, the stream will emit the
  /// current [TokenPair] immediately.
  Stream<TokenPair?> get tokenPairStream;

  /// Returns a stream of [TokenPair]s.
  ///
  /// The stream will emit a new [User] whenever the user's
  /// authentication state changes.
  ///
  /// If the user is not authenticated, the stream will emit `null`.
  ///
  /// If the user is authenticated, the stream will emit a [User]
  ///
  /// When listener is added to the stream, the stream will emit the
  /// current [User] immediately.
  Stream<User?> get userStream;

  /// Returns the current [User].
  User? getUser();

  Future<int> sendCode({required String phone});

  // /// Attempts to sign in with the given [phone].
  Future<User> signInWithPhone({
    required String phone,
    required String smsCode,
    required int uniqueRequestId,
  });

  Future<User> signUp({required User userModel});
}

final class AuthDataProviderImpl implements AuthDataProvider {
  AuthDataProviderImpl({
    required String baseUrl,
    required SharedPreferences sharedPreferences,
    @visibleForTesting Dio? httpClient,
  })  : _sharedPreferences = sharedPreferences,
        client = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl));

  final SharedPreferences _sharedPreferences;
  final Dio client;

  final _tokenPairController = StreamController<TokenPair?>();
  final _userController = StreamController<User?>();

  ///
  Future<void> _saveTokenPair(TokenPair pair) async {
    await _sharedPreferences.setString(
      'auth.token_pair.access_token',
      pair.accessToken,
    );

    await _sharedPreferences.setString(
      'auth.token_pair.refresh_token',
      pair.refreshToken,
    );

    _tokenPairController.add(pair);
  }

  ///
  Future<void> _saveUser(User user) async {
    await _sharedPreferences.setInt('auth.user.id', user.id!);
    await _sharedPreferences.setString('auth.user.phone', user.phone!);
    if (user.photo != null) {
      await _sharedPreferences.setString('auth.user.photo', user.photo!);
    }
    await _sharedPreferences.setString('auth.user.first_name', user.firstName!);
    await _sharedPreferences.setString('auth.user.last_name', user.lastName!);
    await _sharedPreferences.setString(
      'auth.user.birth_date',
      user.birthDate.toString(),
    );
    await _sharedPreferences.setString('auth.user.email', user.email!);
    await _sharedPreferences.setBool(
      'auth.user.is_superuser',
      user.isSuperuser!,
    );

    _userController.add(user);
  }

  ///
  TokenPair _decodeTokenPair(Map<String, Object?>? json) {
    if (json
        case {
          'error': {
            'message': final String message,
            'code': final int code,
          }
        }) {
      final errorCode = ErrorCode.fromInt(code);

      ErrorUtil.throwAuthException(errorCode, message);
    }

    // For refresh tokens
    if (json
        case {
          'data': {
            'access_token': final String accessToken,
            'refresh_token': final String refreshToken,
          },
        }) {
      return (
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }

    // For auth tokens
    if (json
        case {
          'data': {
            'tokens': {
              'access_token': final String accessToken,
              'refresh_token': final String refreshToken,
            }
          },
        }) {
      return (
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }

    throw const FormatException('Failed to decode token pair');
  }

  @override
  Future<TokenPair> refreshTokenPair() async {
    final tokenPair = getTokenPair();

    if (tokenPair == null) {
      throw Exception('Failed to refresh token pair');
    }

    final response = await client.post(
      '/api/auth/refresh',
      data: {
        'token': tokenPair.refreshToken,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to refresh token pair');
    }

    final newTokenPair = _decodeTokenPair(response.data);
    await _saveTokenPair(newTokenPair);

    return newTokenPair;
  }

  @override
  Future<int> sendCode({required String phone}) async {
    final response = await client.post(
      '/api/auth/call/init',
      data: {
        'phone_number': phone,
        "unique_request_id": null,
        'is_employee': true,
      },
    );
    // Возвращаем unique_request_id
    return response.data['data'];
  }

  @override
  Future<User> signInWithPhone({
    required String phone,
    required String smsCode,
    required int uniqueRequestId,
  }) async {
    final response = await client.post<Map<String, Object?>>(
      '/api/auth/call/validate',
      data: {
        'code': smsCode,
        "unique_request_id": uniqueRequestId.toString(),
        "is_employee": true,
      },
    );

    final tokenPair = _decodeTokenPair(response.data);

    await _saveTokenPair(tokenPair);

    final user = User.fromJson((response.data!['data'] as Map)['model']);

    await _saveUser(user);

    return user;
  }

  @override
  Future<User> signUp({required User userModel}) async {
    final response = await client.post<Map<String, Object?>>(
      '/api/auth/sign-up',
      data: {
        "phone_number": userModel.phone,
        "first_name": userModel.firstName,
        "last_name": userModel.lastName,
        "birth_date": userModel.birthDate?.jsonFormat(),
        "email": userModel.email,
      },
    );

    final tokenPair = _decodeTokenPair(response.data);

    await _saveTokenPair(tokenPair);

    await _saveUser(userModel);

    return userModel;
  }

  @override
  Future<void> signOut() async {
    await _sharedPreferences.remove('auth.token_pair.access_token');
    await _sharedPreferences.remove('auth.token_pair.refresh_token');
    await _sharedPreferences.remove('auth.user.phone');
    // TODO: remove remaining variables
    _tokenPairController.add(null);
    _userController.add(null);
    return;
  }

  @override
  TokenPair? getTokenPair() {
    final accessToken = _sharedPreferences.getString(
      'auth.token_pair.access_token',
    );

    final refreshToken = _sharedPreferences.getString(
      'auth.token_pair.refresh_token',
    );

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return (
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  late final Stream<TokenPair?> tokenPairStream =
      _tokenPairController.stream.asBroadcastStream(
    onListen: (subscription) => _tokenPairController.add(getTokenPair()),
  );
  @override
  User? getUser() {
    final id = _sharedPreferences.getInt('auth.user.id');
    final phone = _sharedPreferences.getString('auth.user.phone');
    final photo = _sharedPreferences.getString('auth.user.photo');
    final firstName = _sharedPreferences.getString('auth.user.first_name');
    final lastName = _sharedPreferences.getString('auth.user.last_name');
    final birthDate = _sharedPreferences.getString('auth.user.birthDate');
    final email = _sharedPreferences.getString('auth.user.email');
    final isSuperuser = _sharedPreferences.getBool('auth.user.is_superuser');

    return User(
      id: id,
      phone: phone,
      photo: photo,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate != null ? DateTime.parse(birthDate) : null,
      email: email,
      isSuperuser: isSuperuser,
    );
  }

  @override
  Stream<User?> get userStream => _userController.stream.asBroadcastStream(
        onListen: (subscription) => _userController.add(getUser()),
      );
}
