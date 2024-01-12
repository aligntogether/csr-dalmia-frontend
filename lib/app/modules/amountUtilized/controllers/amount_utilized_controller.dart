import 'package:get/get.dart';

class AmountUtilizedController extends GetxController {


  List<Map<String, Map<String, dynamic>>>? amountUtilizedMappedList;
  List<String>? rhlocationsList;


  List<String> locations = [
    'Budget Allocated',
    'Amount Utilized',
  ];

  RxBool openMenu = false.obs;

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }


  var allLocations = ["DPM", "ALR", "BGM", "KDP", "CHA", "SOUTH",
    "MEG", "UMG", "JGR", "LAN","NE",
    "CUT", "MED", "BOK", "RAJ", "KAL", "EAST", "CEMENT",
    "NIG", "RAM", "JOW", "NIN", "KOL", "SUGAR", "PANIND"];

  var rhRegions = [
    {
      "SOUTH": {"DPM", "ALR", "BGM", "KDP", "CHA"},
      "SUGAR": {"NIG", "RAM", "JOW", "NIN", "KOL"}
    }
  ];


  var objectKeys = ["allocated", "utilized"];



  void updateAmountUtilizedMappedList(List<Map<String, Map<String, dynamic>>> amountUtilizedMappedList) {
    this.amountUtilizedMappedList = amountUtilizedMappedList;
    update(["add"]);
  }

  void updateRHLocationsList(List<String> rhlocationsList) {
    this.rhlocationsList = rhlocationsList;
    update(["add"]);
  }

  List<int> DPM = [
    128036,
    37765,


  ];
  List<int> ALR = [
    128036,


    387004,
  ];
  List<int> BGM = [
    128036,
    37765,

  ];
  List<int> KDP = [
    128036,
    37765,

  ];
  List<int> CHA = [
    128036,
    37765,

  ];
  List<int> SOUTH = [
    128036,
    37765,

  ];
}
