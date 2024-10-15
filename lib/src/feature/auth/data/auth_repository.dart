import '../model/user.dart';
import 'auth_data_provider.dart';

abstract interface class AuthRepository {
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

  /// Returns a stream of [User]s.
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

  /// Returns the current [TokenPair].
  TokenPair? getTokenPair();

  /// Clear the current [TokenPair].
  Future<void> signOut();

  Future<int> sendCode({required String phone});

  /// Attempts to sign in with the given [phone].
  Future<User> signInWithPhone({
    required String phone,
    required String smsCode,
    required int uniqueRequestId,
  });

  /// Attempts to sign up with the given [phone].
  Future<User> signUp({required User userModel});
}

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataProvider authDataProvider,
  }) : _authDataProvider = authDataProvider;

  final AuthDataProvider _authDataProvider;

  @override
  Stream<TokenPair?> get tokenPairStream => _authDataProvider.tokenPairStream;

  @override
  TokenPair? getTokenPair() => _authDataProvider.getTokenPair();

  @override
  Stream<User?> get userStream => _authDataProvider.userStream;

  @override
  User? getUser() => _authDataProvider.getUser();

  @override
  Future<void> signOut() => _authDataProvider.signOut();

  @override
  Future<int> sendCode({required String phone}) =>
      _authDataProvider.sendCode(phone: phone);

  @override
  Future<User> signInWithPhone({
    required String phone,
    required String smsCode,
    required int uniqueRequestId,
  }) =>
      _authDataProvider.signInWithPhone(
        phone: phone,
        smsCode: smsCode,
        uniqueRequestId: uniqueRequestId,
      );

  @override
  Future<User> signUp({required User userModel}) =>
      _authDataProvider.signUp(userModel: userModel);

  // @override
  // Future<User> signInAnonymously() => _authDataProvider.signInAnonymously();
}
