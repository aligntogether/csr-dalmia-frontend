import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInterventionController extends GetxController {
  Rx<TextEditingController> newInterventionTitle = TextEditingController().obs;
  Rx<TextEditingController> lever = TextEditingController().obs;
  Rx<TextEditingController> exAnnualIncome = TextEditingController().obs;
  Rx<TextEditingController> noOfDay = TextEditingController().obs;

  List<String> interventions = [
    'Vermicompost-Bag (not less than 3 ft x 6 ft)',


  ];
  List<int> DPM = [
    128036,
    128036,

  ];
  List<int> ALR = [
    128036,
    128036,

  ];
  List<int> BGM = [
    128036,
    128036,

  ];
  List<int> KDP = [
    128036,
    128036,

  ];
  List<int> CHA = [
    128036,
    128036,

  ];


}
