import 'package:errone/app/data/api_service/auth_api_service/auth_api_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared_pref_service/shared_pref_service.dart';

class EmailVerificationCodeController extends GetxController {
  bool otpInProgress=false;
  final TextEditingController otpTEController=TextEditingController();

  Future<void> getVerification()async{
    otpInProgress=true;
    update();
    final email= await SharedPrefService.getUserEmail();
    try{
      final response=await AuthApiService.otpRequest(Urls.otpVerification, <String,dynamic>{
        "email": email,
        "otp": otpTEController.text.trim()
      });
      otpInProgress=false;
      update();
      print(response.statusCode.toString());
      print(response.body);
      if(response.statusCode == 200){
        Get.snackbar('Success', "Otp Verification Successful",);
        Get.toNamed(Routes.NEW_PASSWORD);
      }else{
        Get.snackbar("Error", '${response.body}',backgroundColor: Colors.red.shade400);
      }
    }catch(e){
      otpInProgress=false;
      update();
      Get.snackbar('Error', 'Something went wrong: ${e.toString()}');
    }
  }


}
