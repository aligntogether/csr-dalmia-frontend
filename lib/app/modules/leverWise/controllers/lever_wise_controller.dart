import 'package:get/get.dart';

class LeverWiseController extends GetxController {
  RxBool openMenu = false.obs;
  Map<String,List<String>>?regionLocation;
  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
  List<Map<String, Map<String, dynamic>>>? leverWiseApiReportList;
  void updateRegionLocation(Map<String,List<String>> regionLocation){
    this.regionLocation=regionLocation;
    update(["add"]);
  }
  void updateLeverWiseApiReportList(List<Map<String, Map<String, dynamic>>> leverWiseApiReportList) {
    this.leverWiseApiReportList = leverWiseApiReportList;
    update(["add"]);
  }

  List<String> levers = [
    'Dalmia',
    'DIKSHA',
    'Non DIKSHA Skills',
    'ITI',
    'Sugar Cane Supply',
    'Agriculture',
    'Livestock',
    'Horticulture',
    'Water',
    'IGA',
    'Micro Enterprice',
  ];

  var allLocations = ["Dalmiapuram", "Ariyalur", "Belagaum", "Kadapa", "Chandrapur", "SOUTH",
    "Megalaya", "Umrangso", "Jagiroad", "Lanka","NE",
    "Cuttak", "Medinipur", "Bokaro", "Rajgangpur", "Kholapur", "EAST", "CEMENT",
    "Nigohi", "Ramgarh", "Jawaharpur", "Ninaidevi", "Kholapur", "SUGAR", "PANIND"];

  // var allLocations = ["Dalmiapuram", "Ariyalur", "Belagaum", "Kadapa", "Chandrapur",
  //   "Megalaya", "Umrangso", "Jagiroad", "Lanka",
  //   "Cuttak", "Medinipur", "Bokaro", "Rajgangpur", "Kholapur",
  //   "Nigohi", "Ramgarh", "Jawaharpur", "Ninaidevi", "Kholapur",];



}
