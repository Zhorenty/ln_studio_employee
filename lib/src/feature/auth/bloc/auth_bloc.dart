import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/exception/error_code.dart';
import 'package:ln_employee/src/common/utils/error_util.dart';
import 'package:ln_employee/src/common/utils/mixin/set_state_mixin.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc(this.authRepository) : super(const AuthState$Idle()) {
    authRepository.userStream
        .map((user) => AuthState$Idle(user: user))
        .where(($state) => !identical($state, state))
        .listen(setState);

    on<AuthEvent>(
      (event, emit) => event.map(
        sendCode: (e) => _sendCode(e, emit),
        signInWithPhone: (e) => _signInWithPhone(e, emit),
        signUp: (e) => _signUp(e, emit),
        signOut: (e) => _signOut(e, emit),
      ),
    );
  }

  final AuthRepository authRepository;

  Future<void> _sendCode(
    AuthEvent$SendCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: event.phone,
      smsCode: null,
    ));
    try {
      await authRepository.sendCode(phone: event.phone);
      emit(AuthState.successful(
        user: state.user,
        phone: event.phone,
        smsCode: null,
      ));
    } on Object catch (e) {
      if (e is DioException && e.response!.statusCode == 400) {
        emit(
          AuthState.idle(
            error: ErrorUtil.throwAuthException(
              ErrorCode.phoneNotFound,
              'Пользователь с таким номером не найден',
            ),
          ),
        );
      } else {
        emit(AuthState.idle(error: ErrorUtil.formatError(e)));
        rethrow;
      }
    } finally {
      emit(AuthState.idle(user: state.user, phone: state.phone));
    }
  }

  Future<void> _signInWithPhone(
    AuthEventSignInWithPhone event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: state.phone,
      smsCode: event.smsCode,
    ));
    try {
      final user = await authRepository.signInWithPhone(
        phone: state.phone!,
        smsCode: event.smsCode,
      );
      emit(AuthState.successful(
        user: user,
        phone: state.phone,
        smsCode: state.smsCode,
      ));
    } on Object catch (e) {
      emit(AuthState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }

  Future<void> _signUp(
    AuthEvent$SignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(
      user: state.user,
      phone: state.phone,
      smsCode: null,
    ));
    try {
      final user = await authRepository.signUp(userModel: event.user);
      emit(AuthState.successful(user: user, phone: user.phone, smsCode: null));
    } on Object catch (e) {
      emit(AuthState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }

  Future<void> _signOut(
    AuthEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(user: state.user, phone: null, smsCode: null));
    try {
      await authRepository.signOut();
      emit(const AuthState.successful(user: null, phone: null, smsCode: null));
    } on Object catch (e) {
      emit(AuthState.idle(error: ErrorUtil.formatError(e)));
      rethrow;
    }
  }
}
