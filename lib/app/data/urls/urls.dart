class Urls{
  static const String _baseUrl= 'https://erronliveapp.mtscorporate.com';
  static String signUp = '$_baseUrl/api/v1/auth/signup';
  static String otpVerification = '$_baseUrl/api/v1/auth/otp-verify';
  static String login = '$_baseUrl/api/v1/auth/login';
  static String chatActiveUser = '$_baseUrl/api/v1/chat/active-users';
  static String emailVerification = '$_baseUrl/api/v1/auth/resend-otp';
  static String newPassword = '$_baseUrl/api/v1/auth/reset-password';
  static String liveStream = '$_baseUrl/api/v1/streaming/start';
  static String allStreams = '$_baseUrl/api/v1/streaming/all/streams';
  static String uploadImage = '$_baseUrl/api/v1/chat/upload-image';
  static String conversation = '$_baseUrl/api/v1/chat/conversations';
  static String myProfile = '/users/my_profile';
  static String activeStream = '$_baseUrl/api/v1/streaming/active';
  static String updateProfile = '$_baseUrl/api/v1/users/my_profile/update';
  static String uploadProfileImage = '$_baseUrl/api/v1/users/my_profile/upload-profile-image';
  static String search(dynamic query) => '$_baseUrl//users/search?query=$query';
  static String stopStream(dynamic id) => '$_baseUrl/api/v1/streaming/stop-stream/$id';
  static String joinStream(dynamic id) => '$_baseUrl/api/v1/streaming/join/$id';
  static String readMessage(dynamic senderId) => '$_baseUrl/api/v1/chat/mark-read/$senderId';

}