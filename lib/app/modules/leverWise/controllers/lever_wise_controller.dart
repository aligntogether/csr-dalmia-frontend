import 'package:get/get.dart';

class LeverWiseController extends GetxController {
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
  List<String> locations = [
    'Diksha',
    'ITI',
    'Water',
    'Agriculture',
    'Horticulture',
    'ME',
    'LS ',
    'SGH  ',
    'FPO',
    'Other',
    'Total',

  ];
  List<int> DPM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,

  ];
  List<int> ALR = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> BGM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> KDP = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> CHA = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> SOUTH = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];

}
