import 'package:get/get.dart';
import 'package:flutter/material.dart';
class AddLocationController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  String? selectLocation;
  int selectedIndex = -1;
  List locationList = [
     "1 Cluster",
     "2 Cluster",
     "3 Cluster",
     "4 Cluster",
     "5 Cluster",
  ];
  @override
  void onInit() {
    super.onInit();
  }
}