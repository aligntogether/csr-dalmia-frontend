import 'package:get/get.dart';

class VDFController extends GetxController{
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}