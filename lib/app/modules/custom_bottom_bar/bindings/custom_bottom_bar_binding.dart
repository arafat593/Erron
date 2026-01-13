import 'package:errone/app/data/service/socket_service.dart';
import 'package:errone/app/modules/home/controllers/home_controller.dart';
import 'package:errone/app/modules/message/controllers/message_controller.dart';
import 'package:errone/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../data/api_service/live_stream_provider/live_stream_provider.dart';
import '../../../data/api_service/profile_provider/profile_provider.dart';
import '../controllers/custom_bottom_bar_controller.dart';

class CustomBottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProvider>(() => ProfileProvider());
    Get.lazyPut<LiveStreamProvider>(() => LiveStreamProvider());

    Get.lazyPut<CustomBottomBarController>(
            () => CustomBottomBarController());

    Get.lazyPut<HomeController>(
            () => HomeController(),
        fenix: true);

    Get.lazyPut<MessageController>(
            () => MessageController(),
        fenix: true);
    Get.lazyPut<ProfileController>(
            () => ProfileController(),
        fenix: true);

    Get.lazyPut<SocketService>(() => SocketService());
  }
}
