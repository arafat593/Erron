
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class JoinStreamService {
  static Future<dynamic> joinStreamRequest(String url) async {
    final token =await SharedPrefService.getUserToken();
    print("token urlsss $token");
    if(token == null){
      Get.toNamed(Routes.LOGIN);
      return null;
    }
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer $token"
        },
      );
      return response;
    } catch (e) {
      throw Exception("Join stream request failed: $e");
    }
  }
}