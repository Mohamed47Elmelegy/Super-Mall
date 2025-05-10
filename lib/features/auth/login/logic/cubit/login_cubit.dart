import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:super_mall/features/auth/login/data/model/login.dart';
import 'package:super_mall/features/auth/login/data/repository/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepositoryBase _repository;

  LoginCubit(this._repository) : super(LoginInitial());

  Future<void> login(UserLoginModel loginData) async {
    try {
      emit(LoginLoading());
      final result = await _repository.login(loginData);
      result.fold(
        (failure) => emit(LoginError(message: failure.message)),
        (success) => emit(LoginLoaded()),
      );
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoading());

      final result = await _repository.loginWithGoogle();

      result.fold(
        (failure) => emit(LoginError(message: failure.message)),
        (success) => emit(LoginLoaded()),
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
        (success) => emit(LoginLoaded()),
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
        (success) => emit(LoginLoaded()),
      );
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
