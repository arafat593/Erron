import 'package:get/get.dart';

import '../controllers/viewer_live_controller.dart';

class ViewerLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewerLiveController>(
      () => ViewerLiveController(),
    );
  }
}
