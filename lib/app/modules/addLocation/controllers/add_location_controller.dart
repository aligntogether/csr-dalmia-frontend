import 'package:get/get.dart';
import 'package:flutter/material.dart';
class AddLocationController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> codeController = TextEditingController().obs;
  String? selectLocation;
  int selectedIndex = -2;
  List locationList = [
     "1 Cluster",
     "2 Cluster",
     "3 Cluster",
     "4 Cluster",
     "5 Cluster",
  ];
  String? selectRegion;
  int? selectRegionId;
  String? locationValue;


  @override
  void onInit() {
    super.onInit();
  }
}
