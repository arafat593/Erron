import 'dart:convert';
import 'dart:io';

import 'package:errone/app/data/api_service/auth_api_service/auth_api_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool obSecure=true.obs;
  void changeObSecure(){
    obSecure.value = !obSecure.value;
  }

  bool signInProgress = false;
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passTEController = TextEditingController();

  Future<void> getSignIn() async {
    signInProgress = true;
    update();
    try {
      final response =
      await AuthApiService.signInRequest(Urls.login, <String, dynamic>{
        "username": emailTEController.text.trim(),
        "password": passTEController.text,
      });


      signInProgress = false;
      update();
      print(response.body);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final token = decodedResponse["access_token"];
        await SharedPrefService.saveUserToken(token);
     /*   //await Get.find<SocketService>().connect();
      final uri = Uri.parse('ws://eron.mtscorporate.com/api/v1/chat/ws?token=$token');
      final socket =
      await WebSocket.connect("$uri");*/

        Get.snackbar("Success", "Login Successful");
        await Future.delayed(Duration(milliseconds: 300));
        Get.offAllNamed(Routes.CUSTOM_BOTTOM_BAR);
        emailTEController.clear();
        passTEController.clear();
      } else {
        print("${response.body}");
        Get.snackbar("Failed", response.body);
      }
    } catch (e) {
      signInProgress = false;
      update();
      Get.snackbar('Error', 'Something went wrong: ${e.toString()}');

    }
  }
}
