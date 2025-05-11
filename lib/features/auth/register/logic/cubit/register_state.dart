import '../../data/model/register.dart';

sealed class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final RegisterResponseModel response;

  RegisterLoaded(this.response);
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}
