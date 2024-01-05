import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/amount_utilized_controller.dart';

class AmountUtilizedView extends GetView<AmountUtilizedController> {
  const AmountUtilizedView({Key? key}) : super(key: key);

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
              allRegionsTables(),
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

  Widget allRegionsTables() {
    return SingleChildScrollView(
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
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10.0))),
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
                controller.locations.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
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
                                : controller.SOUTH[index].toString(),
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
                                : controller.SOUTH[index].toString(),
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
                                : controller.SOUTH[index].toString(),
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
                                : controller.SOUTH[index].toString(),
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
        ));
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
