import 'package:dalmia/app/modules/overviewPan/service/overviewReportApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class OverviewPanController extends GetxController {
  final OverviewReportApiService overviewReportApiService =
      new OverviewReportApiService();
  late List<Map<String, Map<String, dynamic>>> panIndiaMappedData;
  late List<Map<String, Map<String, dynamic>>> overviewMappedListRes;
  void getPanIndiaReport() async {
    panIndiaMappedData = await overviewReportApiService.getPanIndiaReport(
        allLocations, objectKeys);
    overviewMappedListRes =
        await overviewReportApiService.overViewMappedListFun();
  }

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

  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }

  void updateClusters(List<Map<String, dynamic>> clusters) {
    this.clusters = clusters;
    update(["add"]);
  }

  void updateOverviewMappedList(
      List<Map<String, Map<String, dynamic>>> overviewMappedList) {
    this.overviewMappedList = overviewMappedList;
    update(["add"]);
  }

  void updateRegionWiseMappedList(
      List<Map<String, Map<String, dynamic>>> regionWiseMappedList) {
    this.regionWiseMappedList = regionWiseMappedList;
    update(["add"]);
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> makeExcel() async {
    getPanIndiaReport();

    //test

    print(panIndiaMappedData[0]['planned']!['ALR']);

    // // print(panIndiaMappedData[0]['allotted']);
    // // print(panIndiaMappedData[0]['mapped']);
    // // print(panIndiaMappedData[0]['selected']);
    // // print(panIndiaMappedData[0]['totalHouseholds']);

    // print(panIndiaMappedData.length);

    // Create a new Excel workbook
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];
    print("i am here 3");

    sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
        .value = "locations";

    // Add headers to the Excel sheet
    for (int col = 1; col <= allLocations.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0))
          .value = allLocations[col - 1];
    }
    //add value to first column
    for (int i = 0; i < locationsList.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = locationsList[i];
    }

    // Add data to the Excel sheet

    for (int row = 1; row <= 3; row++) {
      for (int col = 1; col <= allLocations.length; col++) {
        sheetObject
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: col, rowIndex: row + 1))
                .value =
            panIndiaMappedData[0][objectKeys[row - 1]]![allLocations[col - 1]];
        ;
      }
    }

    for (int col = 1; col <= allLocations.length; col++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 6))
          .value = panIndiaMappedData[0][objectKeys[3]]![allLocations[col - 1]];
      ;
    }

    for (int row = 7; row <= 11; row++) {
      for (int col = 1; col <= allLocations.length; col++) {
        sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            panIndiaMappedData[0][objectKeys[row - 3]]![allLocations[col - 1]];
        ;
      }
    }
    for (int row = 13; row <= 19; row++) {
      for (int col = 1; col <= allLocations.length; col++) {
        sheetObject
                .cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row))
                .value =
            overviewMappedList![0][objectKeys[row - 4]]![allLocations[col - 1]];
        ;
      }
    }

    // Save the Excel file
    final file = await getDownloadPath();
    print("i am here 2");
    print("file path $file");
    await File(file.toString() + "/gplPanIndiaReport.xlsx")
        .writeAsBytes(await excel.encode()!);
  }

  Future<void> downloadExcel(BuildContext context) async {
    try {
      await makeExcel();
      print("i am here 1");
      // Provide the path where the Excel file is saved
      final file = await getDownloadPath();
      OpenFile.open("$file/ex.xlsx");

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Successful'),
            content: Text('The Excel file has been downloaded successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Error'),
            content:
                Text('An error occurred while downloading the Excel file.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void onTapOpenMenu() {
    openMenu.value = !openMenu.value;
    update();
  }

  var allLocations = [
    "DPM",
    "ALR",
    "BGM",
    "KDP",
    "CHA",
    "SOUTH",
    "MEG",
    "UMG",
    "JGR",
    "LAN",
    "NE",
    "CUT",
    "MED",
    "BOK",
    "RAJ",
    "KAL",
    "EAST",
    "CEMENT",
    "NIG",
    "RAM",
    "JOW",
    "NIN",
    "KOL",
    "SUGAR",
    "PANIND"
  ];

  var objectKeys = [
    "allotted",
    "mapped",
    "selected",
    "hhCovered",
    "planned",
    "completed",
    "householdWithAtLeast1Completed",
    "noInterventionPlanned",
    "followupOverdue",
    "zeroAdditionalIncome",
    "lessThan25KIncome",
    "between25KTO50KIncome",
    "between50KTO75KIncome",
    "between75KTO1LIncome",
    "moreThan1LIncome",
    "mapped"
  ];

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
    'HH with Annual\nAddl. Income',
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
