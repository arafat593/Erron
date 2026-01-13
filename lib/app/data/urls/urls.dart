class Urls{
  static const String _baseUrl= 'https://eron.mtscorporate.com';
  static String signUp = '$_baseUrl/api/v1/auth/signup';
  static String otpVerification = '$_baseUrl/api/v1/auth/otp-verify';
  static String login = '$_baseUrl/api/v1/auth/login';
  static String activeUser = '$_baseUrl/api/v1/chat/active-users';
  static String emailVerification = '$_baseUrl/api/v1/auth/resend-otp';
  static String newPassword = '$_baseUrl/api/v1/auth/reset-password';
}