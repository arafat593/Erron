import 'package:get/get.dart';
class NewPasswordController extends GetxController {

  RxBool select1= true.obs;
  RxBool select2= true.obs;

  void changeSelect1() {
    select1.value = !select1.value;
  }
  void changeSelect2(){
    select2.value = !select2.value;
  }
}
