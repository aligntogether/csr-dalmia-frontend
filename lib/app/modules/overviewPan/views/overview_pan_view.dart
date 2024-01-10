import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/overview_pan_controller.dart';
import '../service/overviewReportApiService.dart';

class OverviewPanView extends StatefulWidget {
  OverviewPanView({Key? key}) : super(key: key);

  @override
  _OverviewPanViewState createState() => new _OverviewPanViewState();
}

class _OverviewPanViewState extends State<OverviewPanView> {
  final OverviewReportApiService overviewReportApiService =
      new OverviewReportApiService();

  OverviewPanController controller = Get.put(OverviewPanController());
  late Future<Map<String, dynamic>> regionsFuture;
  late Future<Map<String, dynamic>> clustersFuture;
  ExportTableToExcel exportsTableToExcel = new ExportTableToExcel();

  void downloadExcel() {
    try {
      exportsTableToExcel.exportPanIndiaReportAllRegion(
        controller,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Successful'),
            content: Text(
                'The Excel file has been downloaded successfully in your download folder.'),
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

  @override
  void initState() {
    super.initState();
    getPanIndiaReport();
    regionsFuture = overviewReportApiService.getListOfRegions();
    controller.selectRegion = "All Regions";
  }

  void getPanIndiaReport() async {
    List<Map<String, Map<String, dynamic>>> panIndiaMappedData =
        await overviewReportApiService.getPanIndiaReport(
            controller.allLocations, controller.objectKeys);

    setState(() {
      controller.updateOverviewMappedList(panIndiaMappedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    OverviewPanController overviewPanController =
        Get.put(OverviewPanController());
    final int rowCount = 20;
    final int columnCount = 5;
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,
              centerAlignText: true, title: "Reports"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Space.height(16),

                ///_________________________________ main menu __________________________///
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Space.width(16),
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 18,
                      ),
                      Text(
                        "Main Menu",
                        style: AppStyle.textStyleInterMed(fontSize: 14),
                      ),
                      Spacer(),
                      viewOtherReports(context),
                      Space.width(16),
                    ],
                  ),
                ),
                Space.height(34),

                ///_________________________________ drop downs__________________________///
                GetBuilder<OverviewPanController>(
                  id: "add",
                  builder: (controller) {
                    return FutureBuilder<Map<String, dynamic>>(
                      // Assuming that getListOfRegions returns a Future<Map<String, dynamic>>
                      future: regionsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          Map<String, dynamic> responseData =
                              snapshot.data ?? {};

                          if (responseData.containsKey('regions')) {
                            List<Map<String, dynamic>> regionOptions =
                                responseData['regions'];

                            return CustomDropdownFormField(
                              title: "Select a Region",
                              options: regionOptions
                                  .map((region) => region['region'].toString())
                                  .toList(),
                              selectedValue: controller.selectRegion,
                              onChanged: (String? newValue) async {
                                Map<String, dynamic>? selectedRegion;

                                if (newValue == "All Regions") {
                                  setState(() {
                                    controller.selectRegion = newValue;
                                    controller.selectLocation = null;
                                    controller.selectLocationId = null;
                                    controller.locations = List.generate(
                                        1,
                                        (index) => <String, dynamic>{
                                              "location": "No Data Found"
                                            });
                                  });
                                } else {
                                  // Find the selected region and get its corresponding regionId
                                  selectedRegion =
                                      regionOptions.firstWhereOrNull((region) =>
                                          region['region'] == newValue);
                                }

                                // print('controller.selectedRegions: ${selectedRegion}');

                                if (selectedRegion != null &&
                                    selectedRegion['regionId'] != null) {
                                  controller.selectRegionId =
                                      selectedRegion['regionId'];
                                  controller.selectRegion = newValue;

                                  controller.update(["add"]);

                                  // Get locations based on the selected regionId
                                  Map<String, dynamic> locationsData =
                                      await overviewReportApiService
                                          .getListOfLocations(
                                              controller.selectRegionId!);

                                  // Extract the list of locations from the returned data
                                  List<Map<String, dynamic>> locations =
                                      locationsData['locations'];

                                  // Update the controller with the new list of locations
                                  controller.updateLocations(locations);
                                  controller.update(["add"]);

                                  List<String> locationsCode = locations != null
                                      ? (controller.locations!
                                          .map((location) =>
                                              location['locationCode']
                                                  .toString())
                                          .toList())
                                      : [];
                                  locationsCode.add("TOTAL");

                                  List<Map<String, Map<String, dynamic>>>
                                      regionWiseMappedList =
                                      await overviewReportApiService
                                          .getRegionWiseReport(
                                              locationsCode,
                                              controller.objectKeys,
                                              controller.selectRegionId!);

                                  setState(() {
                                    controller.updateRegionWiseMappedList(
                                        regionWiseMappedList);
                                  });

                                  setState(() {
                                    controller.selectLocation = null;
                                    controller.selectLocationId = null;
                                    // controller.selectCluster = null;
                                  });
                                }
                              },
                            );
                          } else {
                            return Text('No regions available');
                          }
                        }
                      },
                    );
                  },
                ),
                Space.height(10),

                ///_________________________________ drop downs__________________________///
                controller.selectRegion != "All Regions"
                    ? GetBuilder<OverviewPanController>(
                        id: "add",
                        builder: (controller) {
                          return CustomDropdownFormField(
                            title: "Select Location",
                            options: controller.locations != null
                                ? (controller.locations!
                                    .map((location) =>
                                        location['location'].toString())
                                    .toList())
                                : [],
                            selectedValue: controller.selectLocation,
                            onChanged: (String? newValue) async {
                              // Find the selected location and get its corresponding locationId
                              if (controller.locations != null) {
                                // Find the selected location object based on the 'location' property

                                // print('controller.locations: ${controller.locations}');

                                Map<String, dynamic>? selectedLocation =
                                    controller.locations?.firstWhere(
                                        (location) =>
                                            location['location'] == newValue);

                                if (selectedLocation != null) {
                                  // Access the locationId property and convert it to int
                                  int? selectedLocationId =
                                      selectedLocation['locationId'];

                                  // print('selectedLocationId: $selectedLocationId');

                                  if (selectedLocationId != null) {
                                    // Assign 'location' to controller.selectLocation

                                    setState(() {
                                      controller.selectLocationId =
                                          selectedLocationId;
                                      controller.selectLocation =
                                          selectedLocation['location']
                                              as String;
                                    });

                                    controller.update(["add"]);

                                    controller.selectCluster = null;

                                    Map<String, dynamic>? clustersData =
                                        await overviewReportApiService
                                            .getListOfClusters(
                                                controller.selectLocationId ??
                                                    0);

                                    if (clustersData != null) {
                                      List<Map<String, dynamic>> clusters =
                                          clustersData['clusters'];

                                      print(
                                          "clusters.length : ${clusters.length}");
                                      print("clusters : $clusters");

                                      controller.updateClusters(clusters);
                                      controller.update(["add"]);
                                    }

                                    // setState(() {
                                    //   controller.selectClusterId =
                                    //   0;
                                    //   controller.selectCluster = null;
                                    // });
                                  }
                                }
                              }
                            },
                          );
                        },
                      )
                    : Container(),

                Space.height(30),
                GetBuilder<OverviewPanController>(
                  builder: (controller) {
                    return commonTitle(controller.selectLocation == null
                        ? "Overview Pan-India Locations"
                        : "Overview ${controller.selectLocation}");
                  },
                ),
                Space.height(16),
                GetBuilder<OverviewPanController>(
                  builder: (controller) {
                    return controller.selectRegion != null
                        ? controller.selectRegion == "All Regions"
                            ? allRegionsTables(0)
                            : controller.selectLocation == null &&
                                    controller.selectRegion != "All Regions"
                                ? tableDataLocation()
                                : tableDataLocationView()
                        : SizedBox();
                  },
                ),
                Space.height(34),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MySize.size48,
                    width: MySize.size168,
                    decoration: BoxDecoration(
                        border: Border.all(color: darkBlueColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: GestureDetector(
                      onTap: () {
                        if (controller.selectRegion == "All Regions") {
                          downloadExcel();
                        } else
                          print("something wrong on download button");
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/Excel.svg',
                            height: 25,
                            width: 25,
                          ),
                          Space.width(3),
                          const Text(
                            'Download  Excel',
                            style: TextStyle(
                                fontSize: 14,
                                color: CustomColorTheme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Space.height(10)
              ],
            ),
          )),
    );
  }

