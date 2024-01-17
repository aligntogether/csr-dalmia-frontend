import 'package:get/get.dart';

class PerformanceVdfController extends GetxController {
  RxBool openMenu = false.obs;
  String? selectLocation;
  int? selectLocationId;
  String? selectRegion;
  int? selectRegionId;
  String? selectCluster;
  int? selectClusterId;
  String? selectVdfName;
  int? selectVdfId;
  List<String>? headerList;
  List<Map<String, dynamic>>? locations;
  List<Map<String, dynamic>>? clusters;
  Map<String, dynamic>? performanceReport;
  List<String>? details;

  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }
  void updateHeaderList(List<String> headerList) {
    this.headerList = headerList;
    update(["add"]);
  }
  void updateDetails(List<String> details) {
    this.details = details;
    update(["add"]);
  }

  void updateClusters(List<Map<String, dynamic>> clusters) {
    this.clusters = clusters;
    update(["add"]);
  }

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  void updatePerformanceReport(Map<String, dynamic> performanceReport) {
    this.performanceReport = performanceReport;
    update(["add"]);
  }


}
