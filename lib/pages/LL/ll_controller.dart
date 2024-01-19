import 'package:get/get.dart';

class LLController extends GetxController{
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}