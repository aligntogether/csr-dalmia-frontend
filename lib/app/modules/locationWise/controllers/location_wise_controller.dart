import 'package:get/get.dart';

class LocationWiseController extends GetxController {
  List<String> locations = [
    'HH Alloted',
    'HH Selected',
    'No. of HHs with planned int.\nabove 50K and 1L EAAI',
    'No. of HHs with AAAI above\n 50K and 1L',

  ];
  List<int> DPM = [
    128036,
    37765,
    387004,
    1687825,

  ];

  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
