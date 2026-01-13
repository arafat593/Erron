import 'package:errone/app/data/api_service/auth_api_service/auth_api_service.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/urls/urls.dart';

class EmailVerificationController extends GetxController {
  bool emailInProgress = false;
  final TextEditingController emailTEController = TextEditingController();

  Future<void> getEmailVerification() async {
    emailInProgress = true;
    update();
    try {
      final response = await AuthApiService.emailVerificationRequest(
        Urls.emailVerification,
        <String, dynamic>{"email": emailTEController.text.trim()},
      );
      emailInProgress = false;
      update();
      print("${response.body}");
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        await SharedPrefService.saveUserEmail(emailTEController.text);
        Get.snackbar("Success", "Email verification successful");
        Get.toNamed(Routes.EMAIL_VERIFICATION_CODE);
      }else{
        Get.snackbar("Failed", response.body);
        print("${response.body}");
      }
    } catch (e) {
      emailInProgress = false;
      update();
      Get.snackbar("Error", "$e");
    }
  }
}
