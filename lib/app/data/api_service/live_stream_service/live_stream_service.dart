import 'dart:convert';
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class LiveStreamService {
  static Future<dynamic> liveStreamRequest(String url,
      Map<String, dynamic> body,) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }

    final uri = Uri.parse(url).replace(
      queryParameters: {
        "title": body["title"].toString(),
        "category": body["category"].toString(),
        "is_premium": body["is_premium"].toString(),
        "entry_fee": body["entry_fee"].toString(),
      },
    );

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      throw "Stream request failed $e";
    }
  }


  static Future<dynamic> disConnectStreamRequest(
      String url,
      ) async {
    final token =await SharedPrefService.getUserToken();
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
      throw "Disconnect request failed $e";
    }
  }
}




