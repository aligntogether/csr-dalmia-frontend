import 'package:get/get.dart';

class CdoController extends GetxController{
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}