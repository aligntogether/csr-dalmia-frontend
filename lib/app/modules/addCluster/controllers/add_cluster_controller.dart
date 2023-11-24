import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClusterController extends GetxController {
  String? selectLocation;
  String? selectRegion;
  String? selectP;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> vdfController = TextEditingController().obs;

}
