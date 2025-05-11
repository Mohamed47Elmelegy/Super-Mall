class ApiConstants {
  static const String baseUrl = 'https://flutter.thelper.space/api';

  // Auth Endpoints
  static const String login = '/auth';
  static const String register = '/auth';
  static const String googleLogin = '/auth/google';
  static const String googleRegister = '/auth/google/register';
  static const String facebookLogin = '/auth/facebook';
  static const String facebookRegister = '/auth/facebook/register';
  static const String forgotPassword = '/auth/forgot-password';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
