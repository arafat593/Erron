import 'package:errone/app/data/api_service/live_stream_provider/live_stream_provider.dart';
import 'package:errone/app/data/service/live_socket_service.dart';
import 'package:get/get.dart';

import '../controllers/live_controller.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveSocketService>(
            () => LiveSocketService());
    Get.lazyPut<LiveStreamProvider>(
            () => LiveStreamProvider());
    Get.lazyPut<LiveController>(
      () => LiveController(),
    );
  }
}