  Widget allRegionsTables(int i) {
    return Visibility(
      visible: controller.overviewMappedList != null &&
          controller.overviewMappedList!.isNotEmpty,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DataTable(
                dividerThickness: 00,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                columnSpacing: 0,
                horizontalMargin: 0,
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff008CD3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0))),
                        padding: EdgeInsets.only(left: 10),
                        child: Center(
                          child: Text(
                            'Locations',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'DPM',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'ALR',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      child: Center(
                        child: Text(
                          'BGM',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'KDP',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'CHA',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      color: Color(0xff096C9F),
                      height: 60,
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'SOUTH',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'MEG',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //umg
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'UMG',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //jgr
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'JGR',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //lan
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'LAN',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NE
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff096C9F),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'NE',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //CUT
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'CUT',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //MED
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'MED',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //BOK
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'BOK',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //RAJ
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'RAJ',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //KAL
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'KAL',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //EAST
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff096C9F),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'East',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //CEMENT
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff2E8CBB),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'Cement',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NIG
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'NIG',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //RAM
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'RAM',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //JOW
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'JOW',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NIN
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'NIN',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //KOL
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff008CD3),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'KOL',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //SUGAR
                  DataColumn(
                    label: Container(
                      height: 60,
                      width: 80,
                      color: Color(0xff2E8CBB),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'SUGAR',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //PANIND
                  DataColumn(
                    label: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff096C9F),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0))),
                      height: 60,
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'PANIND',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  controller.locationsList.length,
                  (index) => DataRow(
                    color: MaterialStateColor.resolveWith(
                      (states) {
                        i = 0;
                        return controller.locationsList[index] ==
                                    "Households" ||
                                controller.locationsList[index] ==
                                    "Interventions" ||
                                controller.locationsList[index] ==
                                    "HH with Annual Addl. Income"
                            ? Color(0xff008CD3).withOpacity(0.3)
                            : index.isEven
                                ? Colors.blue.shade50
                                : Colors.white;
                      },
                    ),
                    cells: [
                      DataCell(
                        Container(
                          width: 150,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text(
                                controller.locationsList[index],
                                style: controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize)
                                    : AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              //     : controller.DPM[index].toString()), // changes required here
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //alr
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.ALR[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //bgm
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.BGM[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //kdp
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.KDP[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //cha
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      ///__________________________ South _______________________
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff096C9F),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // meg
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //umg
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //jgr
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //lan
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      ///__________________________ NE _______________________
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff096C9F),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual Addl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      //CUT
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //MED
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //BOK
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //RAJ
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //KAL
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //EAST
                      ///__________________________ EAST _______________________
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff096C9F),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      //CEMENT
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff2E8CBB),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      //NIG
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                      //RAM

                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      //JOW
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      //NIN
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      //KOL
                      DataCell(
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              (controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0'),
                              // : controller.CHA[index].toString()),
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),

                      //SUGAR
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff2E8CBB),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      //PANIND
                      DataCell(
                        Container(
                          height: 60,
                          color: Color(0xff096C9F),
                          width: 80,
                          child: Center(
                            child: Text(
                              controller.locationsList[index] == "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? ""
                                  : controller.overviewMappedList![0][controller
                                              .locationsListMapping[index]] !=
                                          null
                                      ? controller.overviewMappedList![0][
                                              controller.locationsListMapping[
                                                  index]]![
                                              controller.allLocations[i++]]
                                          .toString()
                                      : '0',
                              // : controller.SOUTH[index].toString(),
                              style: AppStyle.textStyleInterMed(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Additional row for total
                    ],
                  ),
                )),
          )),
      replacement: Container(),
    );
  }

  Widget tableDataLocation() {
    // List<DataColumn> dataColumns = [];
    //
    // // Create the "Details" DataColumn
    // dataColumns.add(DataColumn(
    //   label: Expanded(
    //     child: Container(
    //       height: 60,
    //       decoration: BoxDecoration(
    //         color: Color(0xff008CD3),
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(10.0),
    //         ),
    //       ),
    //       padding: EdgeInsets.only(left: 10),
    //       child: Center(
    //         child: Text(
    //           'Details',
    //           style: TextStyle(
    //             fontWeight: CustomFontTheme.headingwt,
    //             fontSize: CustomFontTheme.textSize,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ));
    //
    // // Create DataColumns based on controller.locationName
    // for (String location in controller.locations!.map((location) => location['locationCode'].toString()).toList()) {
    //   dataColumns.add(DataColumn(
    //     label: Container(
    //       height: 60,
    //       width: 80,
    //       color: Color(0xff008CD3),
    //       padding: EdgeInsets.symmetric(horizontal: 10),
    //       child: Center(
    //         child: Text(
    //           location,
    //           style: TextStyle(
    //             fontWeight: CustomFontTheme.headingwt,
    //             fontSize: CustomFontTheme.textSize,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ));
    // }
    //
    // // Add the "Total" DataColumn
    // dataColumns.add(DataColumn(
    //   label: Container(
    //     decoration: BoxDecoration(
    //       color: Color(0xff096C9F),
    //       borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(10.0),
    //       ),
    //     ),
    //     height: 60,
    //     width: 80,
    //     padding: EdgeInsets.symmetric(horizontal: 10),
    //     child: Center(
    //       child: Text(
    //         'Total',
    //         style: TextStyle(
    //           fontWeight: CustomFontTheme.headingwt,
    //           fontSize: CustomFontTheme.textSize,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // ));

    return Visibility(
        visible:
            true /* controller.regionWiseMappedList != null && controller.regionWiseMappedList!.isNotEmpty */,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                  dividerThickness: 00,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  columnSpacing: 0,
                  horizontalMargin: 0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff008CD3),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0))),
                          padding: EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              'Details',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: 80,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'DPM',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: 80,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'ALR',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: 80,
                        color: Color(0xff008CD3),
                        child: Center(
                          child: Text(
                            'BGM',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: 80,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'KDP',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: 80,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'CHA',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    //PANIND
                    DataColumn(
                      label: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff096C9F),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0))),
                        height: 60,
                        width: 80,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'Total',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    controller.locationsList.length,
                    (index) => DataRow(
                      color: MaterialStateColor.resolveWith(
                        (states) {
                          return controller.locationsList[index] ==
                                      "Households" ||
                                  controller.locationsList[index] ==
                                      "Interventions" ||
                                  controller.locationsList[index] ==
                                      "HH with Annual\nAddl. Income"
                              ? Color(0xff008CD3).withOpacity(0.3)
                              : index.isEven
                                  ? Colors.blue.shade50
                                  : Colors.white;
                        },
                      ),
                      cells: [
                        DataCell(
                          Container(
                            width: 150,
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  controller.locationsList[index],
                                  style: controller.locationsList[index] ==
                                              "Households" ||
                                          controller.locationsList[index] ==
                                              "Interventions" ||
                                          controller.locationsList[index] ==
                                              "HH with Annual\nAddl. Income"
                                      ? TextStyle(
                                          color: CustomColorTheme.textColor,
                                          fontWeight: CustomFontTheme.headingwt,
                                          fontSize: CustomFontTheme.textSize)
                                      : AppStyle.textStyleInterMed(
                                          fontSize: 14),
                                ),
                                Spacer(),
                                VerticalDivider(
                                  width: 1,
                                  color: Color(0xff181818).withOpacity(0.3),
                                  thickness: 1,
                                )
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.DPM[index].toString()),
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                        //alr
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.ALR[index].toString()),
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                        //bgm
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.BGM[index].toString()),
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                        //kdp
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.KDP[index].toString()),
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                        //cha
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.CHA[index].toString()),
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              VerticalDivider(
                                width: 1,
                                color: Color(0xff181818).withOpacity(0.3),
                                thickness: 1,
                              )
                            ],
                          ),
                        ),
                        // DataCell(
                        //   Row(
                        //     children: [
                        //       Spacer(),
                        //       Text(
                        //         (controller.locationsList[index] == "Households" ||
                        //                 controller.locationsList[index] ==
                        //                     "Interventions" ||
                        //                 controller.locationsList[index] ==
                        //                     "HH with Annual\nAddl. Income"
                        //             ? ""
                        //             : controller.CHA[index].toString()),
                        //         style: AppStyle.textStyleInterMed(fontSize: 14),
                        //       ),
                        //       Spacer(),
                        //       VerticalDivider(
                        //         width: 1,
                        //         color: Color(0xff181818).withOpacity(0.3),
                        //         thickness: 1,
                        //       )
                        //     ],
                        //   ),
                        // ),

                        ///__________________________ South _______________________
                        DataCell(
                          Container(
                            height: 60,
                            color: Color(0xff096C9F),
                            width: 80,
                            child: Center(
                              child: Text(
                                controller.locationsList[index] ==
                                            "Households" ||
                                        controller.locationsList[index] ==
                                            "Interventions" ||
                                        controller.locationsList[index] ==
                                            "HH with Annual\nAddl. Income"
                                    ? ""
                                    : controller.SOUTH[index].toString(),
                                style: AppStyle.textStyleInterMed(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // Additional row for total
                      ],
                    ),
                  ) /*+
                            [
                              DataRow(
                                color: MaterialStateColor.resolveWith(
                                        (states) => Colors.white),
                                cells: [
                                  DataCell(
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: CustomFontTheme.textSize,
                                        fontWeight: CustomFontTheme.headingwt,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "44444",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "64546",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],*/
                  ),
            )),
        replacement: Container());
  }

  Widget tableDataLocationView() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
              dividerThickness: 00,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              columnSpacing: 0,
              horizontalMargin: 0,
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'VDF1',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'VDF2',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    child: Center(
                      child: Text(
                        'VDF3',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'VDF4',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'VDF5',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //PANIND
                DataColumn(
                  label: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff096C9F),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10.0))),
                    height: 60,
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Total',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                controller.locationsList.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      return controller.locationsList[index] == "Households" ||
                              controller.locationsList[index] ==
                                  "Interventions" ||
                              controller.locationsList[index] ==
                                  "HH with Annual\nAddl. Income"
                          ? Color(0xff008CD3).withOpacity(0.3)
                          : index.isEven
                              ? Colors.blue.shade50
                              : Colors.white;
                    },
                  ),
                  cells: [
                    DataCell(
                      Container(
                        width: 150,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.locationsList[index],
                              style: controller.locationsList[index] ==
                                          "Households" ||
                                      controller.locationsList[index] ==
                                          "Interventions" ||
                                      controller.locationsList[index] ==
                                          "HH with Annual\nAddl. Income"
                                  ? TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.DPM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //alr
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.ALR[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //bgm
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.BGM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //kdp
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.KDP[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //cha
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.CHA[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),

                    ///__________________________ South _______________________
                    DataCell(
                      Container(
                        height: 60,
                        color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.locationsList[index] == "Households" ||
                                    controller.locationsList[index] ==
                                        "Interventions" ||
                                    controller.locationsList[index] ==
                                        "HH with Annual\nAddl. Income"
                                ? ""
                                : controller.SOUTH[index].toString(),
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // Additional row for total
                  ],
                ),
              )),
        ));
  }
}

Container viewOtherReports(BuildContext context, {String? title}) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadows: [
        const BoxShadow(
          color: Color(0x19000000),
          blurRadius: 10,
          offset: Offset(0, 5),
          spreadRadius: 0,
        )
      ],
    ),
    child: TextButton.icon(
        style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF008CD3),
            foregroundColor: Colors.white),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.folder_outlined),
        label: Text(
          title ?? 'View other Reports',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )),
  );
}
