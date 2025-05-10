class ApiConstants {
  static const String baseUrl = 'https://example.com';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
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
