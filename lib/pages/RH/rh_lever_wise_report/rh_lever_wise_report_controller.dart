import 'package:get/get.dart';

class RhLeverWiseController extends GetxController {
  RxBool openMenu = false.obs;

  String? rhId;

  List<dynamic>? regionByRhIdList;
  Map<String,dynamic>? rhLeverWiseReportByRegionId;
  String? selectedRegion;

  void updateRegionByRhIdList(List<dynamic> regionByRhIdList) {
    this.regionByRhIdList = regionByRhIdList;
    selectedRegion = regionByRhIdList[0]['region'];
    update();
  }

  void updateRhLeverWiseReportByRegionId(Map<String,dynamic> rhLeverWiseReportByRegionId) {
    this.rhLeverWiseReportByRegionId = rhLeverWiseReportByRegionId;
    update();
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
}
