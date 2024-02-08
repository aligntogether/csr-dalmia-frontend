import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReplaceVdfController extends GetxController {

  String? selectLocation;
  int? selectLocationId;
  String? selectRegion;
  int? selectRegionId;
  String? selectCluster;
  int? selectClusterId;
  String? selectVdfName;
  String? selectVdfContact;
  Rx<TextEditingController> newVdfNameController = TextEditingController().obs;
  Rx<TextEditingController> newVdfContactController = TextEditingController().obs;
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

}
