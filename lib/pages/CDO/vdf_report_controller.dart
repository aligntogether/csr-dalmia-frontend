import 'package:get/get.dart';

class VDFReportController extends GetxController{
  String? selectLocation;
  RxBool openMenu = false.obs;

  int? selectLocationId;
  String? selectRegion;
  String? selectedRegion;

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
  List<dynamic>? regionByRhIdList;
  void updateRegionByRhId(List<dynamic> regionByRhIdList){
    this.regionByRhIdList=regionByRhIdList;
    selectedRegion = regionByRhIdList[0]['region'];
    update(["add"]);
  }

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


  var objectKeys = ['Households',"allotted", "mapped", "selected",
    'Interventions', "hhCovered", "planned", "completed",
    "householdWithAtLeast1Completed", "noInterventionPlanned", "followupOverdue",
    'HH with Annual Addl. Income', "zeroAdditionalIncome", "lessThan25KIncome",
    "between25KTO50KIncome", "between50KTO75KIncome", "between75KTO1LIncome",
    "moreThan1LIncome", "mapped"];

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

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

}