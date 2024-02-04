import 'package:get/get.dart';

class RhHomeController extends GetxController{
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}