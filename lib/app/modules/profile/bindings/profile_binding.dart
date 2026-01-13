import 'package:get/get.dart';

import '../../../data/api_service/live_stream_provider/live_stream_provider.dart';
import '../../../data/api_service/profile_provider/profile_provider.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<ProfileProvider>(() => ProfileProvider());
    Get.lazyPut<LiveStreamProvider>(() => LiveStreamProvider());

    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
  }
}
