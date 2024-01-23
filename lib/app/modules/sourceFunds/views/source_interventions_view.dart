import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/app/modules/sourceFunds/service/sourceOfFundsApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Constants/constants.dart';
import '../../../../helper/sharedpref.dart';






class SourceInterventionsView extends StatefulWidget {

  SourceInterventionsView({super.key});

  @override
  _SourceInterventionsViewState createState() => _SourceInterventionsViewState();
}

class _SourceInterventionsViewState extends State<SourceInterventionsView> {

  SourceFundsController controller = Get.put(SourceFundsController());
  SourceOfFundsApiService sourceOfFundsApiService = new SourceOfFundsApiService();
  bool isLoading = true;
  String name=' ';

  final ExportTableToExcel exportTableToExcel = ExportTableToExcel();
  void downloadExcel() {
    try {
      exportTableToExcel.exportSourceFundsReport(controller);
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
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;
    }));
    ;
    fetchSourceFundsData();
  }

  void fetchSourceFundsData() async {
    await sourceOfFundsApiService.fetchSourceOfFundsData(controller).then((value) => {
      setState(() {
        isLoading = false;
        controller.updateSourceOfFundsData(value!);
      })
    });

    addCementTotalInSourceOfFundsData();
    addPanIndiaTotalInSourceOfFundsData();

    print("controller.sourceOfFundsData : ${controller.sourceOfFundsData}");

  }

  void addCementTotalInSourceOfFundsData() async {

    List<String> targetRegions = ['South and Chandrapur', 'East', 'North East'];
    List<String> targetKeys = ['noOfHouseholds', 'beneficiary', 'subsidy', 'credits', 'dbf'];

    print("\n \n con reached: ");

    Map<String, dynamic> cementTotal = await calculateIndividualKeySumsForRegions(targetRegions, controller.sourceOfFundsData!, targetKeys);


    setState(() {
      controller.sourceOfFundsData!.putIfAbsent('Total', () => cementTotal);
    });

    print("controller.sourceOfFundsData  hafsb1: ${controller.sourceOfFundsData}");

  }

  void addPanIndiaTotalInSourceOfFundsData() async {

    List<String> targetRegions = ['South and Chandrapur', 'East', 'North East', 'Sugar'];
    List<String> targetKeys = ['noOfHouseholds', 'beneficiary', 'subsidy', 'credits', 'dbf'];

    print(" \n \n con1 reached: ");

    Map<String, dynamic> panIndiaTotal = await calculateIndividualKeySumsForRegions(targetRegions, controller.sourceOfFundsData!, targetKeys);

    setState(() {
      controller.sourceOfFundsData!.putIfAbsent('Pan-India', () => panIndiaTotal);
    });

    print("controller.sourceOfFundsData  hafsb11: ${controller.sourceOfFundsData}");

  }

  @override
  Widget build(BuildContext context) {
    SourceFundsController controller = Get.put(SourceFundsController());
    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller, context,name,
            centerAlignText: true, title: "Reports"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Space.height(16),
              ///_________________________________ main menu __________________________///
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return GPLHomeScreen();
                    },
                  ));
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
              ///_________________________________ Table __________________________///
              tableDataLocationView(controller),
              /*    SingleChildScrollView(
            child: Table(border: TableBorder.all(), children: [
              const TableRow(children: [
                Text('Details'),
                Text('No. of HH with completed Int.'),
              ]),
              TableRow(children: [
                const Text('Cement'),
                Table(border: TableBorder.all(), children: const [
                  TableRow(children: [
                    Text('Nested Entry 1'),
                    Text('Nested Entry 2'),
                  ]),
                  TableRow(children: [
                    Text('Nested Entry 3'),
                    Text('Nested Entry 4'),
                  ]),
                ]),
              ]),
            ]),
          ),*/
              Space.height(20),
              GestureDetector(onTap: () {
                downloadExcel();
              },
                child: Container(height: MySize.size48,width: MySize.size168,
                  decoration: BoxDecoration(border: Border.all(color: darkBlueColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/Excel.svg',height: 25,width: 25,),
                      Space.width(3),
                      Text(
                        'Download  Excel',
                        style:AppStyle.textStyleInterMed(fontSize: 14),
                      ),
                    ],
                  ),),
              ),
              Space.height(20),

            ],
          ),
        ),
      ),
    );
  }

  Widget tableDataLocationView(SourceFundsController controller) {
    return !isLoading ? SingleChildScrollView(
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
              columnSpacing: 0,horizontalMargin: 0,
              columns:  <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Container( height: 60,width: 180,
                      decoration: BoxDecoration(color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0))),
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
                  label:Container(
                    height: 60,width: 150,
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
                    height: 60,width: 93,color: Color(0xff008CD3),
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
                  label: Container(  height: 60,width: 80,color: Color(0xff008CD3),
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
                    height: 60,width: 80,color: Color(0xff008CD3),
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
                  label:Container(
                    height: 60,width: 80,color: Color(0xff008CD3),
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
                    decoration: BoxDecoration(color: Color(0xff096C9F),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0))),
                    height: 60,width: 80,
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
                controller.locations.length,
                    (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                        (states) {
                      return controller.sourceOfFundsData![index] == "Households" ||
                          controller.sourceOfFundsData![index] == "Interventions" ||
                          controller.sourceOfFundsData![index] ==
                              "HH with Annual Addl. Income"
                          ? Color(0xff008CD3).withOpacity(0.3)
                          : index.isEven
                          ? Colors.blue.shade50
                          : Colors.white;
                    },
                  ),
                  cells: [
                    DataCell(
                      Container(width: 180,
                        padding: EdgeInsets.only(left: 10),

                        child: Row(
                          children: [
                            Text(
                              controller.locations[index], // Use the source name as label
                              style: controller.locations[index] == "Cement"
                                  ? TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.locations[index] == "Cement"?SizedBox():VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                          ],
                        ),
                      ),

                    ),
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            // (controller.sourceOfFundsData!.keys.elementAt(index) == "Cement"
                            //     ? ""
                            //     : controller.sourceOfFundsData!['South and Chandrapur']!['noOfHouseholds'].toString()),
                            controller.locations[index] == "Cement"
                                ? ""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? (controller.sourceOfFundsData![controller.locations[index]]!['noOfHouseholds'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.locations[index] == "Cement"?SizedBox(): VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //alr
                    DataCell(
                      Row(

                        children: [
                          Spacer(),

                          Text(
                            controller.locations[index] == "Cement"
                                ? ""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? (controller.sourceOfFundsData![controller.locations[index]]!['beneficiary'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.locations[index] == "Cement"?SizedBox():VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //bgm
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.locations[index] == "Cement"
                                ? ""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? (controller.sourceOfFundsData![controller.locations[index]]!['subsidy'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.locations[index] == "Cement"?SizedBox():VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //kdp
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.locations[index] == "Cement"
                                ? ""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? (controller.sourceOfFundsData![controller.locations[index]]!['credits'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.locations[index] == "Cement"?SizedBox():VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //cha
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.locations[index] == "Cement"
                                ? ""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? (controller.sourceOfFundsData![controller.locations[index]]!['dbf'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.locations[index] == "Cement"?SizedBox():VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),


                    ///__________________________ South _______________________
                    DataCell(
                      Container(height: 60,color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.locations[index] == "Cement"?""
                                : controller.sourceOfFundsData!.containsKey(controller.locations[index])
                                ? _calculateSumForLocation(controller.locations[index]).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14,color: Colors.white),
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
        )) : Center(child: CircularProgressIndicator());
  }



  num _calculateSumForLocation(String region) {
    num sum = 0;
    if (controller.sourceOfFundsData!.containsKey(region)) {
      Map<String, dynamic>? regionData = controller.sourceOfFundsData![region];
      if (regionData != null) {
        for (var key in regionData.keys) {
          if (key != "noOfHouseholds" && regionData[key] is num) {
            sum += regionData[key];
          }
        }
      }
    }
    return sum;
  }


  Map<String, num> calculateIndividualKeySumsForRegions(List<String> regions, Map<String, Map<String, dynamic>> sourceOfFundsData, List<String> targetData) {
    Map<String, num> totalKeySums = {};

    for (var region in regions) {
      Map<String, dynamic>? regionsData = sourceOfFundsData[region];
      if (regionsData != null) {
        Map<String, num> individualKeySums = calculateIndividualKeySums(regionsData, targetData);
        // Sum values for existing keys:
        individualKeySums.forEach((key, value) {
          totalKeySums[key] = (totalKeySums[key] ?? 0) + value;
        });

        print("\n \n totalKeySums : $region : ${totalKeySums} \n \n");

      }
    }

    return totalKeySums;
  }

  Map<String, num> calculateIndividualKeySums(Map<String, dynamic> regionData, List<String> targetKeys) {
    Map<String, num> keySums = {};

    for (var key in regionData.keys) {
      if (targetKeys.contains(key) && regionData[key] is num) {
        keySums[key] = regionData[key]; // Store key-value pairs as a Map
      }
    }

    return keySums;
  }





}
