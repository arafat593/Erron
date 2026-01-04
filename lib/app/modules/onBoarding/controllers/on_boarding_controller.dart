import 'dart:io';

import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';


class OnBoardingController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

Future<void> goToNextScreen() async {
    final isLoggedIn = await SharedPrefService.isLoggedIn;

    if (isLoggedIn) {
      final token = await SharedPrefService.getUserToken();
      final uri = Uri.parse('ws://eron.mtscorporate.com/api/v1/chat/ws?token=$token');
      final socket = await WebSocket.connect("$uri");
      print("////////////////${socket} ///// $uri");
      Get.offAllNamed(Routes.CUSTOM_BOTTOM_BAR);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
