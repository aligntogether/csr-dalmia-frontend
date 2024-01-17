import 'package:get/get.dart';

class LocationWiseController extends GetxController {

  Map<String,dynamic>? allReport;

  void setAllReport(Map<String,dynamic> report){
    allReport = report;
    update();
  }


  List<String> details = [
    "target",
    'HH Alloted',
    'HH Selected',
    'No. of HHs with planned int.\nabove 50K and 1L EAAI',
    'No. of HHs with AAAI above\n 50K and 1L',

  ];
  List<String> details2 = [
    "target",
    'hhAlloted',
    'hhSelected',
    'plannedEaai',
    'actualAaai',

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
