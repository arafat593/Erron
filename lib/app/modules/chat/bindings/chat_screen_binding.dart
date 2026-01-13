import 'package:get/get.dart';
import '../../message/models/active_user_model.dart';
import '../controllers/chat_controller.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ChatController>(
    //   () => ChatController(),
    // );
    Get.lazyPut<ChatController>(() {
      final user = Get.arguments as ActiveUser;
      return ChatController(user);
    });
  }
}
