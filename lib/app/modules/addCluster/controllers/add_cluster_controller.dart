import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClusterController extends GetxController {
  String? selectLocation;
  int? selectLocationId;
  String? selectRegion;
  int? selectRegionId;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> vdfNameController = TextEditingController().obs;
  Rx<TextEditingController> vdfMobileController = TextEditingController().obs;
  int? clusterCounts = 0;
  String? addedClusterName;
  int? addedClusterId;



  List<Map<String, dynamic>>? locations;
  List<Map<String, dynamic>>? panchayats;


  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }

  void updatePanchayats(List<Map<String, dynamic>> panchayats) {
    this.panchayats = panchayats;
    update(["add"]);
  }



}
