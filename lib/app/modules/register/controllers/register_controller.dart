import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool obSecure=true.obs;
  RxBool isObSecure=true.obs;
  void changeObSecure(){
    obSecure.value = !obSecure.value;
  }

  void changeIsObSecure(){
    isObSecure.value = !isObSecure.value;
  }

}
