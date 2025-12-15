import 'package:get/get.dart';

import '../controllers/live_video_controller.dart';

class LiveVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveVideoController>(
      () => LiveVideoController(),
    );
  }
}
