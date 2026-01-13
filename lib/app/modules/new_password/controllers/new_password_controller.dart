import 'package:errone/app/data/api_service/auth_api_service/auth_api_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NewPasswordController extends GetxController {
  bool newPasswordInProgress= false;
  final TextEditingController passwordController= TextEditingController();
  final TextEditingController confirmPasswordController= TextEditingController();
  RxBool select1= true.obs;
  RxBool select2= true.obs;

  void changeSelect1() {
    select1.value = !select1.value;
  }
  void changeSelect2(){
    select2.value = !select2.value;
  }

  Future<void> getNewPassword()async{
    newPasswordInProgress=true;
    update();
    final email= await SharedPrefService.getUserEmail();
    print("emaill------------------ $email");
    try{
      final response= await AuthApiService.resetPassword(Urls.newPassword, <String,dynamic>{
        "email": email,
        "new_password": passwordController.text,
      });
      newPasswordInProgress=false;
      update();
      if(response.statusCode == 200){
        Get.snackbar("success", "Password setup successful");
        Get.offAllNamed(Routes.LOGIN);
      }else{
        Get.snackbar("Failed",response.body);
      }
    }catch(e){
      newPasswordInProgress=false;
      update();
      Get.snackbar("Error", "$e");
    }
  }
}
