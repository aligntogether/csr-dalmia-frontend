import 'package:get/get.dart';

class AddPanchayatController extends GetxController {
  String? selectLocation;
  int? selectLocationId;
  int? selectRegionId;
  int? selectClusterId;
  String? selectRegion;
  String? panchayatNameValue;
  String? panchayatCodeValue;
  String? selectCluster;
  String? cluster;
  List<Map<String, dynamic>>? locations;
  List<String>? panchayats;


  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }

  void updatePanchayats(List<String> panchayats) {
    this.panchayats = panchayats;
    update(["add"]);
  }

}
