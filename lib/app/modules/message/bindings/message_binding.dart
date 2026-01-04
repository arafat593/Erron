import 'package:get/get.dart';

import '../../../data/service/socket_service.dart';
import '../controllers/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SocketService(), permanent: true);

    Get.lazyPut<MessageController>(
      () => MessageController(),
      fenix: true
    );
  }
}
