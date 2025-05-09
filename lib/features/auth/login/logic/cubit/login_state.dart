sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  // يمكن إضافة بيانات إضافية هنا مثل user data
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
