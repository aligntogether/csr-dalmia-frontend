import 'package:get/get.dart';

class LeverWiseController extends GetxController {
  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
  List<Map<String, Map<String, dynamic>>>? leverWiseApiReportList;

  void updateLeverWiseApiReportList(List<Map<String, Map<String, dynamic>>> leverWiseApiReportList) {
    this.leverWiseApiReportList = leverWiseApiReportList;
    update(["add"]);
  }

  List<String> levers = [
    'Agriculture',
    'Horticulture',
    'Livestock',
    'Water',
    'IGA',
    'Non DIKSHA Skills',
    'Micro Enterprise',
  ];

  var allLocations = ["Dalmiapuram", "Ariyalur", "Belagaum", "Kadapa", "Chandrapur", "SOUTH",
    "Megalaya", "Umrangso", "Jagiroad", "Lanka","NE",
    "Cuttak", "Medinipur", "Bokaro", "Rajgangpur", "Kholapur", "EAST", "CEMENT",
    "Nigohi", "Ramgarh", "Jawaharpur", "Ninaidevi", "Kholapur", "SUGAR", "PANIND"];

  // var allLocations = ["Dalmiapuram", "Ariyalur", "Belagaum", "Kadapa", "Chandrapur",
  //   "Megalaya", "Umrangso", "Jagiroad", "Lanka",
  //   "Cuttak", "Medinipur", "Bokaro", "Rajgangpur", "Kholapur",
  //   "Nigohi", "Ramgarh", "Jawaharpur", "Ninaidevi", "Kholapur",];



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
