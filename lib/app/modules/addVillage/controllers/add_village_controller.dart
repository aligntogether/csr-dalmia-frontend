import 'package:get/get.dart';

class AddVillageController extends GetxController {
  String? selectLocation;
  int? selectLocationId;
  String? selectRegion;
  int? selectRegionId;
  String? selectPanchayat;
  int? selectPanchayatId;
  String? villageNameValue;
  String? villageCodeValue;

  List<Map<String, dynamic>>? locations;
  List<Map<String, dynamic>>? panchayats;
  List<Map<String, dynamic>>? villages;

  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }

  void updatePanchayats(List<Map<String, dynamic>> panchayats) {
    this.panchayats = panchayats;
    update(["add"]);
  }

  void updateVillages(List<Map<String, dynamic>> villages) {
    this.villages = villages;
    update(["add"]);
  }


  // != null ? villages
  //     .map((village) => village['villageName'].toString())
  //     .toList() : [];
}
