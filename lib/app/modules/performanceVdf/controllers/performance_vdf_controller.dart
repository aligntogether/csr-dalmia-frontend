import 'package:get/get.dart';

class PerformanceVdfController extends GetxController {
  RxBool openMenu = false.obs;
  String? selectP ;
  String? selectVdf ;
  String? selectLocation = "South & Chandrapur";
  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}
