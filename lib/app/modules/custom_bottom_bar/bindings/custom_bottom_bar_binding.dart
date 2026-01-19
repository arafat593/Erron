import 'package:errone/app/modules/home/controllers/home_controller.dart';
import 'package:errone/app/modules/live_stream/controllers/live_stream_controller.dart';
import 'package:errone/app/modules/message/controllers/message_controller.dart';
import 'package:errone/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../../../data/api_service/profile_provider/profile_provider.dart';
import '../../../data/api_service/chat_service/chat_socket_service.dart';
import '../controllers/custom_bottom_bar_controller.dart';

class CustomBottomBarBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CustomBottomBarController>(
            () => CustomBottomBarController());

    Get.lazyPut<HomeController>(
            () => HomeController(),
        fenix: true);

    Get.lazyPut<LiveStreamController>(
            () => LiveStreamController(),
        fenix: true);

    Get.lazyPut<MessageController>(
            () => MessageController(),
        fenix: true);
    Get.lazyPut<ChatSocketService>(
            () => ChatSocketService(),
        fenix: true);
    Get.lazyPut<ProfileController>(
            () => ProfileController(),
        fenix: true);

    Get.lazyPut<ProfileProvider>(
            () => ProfileProvider(),
        fenix: true);
  }
}
