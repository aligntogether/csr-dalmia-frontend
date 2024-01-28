import 'package:get/get.dart';

class OverviewPanController extends GetxController {
  // String? selectP = "All Regions";
  String? selectLocation;
  RxBool openMenu = false.obs;

  int? selectLocationId;
  String? selectRegion;
  int? selectRegionId;
  String? selectCluster;
  int? selectClusterId;

  List<Map<String, dynamic>>? locations;
  List<Map<String, dynamic>>? clusters;
  List<Map<String, Map<String, dynamic>>>? overviewMappedList;
  List<Map<String, Map<String, dynamic>>>? regionWiseMappedList;
  List<Map<String, Map<String, dynamic>>>? locationWiseMappedList;
  Map<String,List<String>>?regionLocation;
  List<String>? particularWiseList;
  List<String>? vdfNames;

  void updateRegionLocation(Map<String,List<String>> regionLocation){
    this.regionLocation=regionLocation;
    update(["add"]);
  }

  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }

  void updateClusters(List<Map<String, dynamic>> clusters) {
    this.clusters = clusters;
    update(["add"]);
  }

  void updateOverviewMappedList(List<Map<String, Map<String, dynamic>>> overviewMappedList) {
    this.overviewMappedList = overviewMappedList;
    update(["add"]);
  }

  void updateParticularWiseList(List<String> particularWiseList) {
    this.particularWiseList = particularWiseList;
    update(["add"]);
  }

  void updateLocationVdfNames(List<String> vdfNames) {
    this.vdfNames = vdfNames;
    update(["add"]);
  }

  void updateRegionWiseMappedList(List<Map<String, Map<String, dynamic>>> regionWiseMappedList) {
    this.regionWiseMappedList = regionWiseMappedList;
    update(["add"]);
  }
  void updateLocationWiseMappedList(List<Map<String, Map<String, dynamic>>> locationWiseMappedList) {
    this.locationWiseMappedList = locationWiseMappedList;
    update(["add"]);
  }




  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  var allLocations = ["DPM", "ALR", "BGM", "KDP", "CHA", "SOUTH",
    "MEG", "UMG", "JGR", "LAN","NE",
    "CUT", "MED", "BOK", "RAJ", "KAL", "EAST", "CEMENT",
    "NIG", "RAM", "JOW", "NIN", "KOL", "SUGAR", "PANIND"];

  var objectKeys = ['Households',"allotted", "mapped", "selected",
    'Interventions', "hhCovered", "planned", "completed",
    "householdWithAtLeast1Completed", "noInterventionPlanned", "followupOverdue",
    'HH with Annual Addl. Income', "zeroAdditionalIncome", "lessThan25KIncome",
    "between25KTO50KIncome", "between50KTO75KIncome", "between75KTO1LIncome",
    "moreThan1LIncome", "mapped"];


  List<String> regions = [
    'DPM',
    'ALR',
    'BGM',
    'KDP',
    'CHA',
    'Total',
  ];

  List<String> locationsListMapping = [
    'Households',
    'allotted',
    'mapped',
    'selected',
    'Interventions',
    'hhCovered',
    'planned',
    'completed',
    'householdWithAtLeast1Completed',
    'noInterventionPlanned',
    'followupOverdue',
    'HH with Annual Addl. Income',
    'zeroAdditionalIncome',
    'lessThan25KIncome',
    'between25KTO50KIncome',
    'between50KTO75KIncome',
    'between75KTO1LIncome',
    'moreThan1LIncome',
    'mapped',
  ];

  List<String> locationsList = [
    'Households',
    'Alloted',
    'Mapped',
    'Selected',
    'Interventions',
    'HH Covered',
    'Planned',
    'Completed',
    'HH with atleast\n1 int. completed ',
    'HH with no int.\nplanned',
    'F/u overdue',
    'HH with Annual Addl. Income',
    '0',
    '< 25K',
    '25K - 50K',
    '50K - 75K',
    '75K - 1L',
    '>1L',
    'Total no. of HH',
  ];


  List<int> DPM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> ALR = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> BGM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> KDP = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> CHA = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];
  List<int> SOUTH = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
