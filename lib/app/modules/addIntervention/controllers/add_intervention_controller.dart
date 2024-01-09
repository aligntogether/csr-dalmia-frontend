import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInterventionController extends GetxController {
  Rx<TextEditingController> newInterventionTitle = TextEditingController().obs;
  Rx<TextEditingController> lever = TextEditingController().obs;
  Rx<TextEditingController> exAnnualIncome = TextEditingController().obs;
  Rx<TextEditingController> noOfDay = TextEditingController().obs;

  List<Map<String, dynamic>>? interventionsData;

  int? skipRecordsCount = 0;
  int? recordsCount = 20;
  int pageNumber = 0;
  int? totalInterventionsCount;


  void updateInterventionsData(List<Map<String, dynamic>> interventionsData) {
    this.interventionsData = interventionsData;
    update(["add"]);
  }


  List<String> interventionsList = [
    'Vermicompost-Bag (not less than 3 ft x 6 ft)',
  ];

  List<String> leverList = [
    "128036",
    "128036",
  ];

  List<int> expAddAnnualIncomeList = [
    128036,
    128036,

  ];
  List<int> daysRequiredList = [
    128036,
    128036,

  ];


}
