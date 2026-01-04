import 'package:errone/app/data/api_service/auth_api_service/auth_api_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool obSecure = true.obs;
  RxBool isObSecure = true.obs;

  void changeObSecure() {
    obSecure.value = !obSecure.value;
  }

  void changeIsObSecure() {
    isObSecure.value = !isObSecure.value;
  }

  bool signUpInProgress = false;
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  Future<void> getSignUp() async {
    signUpInProgress = true;
    update();
    try {
      final response =
          await AuthApiService.signUpRequest(Urls.signUp, <String, dynamic>{
            "first_name": firstNameTEController.text.trim(),
            "last_name": lastNameTEController.text.trim(),
            "email": emailTEController.text.trim(),
            "password": passwordTEController.text,
            "auth_provider": "email",
          });
      signUpInProgress =false;
      update();
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 201){
        await SharedPrefService.saveUserEmail(emailTEController.text);
        Get.snackbar("success", "Login Successful");
        Get.toNamed(Routes.SIGN_UP_VERIFICATION_CODE);
      }else{
        Get.snackbar("Failed", response.body);

      }
    } catch (e) {
      signUpInProgress=false;
      update();
      Get.snackbar("Error", "$e");
    }
  }
}
