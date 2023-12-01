import 'package:get/get.dart';

class AmountUtilizedController extends GetxController {
  List<String> locations = [
    'Budget Allocated',
    'Amount Utilized',


  ];
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
  List<int> DPM = [
    128036,
    37765,


  ];
  List<int> ALR = [
    128036,


    387004,
  ];
  List<int> BGM = [
    128036,
    37765,

  ];
  List<int> KDP = [
    128036,
    37765,

  ];
  List<int> CHA = [
    128036,
    37765,

  ];
  List<int> SOUTH = [
    128036,
    37765,

  ];
}
