import 'package:get/get.dart';

class SourceFundsController extends GetxController {
  RxBool openMenu = false.obs;
  String? selectP ;
  String? selectLocation = "South & Chandrapur";
  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  List<String> regions = [
    'DPM',
    'ALR',
    'BGM',
    'KDP',
    'CHA',
    'Total',
  ];
  List<String> regionsByLocation = [
    '<VDF 1>',
    '<VDF 2>',
    '<VDF 3>',
    '<VDF 4>',
    '<VDF 5>',
    'Total',
  ];
  List<int> lDPM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,

  ];
  List<String> locations = [
    'Cement',
    'South',
    'East',
    'N.East',
    'Total',
    'Sugar',
    'Pan-India',


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
  ];

}