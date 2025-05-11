import '../../data/model/login.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucces extends LoginState {
  final LoginResponseModel response;

  LoginSucces({required this.response});
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
