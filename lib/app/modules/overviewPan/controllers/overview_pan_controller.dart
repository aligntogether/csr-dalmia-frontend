import 'package:get/get.dart';

class OverviewPanController extends GetxController {
  String? selectP = "All Regions";
  String? selectLocation;
  RxBool openMenu = false.obs;

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

  List<String> locations = [
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
    'HH with Annual\nAddl. Income',
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
