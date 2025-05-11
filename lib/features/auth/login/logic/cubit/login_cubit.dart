import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:super_mall/features/auth/login/data/model/login.dart';
import 'package:super_mall/features/auth/login/data/repository/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepositoryBase _repository;

  LoginCubit(this._repository) : super(LoginInitial());

  Future<void> login(UserLoginModel loginData) async {
    try {
      emit(LoginLoading());
      developer.log('Login request data: ${loginData.toJson()}');

      final result = await _repository.login(loginData);

      result.fold(
        (failure) {
          developer.log('Login failed: ${failure.message}');
          emit(LoginError(message: failure.message));
        },
        (success) {
          developer.log('Login successful: ${success.token}');
          emit(LoginSucces(response: success));
        },
      );
    } catch (e, stackTrace) {
      developer.log('Login error: $e\n$stackTrace');
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoading());

      final result = await _repository.loginWithGoogle();

      result.fold(
        (failure) => emit(LoginError(message: failure.message)),
        (success) => emit(LoginSucces(response: LoginResponseModel())),
      );
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      emit(LoginLoading());

      final result = await _repository.loginWithFacebook();

      result.fold(
        (failure) => emit(LoginError(message: failure.message)),
        (success) => emit(LoginSucces(response: LoginResponseModel())),
      );
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(LoginLoading());

      final result = await _repository.resetPassword(email);

      result.fold(
        (failure) => emit(LoginError(message: failure.message)),
        (_) => emit(LoginSucces(response: LoginResponseModel())),
      );
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
