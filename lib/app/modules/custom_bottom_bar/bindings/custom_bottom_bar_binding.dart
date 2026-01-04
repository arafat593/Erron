import 'package:errone/app/data/service/socket_service.dart';
import 'package:errone/app/modules/home/controllers/home_controller.dart';
import 'package:errone/app/modules/message/controllers/message_controller.dart';
import 'package:get/get.dart';

import '../controllers/custom_bottom_bar_controller.dart';

class CustomBottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomBottomBarController>(
      () => CustomBottomBarController(),
    );

    Get.lazyPut<HomeController>(
        () => HomeController(),
    );

    // Get.lazyPut<MessageController>(
    //       () => MessageController(),
    // );
    Get.lazyPut<MessageController>(
          () => MessageController(),
    );

    Get.lazyPut<SocketService>(
          () => SocketService(),
      fenix: true,
    );
  }
}
