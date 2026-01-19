import 'package:errone/app/modules/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';

import '../../../data/api_service/chat_service/chat_socket_service.dart';


class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );

    Get.lazyPut<ChatSocketService>(
            () => ChatSocketService());

  }
}
