import 'package:get/get.dart';

class GeneralInfoController extends GetxController {
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
  String? selectLocation ="All Regions";
  List<String> locations = [
    'Dalmiapuram',
    'Total',

  ];
  List<int> DPM = [
    128036,
    128036,

  ];
  List<int> ALR = [
    128036,
    128036,

  ];
  List<int> BGM = [
    128036,
    128036,

  ];
  List<int> KDP = [
    128036,
    128036,

  ];
  List<int> CHA = [
    128036,
    128036,

  ];


}
