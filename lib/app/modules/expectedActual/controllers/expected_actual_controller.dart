import 'package:get/get.dart';

class ExpectedActualController extends GetxController {
  RxBool openMenu = false.obs;


  Map<String, dynamic>? expectedActualReport;
  List<String>? clusterIdList;

  Map<String, dynamic>? clusterList;

  List<String>? clusterPropertyKeys;

  void updateExpectedActualReport(
      Map<String, dynamic>
    expectedActualReport) {
    this.expectedActualReport = expectedActualReport;
    update();
  }
  void updateClusterIdList(List<String> clusterIdList) {
    this.clusterIdList = clusterIdList;
    update();
  }
  void updateClusterList(Map<String, dynamic> clusterList) {
    this.clusterList = clusterList;
    update();
  }
  void updateClusterPropertyKeys(List<String> clusterPropertyKeys){
    this.clusterPropertyKeys = clusterPropertyKeys;
    update();
  }
  var allLocations = [
    "Dalmiapuram",
    "Ariyalur",
    "Belagaum",
    "Kadapa",
    "Chandrapur",
    "SOUTH",
    "Megalaya",
    "Umrangso",
    "Jagiroad",
    "Lanka",
    "NE",
    "Cuttak",
    "Medinipur",
    "Bokaro",
    "Rajgangpur",
    "Kholapur",
    "EAST",
    "CEMENT",
    "Nigohi",
    "Ramgarh",
    "Jawaharpur",
    "Ninaidevi",
    "Kholapur",
    "SUGAR",
    "PANIND"
  ];
}