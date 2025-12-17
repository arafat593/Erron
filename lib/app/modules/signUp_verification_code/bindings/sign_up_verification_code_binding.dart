import 'package:get/get.dart';

import '../controllers/sign_up_verification_code_controller.dart';

class SignUpVerificationCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpVerificationCodeController>(
      () => SignUpVerificationCodeController(),
    );
  }
}
