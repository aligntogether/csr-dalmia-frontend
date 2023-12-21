import 'package:get/get.dart';

class SourceFundsController extends GetxController {
  RxBool openMenu = false.obs;
  // String? selectP;
  String? selectLocation;
  Map<String, Map<String, dynamic>>? sourceOfFundsData;
  Map<String, Map<String, dynamic>>? regionWiseSourceOfFundsData;
  Map<String, Map<String, dynamic>>? locationWiseSourceOfFundsData;

  int? selectLocationId;
  int? selectRegionId;
  String? selectRegion ;

  List<Map<String, dynamic>>? locationsList;
  // List<Map<String, dynamic>>? panchayats;


  void updateSourceOfFundsData(Map<String, Map<String, dynamic>>? sourceFundsData) {
    this.sourceOfFundsData = sourceFundsData;
    update(["add"]);
  }

  void updateRegionWiseSourceOfFundsData(Map<String, Map<String, dynamic>>? regionWiseSourceFundsData) {
    this.regionWiseSourceOfFundsData = regionWiseSourceFundsData;
    update(["add"]);
  }

  void updateLocationWiseSourceOfFundsData(Map<String, Map<String, dynamic>>? locationWiseSourceFundsData) {
    this.locationWiseSourceOfFundsData = locationWiseSourceFundsData;
    update(["add"]);
  }

  void updateLocations(List<Map<String, dynamic>> locationsList) {
    this.locationsList = locationsList;
    update(["add"]);
  }

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  List<String> regions = [
    'DPM',
    'ALR',
    'BGM',
    'KDP',
    'CHA',
    'Total',
  ];


  List<String> clustersByLocation = [
    '<VDF 1>',
    '<VDF 2>',
    '<VDF 3>',
    '<VDF 4>',
    '<VDF 5>',
    'Total',
  ];
  List<int> lDPM = [
    128036,
    37765,
    387004,
    1687825,
    128036,
    37765,
    387004,
    1687825,

  ];

  List<String> locations = [
    'Cement',
    'South and Chandrapur',
    'East',
    'North East',
    'Total',
    'Sugar',
    'Pan-India',
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
  ];
  List<int> SOUTH = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
  ];

}
