import 'package:get/get.dart';

import '../controllers/email_verification_code_controller.dart';

class EmailVerificationCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationCodeController>(
      () => EmailVerificationCodeController(),
    );
  }
}
