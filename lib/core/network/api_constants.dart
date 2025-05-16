class ApiConstants {
  // static const String baseUrl = 'https://flutter.thelper.space/api';

  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Auth Endpoints
  static const String login = '/auth';
  static const String register = '/auth';
  static const String products = '/products';
  static const String categories = '/categories';
  static const String brands = '/brands';
  static const String googleLogin = '/auth/google';
  static const String googleRegister = '/auth/google/register';
  static const String facebookLogin = '/auth/facebook';
  static const String facebookRegister = '/auth/facebook/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String banners = '/banners';
  static const String bannerslink = 'http://10.0.2.2:8000/storage/';

  // Headers
  static Map<String, String> headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
