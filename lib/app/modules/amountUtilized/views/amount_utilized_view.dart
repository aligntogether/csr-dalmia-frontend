import 'package:dalmia/Constants/constant_export.dart';
import 'package:dalmia/app/modules/amountUtilized/service/amountUtilizedApiService.dart';
import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/amount_utilized_controller.dart';



class AmountUtilizedView extends StatefulWidget {

  AmountUtilizedView({Key? key}) : super(key: key);

  @override
  _AmountUtilizedViewState createState() => new _AmountUtilizedViewState();
}

class _AmountUtilizedViewState extends State<AmountUtilizedView> {
  final AmountUtilizedApiService amountUtilizedApiService = new AmountUtilizedApiService();
  int isRH = 0;
  bool isLoading = true;

  AmountUtilizedController controller = Get.put(AmountUtilizedController());

  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(USER_TYPE_SHAREDPREF_KEY, context, true).then((value) {
      print("userType : $value");
      if (value == RH_USERTYPE) {
        isRH = 1;
        setRHLocations();
      }
      else {
        getAmountUtilizedReport();
      }
    });

  }

  void setRHLocations() {

    List<dynamic>? ls = amountUtilizedApiService.convertMapToList(controller.rhRegions);

    setState(() {
      isLoading = false;
      controller.rhlocationsList = ls?.cast<String>();
    });

  }

  void getAmountUtilizedReport() async {

    List<Map<String, Map<String, dynamic>>> amountUtilizedMappedData = await amountUtilizedApiService.getAmountUtilizedAllRegions(controller.allLocations, controller.objectKeys);

    setState(() {
      isLoading = false;
      controller.updateAmountUtilizedMappedList(amountUtilizedMappedData);
    });

  }



  @override
  Widget build(BuildContext context) {
    AmountUtilizedController amountUtilizedController =
        Get.put(AmountUtilizedController());
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,
              centerAlignText: true, title: "Reports"),
          body: Column(
            children: [
              // appBar(context, title: "Reports"),
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

              SizedBox(
                  width: MySize.size268,
                  child: Column(
                    children: [
                      Text(
                        "Amount Utilized by each location for Livelihood activities",
                        textAlign: TextAlign.center,
                        style: AppStyle.textStyleBoldMed(fontSize: 14),
                      ),
                      Text(
                        "(in Lakhs)",
                        style: AppStyle.textStyleInterMed(fontSize: 14),
                      ),
                    ],
                  )),
              isRH == 1 ? selectedRHRegionsTables(0) : allRegionsTables(0),
              // selectedRHRegionsTables(0),

              Space.height(14),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: MySize.size48,
                  width: MySize.size168,
                  decoration: BoxDecoration(
                      border: Border.all(color: darkBlueColor),
                      borderRadius: BorderRadius.circular(5)),
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
                            fontSize: 14, color: CustomColorTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Space.height(20),
            ],
          )),
    );
  }

  Widget allRegionsTables(int i) {

    List<DataColumn> dataColumns = [];

    // Create the "Details" DataColumn
    dataColumns.add(DataColumn(
      label: Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xff008CD3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              'Locations',
              style: TextStyle(
                fontWeight: CustomFontTheme.headingwt,
                fontSize: CustomFontTheme.textSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ));

    // Create DataColumns based on controller.locationName
    for (String location in controller.allLocations) {
      dataColumns.add(DataColumn(
        label: Container(
          height: 60,
          width: 80,
          color: Color(0xff008CD3),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              location,
              style: TextStyle(
                fontWeight: CustomFontTheme.headingwt,
                fontSize: CustomFontTheme.textSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    return Visibility(
        visible: controller.amountUtilizedMappedList != null && controller.amountUtilizedMappedList!.isNotEmpty,
        child: !isLoading ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
              dividerThickness: 00,
              columnSpacing: 0,
              horizontalMargin: 0,
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
              columns: dataColumns,
              rows: List<DataRow>.generate(
                controller.locations.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      i = 0;
                      return controller.locations[index] == "Households" ||
                              controller.locations[index] == "Interventions" ||
                              controller.locations[index] ==
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
                              controller.locations[index],
                              style: controller.locations[index] ==
                                          "Households" ||
                                      controller.locations[index] ==
                                          "Interventions" ||
                                      controller.locations[index] ==
                                          "HH with Annual Addl. Income"
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),

                                // : controller.DPM[index].toString()),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
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
        )
    ): Center(child: CircularProgressIndicator()),
    replacement: Container()
    );
  }


  Widget selectedRHRegionsTables(int i) {

    List<DataColumn> dataColumns = [];

    // Create the "Details" DataColumn
    dataColumns.add(DataColumn(
      label: Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xff008CD3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              'Locations',
              style: TextStyle(
                fontWeight: CustomFontTheme.headingwt,
                fontSize: CustomFontTheme.textSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ));

    // Create DataColumns based on controller.locationName
    for (String location in controller.rhlocationsList!) {
      dataColumns.add(DataColumn(
        label: Container(
          height: 60,
          width: 80,
          color: Color(0xff008CD3),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              location,
              style: TextStyle(
                fontWeight: CustomFontTheme.headingwt,
                fontSize: CustomFontTheme.textSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    return Visibility(
        visible: true /* controller.amountUtilizedMappedList != null && controller.amountUtilizedMappedList!.isNotEmpty */,
        child: !isLoading ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
              dividerThickness: 00,
              columnSpacing: 0,
              horizontalMargin: 0,
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
              columns: dataColumns,
              rows: List<DataRow>.generate(
                controller.locations.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      i = 0;
                      return controller.locations[index] == "Households" ||
                              controller.locations[index] == "Interventions" ||
                              controller.locations[index] ==
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
                              controller.locations[index],
                              style: controller.locations[index] ==
                                          "Households" ||
                                      controller.locations[index] ==
                                          "Interventions" ||
                                      controller.locations[index] ==
                                          "HH with Annual Addl. Income"
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                                : controller.SOUTH[index].toString(),
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
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                    //umg
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                    //jgr
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                    //lan
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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
                    ),//lan
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
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

                    ///__________________________ NE _______________________
                    DataCell(
                      Container(
                        height: 60,
                        color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.locations[index] == "Households" ||
                                    controller.locations[index] ==
                                        "Interventions" ||
                                    controller.locations[index] ==
                                        "HH with Annual Addl. Income"
                                ? ""
                                // : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                                : controller.SOUTH[index].toString(),
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    //CUT
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //MED
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //BOK
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //RAJ
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //KAL
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //EAST
                    // ///__________________________ EAST _______________________
                    // DataCell(
                    //   Container(
                    //     height: 60,
                    //     color: Color(0xff096C9F),
                    //     width: 80,
                    //     child: Center(
                    //       child: Text(
                    //         controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                    //             // : controller.SOUTH[index].toString(),
                    //         style: AppStyle.textStyleInterMed(
                    //             fontSize: 14, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // //CEMENT
                    // DataCell(
                    //   Container(
                    //     height: 60,
                    //     color: Color(0xff2E8CBB),
                    //     width: 80,
                    //     child: Center(
                    //       child: Text(
                    //         controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                    //             // : controller.SOUTH[index].toString(),
                    //         style: AppStyle.textStyleInterMed(
                    //             fontSize: 14, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // //NIG
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    // //RAM
                    //
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    //
                    // //JOW
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    //
                    // //NIN
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //               // : controller.CHA[index].toString()),
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
                    //
                    // //KOL
                    // DataCell(
                    //   Row(
                    //     children: [
                    //       Spacer(),
                    //       Text(
                    //         (controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0'),
                    //             // : controller.CHA[index].toString()),
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
                    //
                    // //SUGAR
                    // DataCell(
                    //   Container(
                    //     height: 60,
                    //     color: Color(0xff2E8CBB),
                    //     width: 80,
                    //     child: Center(
                    //       child: Text(
                    //         controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                    //             // : controller.SOUTH[index].toString(),
                    //         style: AppStyle.textStyleInterMed(
                    //             fontSize: 14, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // //PANIND
                    // DataCell(
                    //   Container(
                    //     height: 60,
                    //     color: Color(0xff096C9F),
                    //     width: 80,
                    //     child: Center(
                    //       child: Text(
                    //         controller.locations[index] == "Households" ||
                    //                 controller.locations[index] ==
                    //                     "Interventions" ||
                    //                 controller.locations[index] ==
                    //                     "HH with Annual Addl. Income"
                    //             ? ""
                    //             : controller.amountUtilizedMappedList![0][controller.objectKeys[index]] != null ? controller.amountUtilizedMappedList![0][controller.objectKeys[index]]![controller.allLocations[i++]].toString() : '0',
                    //             // : controller.SOUTH[index].toString(),
                    //         style: AppStyle.textStyleInterMed(
                    //             fontSize: 14, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),

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
        )
    ) : Center(child: CircularProgressIndicator()),
    replacement: Container()
    );
  }

  Widget tableDataAll() {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Set border radius
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Set shadow color
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///________________________________________________ TITLES __________________________
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5))),
                    child: Row(
                      children: [
                        commonHeadingText("Details"),
                        Space.width(26),
                        commonHeadingText("DPM"),
                        Space.width(22),
                        commonHeadingText("ALR"),
                        Space.width(22),
                        commonHeadingText("BGM"),
                        Space.width(22),
                        commonHeadingText("KDP"),
                        Space.width(22),
                        commonHeadingText("CHA"),
                        commonContainer("SOUTH", Color(0xff096C9F)),
                        Space.width(22),
                        commonHeadingText("MEG"),
                        Space.width(22),
                        commonHeadingText("UGM"),
                        Space.width(22),
                        commonHeadingText("JGR"),
                        Space.width(22),
                        commonHeadingText("LAN"),
                        commonContainer("  NE  ", Color(0xff096C9F)),
                        Space.width(22),
                        commonHeadingText("CUT"),
                        Space.width(22),
                        commonHeadingText("MED"),
                        Space.width(22),
                        commonHeadingText("BOK"),
                        Space.width(22),
                        commonHeadingText("RAJ"),
                        Space.width(22),
                        commonHeadingText("KAL"),
                        commonContainer("  East  ", Color(0xff096C9F)),
                        commonContainer("cement", Color(0xff2E8CBB)),
                        Space.width(22),
                        commonHeadingText("NIG"),
                        Space.width(22),
                        commonHeadingText("RAM"),
                        Space.width(22),
                        commonHeadingText("JOW"),
                        Space.width(22),
                        commonHeadingText("NIN"),
                        Space.width(22),
                        commonHeadingText("KOL"),
                        commonContainer("SUGAR", Color(0xff2E8CBB)),
                        commonContainer("PAN IND", Color(0xff096C9F)),
                      ],
                    ),
                  ),

                  ///________________________________________________ HOUSEHOLDERS LISTS __________________________
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    height: 40,
                    child: Row(
                      children: [
                        commonHeadingText("Budget Allocated",
                            color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(25),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer("", Color(0xff096C9F)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        commonContainer("6500", Color(0xff096C9F)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(23),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer("6500", Color(0xff096C9F)),
                        commonContainer("6500", Color(0xff2E8CBB)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(22),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer(" ", Color(0xff2E8CBB)),
                        commonContainer(" ", Color(0xff096C9F)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    height: 40,
                    color: Color(0xff008CD3).withOpacity(0.1),
                    child: Row(
                      children: [
                        commonHeadingText("Amount Utilized",
                            color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(25),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer("", Color(0xff096C9F)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        commonContainer("6500", Color(0xff096C9F)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(23),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer("6500", Color(0xff096C9F)),
                        commonContainer("6500", Color(0xff2E8CBB)),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(21),
                        commonHeadingText("6500", color: Colors.black),
                        Container(
                          height: 40,
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                        ),
                        Space.width(22),
                        commonHeadingText("6500", color: Colors.black),
                        commonContainer(" ", Color(0xff2E8CBB)),
                        commonContainer(" ", Color(0xff096C9F)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
