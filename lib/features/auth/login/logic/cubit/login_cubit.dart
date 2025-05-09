import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      // TODO: Add repository call here when API is ready
      // final result = await _repository.login(email, password);
      // result.fold(
      //   (failure) => emit(LoginError(message: failure.message)),
      //   (success) => emit(LoginLoaded()),
      // );

      // Temporary success for testing
      emit(LoginLoaded());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoading());

      // TODO: Add repository call here when API is ready
      // final result = await _repository.loginWithGoogle();
      // result.fold(
      //   (failure) => emit(LoginError(message: failure.message)),
      //   (success) => emit(LoginLoaded()),
      // );

      // Temporary success for testing
      emit(LoginLoaded());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      emit(LoginLoading());

      // TODO: Add repository call here when API is ready
      // final result = await _repository.loginWithFacebook();
      // result.fold(
      //   (failure) => emit(LoginError(message: failure.message)),
      //   (success) => emit(LoginLoaded()),
      // );

      // Temporary success for testing
      emit(LoginLoaded());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(LoginLoading());

      // TODO: Add repository call here when API is ready
      // final result = await _repository.resetPassword(email);
      // result.fold(
      //   (failure) => emit(LoginError(message: failure.message)),
      //   (success) => emit(LoginLoaded()),
      // );

      // Temporary success for testing
      emit(LoginLoaded());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
