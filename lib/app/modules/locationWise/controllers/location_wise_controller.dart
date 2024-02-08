import 'package:get/get.dart';

class LocationWiseController extends GetxController {

  Map<String,dynamic>? allReport;

  Map<String,List<String>>?regionLocation;

  void setAllReport(Map<String,dynamic> report){
    allReport = report;
    update();
  }

  void updateRegionLocation(Map<String,List<String>> regionLocation){
    this.regionLocation=regionLocation;
    update();
  }


  List<String> details = [
    'HH Alloted',
    'HH Selected',
    'No. of HHs with planned int.',
    'No. of HHs with AAAI',

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
