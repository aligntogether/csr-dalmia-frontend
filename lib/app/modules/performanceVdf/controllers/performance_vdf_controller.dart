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
  List<Map<String, dynamic>>? locations;
  List<Map<String, dynamic>>? clusters;

  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
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
}
