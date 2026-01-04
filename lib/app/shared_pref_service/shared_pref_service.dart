import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveUserToken(String token)async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setString("user_token", token);
  }

  static Future<String?> getUserToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_token");
  }

  static Future<void> clear()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> get isLoggedIn async {
    final userToken = await getUserToken();
    return userToken != null && userToken.isNotEmpty;
  }



  static Future<void> saveUserEmail(String email)async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setString("user_email", email);
    final save =await getUserEmail();
    print("////////$save");
  }

  static Future<String?> getUserEmail()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    final memory=prefs.getString("user_email");
    return memory;
  }
}