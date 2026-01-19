import 'package:get/get.dart';
import '../../../data/api_service/profile_provider/profile_provider.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<ProfileProvider>(() => ProfileProvider());


    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
  }
}
