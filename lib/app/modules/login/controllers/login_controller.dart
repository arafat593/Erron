import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool obSecure=true.obs;
  void changeObSecure(){
    obSecure.value = !obSecure.value;
  }
}
