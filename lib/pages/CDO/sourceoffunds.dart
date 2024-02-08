import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/app/modules/sourceFunds/service/sourceOfFundsApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/constants.dart';
import '../../../../helper/sharedpref.dart';

class SourceOfFunds extends StatefulWidget {
  int? locationId;
  SourceOfFunds({super.key, required this.locationId});

  @override
  _SourceOfFundsState createState() => _SourceOfFundsState();
}

class _SourceOfFundsState extends State<SourceOfFunds> {
  String name = ' ';
  final SourceOfFundsApiService sourceOfFundsApiService =
      new SourceOfFundsApiService();
  SourceFundsController controller = new SourceFundsController();
  late Future<Map<String, dynamic>> regionsFuture;

  bool isLoadingLocation = true;
  String? locationName;
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? name = 'user' : name = value;
            }));
    ;

    regionsFuture = sourceOfFundsApiService.getListOfRegions(controller);
    update();
  }

    void update() async {
    if (widget.locationId != null) {
      // Access the locationId property and convert it to int
      int? selectedLocationId = widget.locationId;

      // print('selectedLocationId: $selectedLocationId');

      if (selectedLocationId != null) {
        setState(() {
          controller.selectLocationId = selectedLocationId;
        });
        try{
          try {
            var url = Uri.parse(
                'https://mobileqacloud.dalmiabharat.com:443/csr/locations/${widget.locationId}');
            http.get(url).then((response) {
              var data = json.decode(response.body);

              setState(() {
                locationName = data['location'];
              });
              return locationName;
            });
          } catch (e) {
            locationName='';
            print(e);

          }


        }catch(e){
          print("error in update : $e");
        }

        //

        Map<String, dynamic> clustersData = await sourceOfFundsApiService
            .getListOfClusters(controller.selectLocationId!);

        List<Map<String, dynamic>> clusters = [];

        for (int i = 0; i < clustersData['clusters'].length; i++) {
          if (clustersData['clusters'][i]['vdfName'] != null) {
            clusters.add(clustersData['clusters'][i]);
          }
        }
        print("clustessrs : $clusters");
        List<String> clusterslist =
            clusters!.map((cluster) => cluster['vdfName'].toString()).toList();

        print("\n\n clusters list : $clusterslist");

        setState(() {
          controller.updateClusters(clusterslist);
          print("controller.clustersList55 : ${controller.clustersList!.length}");
          isLoadingLocation = false;
        });

        controller.update(["add"]);

        var fetchLocationWiseSourceOfFundsData = await sourceOfFundsApiService
            .fetchClusterWiseSourceOfFundsData(controller);

        setState(() {
          controller.locationWiseSourceOfFundsData =
              fetchLocationWiseSourceOfFundsData;
          print(
              " \n \n controller.updateRegionWiseSourceOfFundsData e2bf : ${fetchLocationWiseSourceOfFundsData}");
        });

        List<String> targetKeys = [
          'noOfHouseholds',
          'beneficiary',
          'subsidy',
          'credits',
          'dbf'
        ];

        print("\n \n con reached: ");

        Map<String, dynamic> allTotal =
            await calculateIndividualKeySumsForRegions(clusterslist,
                controller.locationWiseSourceOfFundsData!, targetKeys);

        setState(() {
          clusterslist.add("Total");
          controller.locationWiseSourceOfFundsData!
              .putIfAbsent('Total', () => allTotal);
        });

        print(
            "controller.sourceOfFundsData  hafsb1: ${controller.locationWiseSourceOfFundsData}");
      }
    }
  }

  String formatNumber(int number) {
    if (number < 100) {
      return number.toString();
    }
    double lakhs = number / 100000.0;
    final format = NumberFormat('0.00');
    return format.format(lakhs);
  }

  ExportTableToExcel exportTableToExcel = new ExportTableToExcel();
  void downloadExcel(SourceFundsController controller, int a) {
    try {
      if (a == 1) {
        exportTableToExcel.exportRegionSOF(controller);
      } else {
        exportTableToExcel.exportLocationSOF(controller);
      }
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
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller, context, name,
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
                    Space.width(16),
                  ],
                ),
              ),
              Space.height(34),


              Text(
                "Source of Funds for Interventions\n(in Lakhs) ",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),

              Space.height(10),
              Text("${locationName ?? ""}",
                  style: AppStyle.textStyleInterMed(fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),

              Space.height(20),
              tableDataLocationView(controller),
              Space.height(30),

              GestureDetector(
                onTap: () {
                  if (controller.selectLocation == null) {
                    downloadExcel(controller, 1);
                  } else {
                    downloadExcel(controller, 2);
                  }
                },
                child: Container(
                  height: MySize.screenHeight * (40 / MySize.screenHeight),
                  width: MySize.screenWidth * (150 / MySize.screenWidth),
                  decoration: BoxDecoration(
                      border: Border.all(color: darkBlueColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/Excel.svg',
                        height:
                            MySize.screenHeight * (25 / MySize.screenHeight),
                        width: MySize.screenWidth * (25 / MySize.screenWidth),
                      ),
                      Space.width(3),
                      Text(
                        'Download  Excel',
                        style: TextStyle(
                            fontSize: MySize.screenHeight *
                                (14 / MySize.screenHeight),
                            color: CustomColorTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Space.height(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableDataLocationView(SourceFundsController controller) {
    return !isLoadingLocation && controller.clustersList != null &&  controller.locationWiseSourceOfFundsData!=null
        ? SingleChildScrollView(
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
                        width: 150,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'No. of HH with\ncompleted Int.',
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
                        width: 110,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'Beneficiary',
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
                            'Subsidy',
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
                            'Credits',
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
                            'DBF  ',
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
                    controller.clustersList!.length,
                    (index) => DataRow(
                      color: MaterialStateColor.resolveWith(
                        (states) {
                          return index.isEven
                                  ? Colors.blue.shade50
                                  : Colors.white;
                        },
                      ),
                      cells: [
                        DataCell(
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: MySize.screenWidth *
                                      (150 / MySize.screenWidth),
                                  child: Text(
                                    controller.clustersList![index],
                                    style: controller.regions[index] == "Cement"
                                        ? TextStyle(
                                            color: CustomColorTheme.textColor,
                                            fontWeight:
                                                CustomFontTheme.headingwt,
                                            fontSize: CustomFontTheme.textSize)
                                        : AppStyle.textStyleInterMed(
                                            fontSize: 14),
                                  ),
                                ),
                                Spacer(),
                                controller.regions[index] == "Cement"
                                    ? SizedBox()
                                    : VerticalDivider(
                                        width: 1,
                                        color:
                                            Color(0xff181818).withOpacity(0.3),
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
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? (controller.locationWiseSourceOfFundsData![
                                                        controller
                                                                .clustersList![
                                                            index]]![
                                                    'noOfHouseholds'] ??
                                                0)
                                            .toString()
                                        : "0",
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              controller.regions[index] == "Cement"
                                  ? SizedBox()
                                  : VerticalDivider(
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
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? formatNumber(controller
                                                        .locationWiseSourceOfFundsData![
                                                    controller.clustersList![
                                                        index]]!['beneficiary'] ??
                                                0)
                                            .toString()
                                        : "0",
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              controller.regions[index] == "Cement"
                                  ? SizedBox()
                                  : VerticalDivider(
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
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? formatNumber(controller
                                                        .locationWiseSourceOfFundsData![
                                                    controller.clustersList![
                                                        index]]!['subsidy'] ??
                                                0)
                                            .toString()
                                        : "0",
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              controller.regions[index] == "Cement"
                                  ? SizedBox()
                                  : VerticalDivider(
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
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? formatNumber(controller
                                                        .locationWiseSourceOfFundsData![
                                                    controller.clustersList![
                                                        index]]!['credits'] ??
                                                0)
                                            .toString()
                                        : "0",
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              controller.regions[index] == "Cement"
                                  ? SizedBox()
                                  : VerticalDivider(
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
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? formatNumber(controller
                                                        .locationWiseSourceOfFundsData![
                                                    controller.clustersList![
                                                        index]]!['dbf'] ??
                                                0)
                                            .toString()
                                        : "0",
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),
                              Spacer(),
                              controller.regions[index] == "Cement"
                                  ? SizedBox()
                                  : VerticalDivider(
                                      width: 1,
                                      color: Color(0xff181818).withOpacity(0.3),
                                      thickness: 1,
                                    )
                            ],
                          ),
                        ),

                        DataCell(
                          Container(
                            height: 60,
                            color: Color(0xff096C9F),
                            width: 80,
                            child: Center(
                              child: Text(
                                controller.regions[index] == "Cement"
                                    ? ""
                                    : controller.locationWiseSourceOfFundsData!
                                            .containsKey(
                                                controller.clustersList![index])
                                        ? formatNumber(_calculateSumForLocation(
                                                controller.clustersList![index],
                                                controller
                                                    .locationWiseSourceOfFundsData!)
                                            .toInt())
                                        : "0",
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
            ))
        : Center(child: CircularProgressIndicator());
  }

  num _calculateSumForLocation(String location,
      Map<String, Map<String, dynamic>>? regionWiseSourceOfFundsData) {
    num sum = 0;

    if (regionWiseSourceOfFundsData!.containsKey(location)) {
      Map<String, dynamic>? locationData =
          regionWiseSourceOfFundsData![location];

      if (locationData != null) {
        for (var key in locationData.keys) {
          if (key != "noOfHouseholds" && locationData[key] is num) {
            sum += locationData[key];
          }
        }
      }
    }
    return sum;
  }

  Map<String, num> calculateIndividualKeySumsForRegions(
      List<String> locations,
      Map<String, Map<String, dynamic>> regionWiseSourceOfFundsData,
      List<String> targetData) {
    Map<String, num> totalKeySums = {};

    for (var location in locations) {
      Map<String, dynamic>? locationsData =
          regionWiseSourceOfFundsData[location];
      if (locationsData != null) {
        Map<String, num> individualKeySums =
            calculateIndividualKeySums(locationsData, targetData);
        // Sum values for existing keys:
        individualKeySums.forEach((key, value) {
          totalKeySums[key] = (totalKeySums[key] ?? 0) + value;
        });

        print("\n \n totalKeySums : $location : ${totalKeySums} \n \n");
      }
    }

    return totalKeySums;
  }

  Map<String, num> calculateIndividualKeySums(
      Map<String, dynamic> locationData, List<String> targetKeys) {
    Map<String, num> keySums = {};

    for (var key in locationData.keys) {
      if (targetKeys.contains(key) && locationData[key] is num) {
        keySums[key] = locationData[key]; // Store key-value pairs as a Map
      }
    }

    return keySums;
  }
}
