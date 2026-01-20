import 'dart:convert';

import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileService {
  static Future<dynamic> editProfileRequest(String url,
      Map<String, dynamic>body) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) {
      Get.toNamed(Routes.LOGIN);
    }
    try{
     final response=await http.patch(Uri.parse(url),headers: {
       "Content-Type": "application/json",
       "Authorization":"Bearer $token"
     },body: jsonEncode(body));
     return response;
    }catch(e){
     throw 'Error is $e';
    }
  }

  static Future<http.Response> uploadProfileImageRequest(
      String url, XFile image) async {

    final token = await SharedPrefService.getUserToken();

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse(url),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_image',
        image.path,
      ),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

}