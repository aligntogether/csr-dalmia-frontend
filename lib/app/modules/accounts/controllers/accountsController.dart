import 'package:get/get.dart';

class AccountsController extends GetxController {
  RxBool openMenu = false.obs;
  // String? selectP;

  String? selectLocation;
  int? selectLocationId;
  int? selectRegionId;
  String? selectRegion;
  int? selectClusterId;
  String? selectcluster;
  List<Map<String, dynamic>>? locationsList;
  List<Map<String, dynamic>>? clustersList;

  void updateLocations(List<Map<String, dynamic>> locationsList) {
    this.locationsList = locationsList;
    update(["add"]);
  }

  void updatecluster(List<Map<String, dynamic>> ClusterList) {
    this.clustersList = ClusterList;
    update(["add"]);
  }

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }
}
