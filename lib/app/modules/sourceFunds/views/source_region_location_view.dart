import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SourceRegionsView extends StatelessWidget {
  const SourceRegionsView({super.key});

  @override
  Widget build(BuildContext context) {
    SourceFundsController controller = Get.put(SourceFundsController());
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
                    viewOtherReports(context),
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
              GetBuilder<SourceFundsController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomDropdownFormField(
                        title: "Select a Region",
                        options: [
                          "South & Chandrapur",
                          "Sugar",
                          "East",
                          "North East",
                        ],
                        selectedValue: controller.selectLocation,
                        onChanged: (String? newValue) async {
                          controller.selectLocation = newValue;
                          controller.update();
                        }),
                  );
                },
              ),
              Space.width(10),

              GetBuilder<SourceFundsController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomDropdownFormField(
                        title: "Select a Location",
                        options: [
                          "South & Chandrapur",
                          "Sugar",
                          "East",
                          "North East",
                          "All Regions"
                        ],
                        selectedValue: controller.selectP,
                        onChanged: (String? newValue) async {
                          controller.selectP = newValue;
                          controller.update();
                        }),
                  );
                },
              ),
              Space.height(30),
             GetBuilder<SourceFundsController>(builder: (controller) {
               return Text(
                 "${ controller.selectP??controller.selectLocation }",
                 style: AppStyle.textStyleBoldMed(fontSize: 14),
               );
             },),
              Text(
                "Source of Funds (Rs. in Lakhs)",
                style: AppStyle.textStyleInterMed(fontSize: 14),
              ),
              Space.height(16),

              ///_________________________________ Table __________________________///
              controller.selectP==null?tableDataRegionsView(controller):tableDataLocationView(controller),
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
                      Text(
                        'Download  Excel',
                        style: AppStyle.textStyleInterMed(fontSize: 14),
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

  Widget tableDataRegionsView(SourceFundsController controller) {
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
                controller.regions.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      return controller.regions[index] == "Households" ||
                              controller.regions[index] == "Interventions" ||
                              controller.regions[index] ==
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
                              controller.regions[index],
                              style: controller.regions[index] == "Cement"
                                  ? TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
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
                    ),
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.regions[index] == "Cement"
                                ? ""
                                : controller.lDPM[index].toString()),
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
                            (controller.regions[index] == "Cement"
                                ? ""
                                : controller.ALR[index].toString()),
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
                            (controller.regions[index] == "Cement"
                                ? ""
                                : controller.BGM[index].toString()),
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
                            (controller.regions[index] == "Cement"
                                ? ""
                                : controller.KDP[index].toString()),
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
                            (controller.regions[index] == "Cement"
                                ? ""
                                : controller.CHA[index].toString()),
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

                    ///__________________________ South _______________________
                    DataCell(
                      Container(
                        height: 60,
                        color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.regions[index] == "Cement"
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
  Widget tableDataLocationView(SourceFundsController controller) {
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
                controller.regionsByLocation.length,
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
                        width: 150,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.regionsByLocation[index],
                              style: controller.regionsByLocation[index] == "Cement"
                                  ? TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.regionsByLocation[index] == "Cement"
                                ? SizedBox()
                                : VerticalDivider(
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
                            (controller.regionsByLocation[index] == "Cement"
                                ? ""
                                : controller.lDPM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regionsByLocation[index] == "Cement"
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
                            (controller.regionsByLocation[index] == "Cement"
                                ? ""
                                : controller.ALR[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regionsByLocation[index] == "Cement"
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
                            (controller.regionsByLocation[index] == "Cement"
                                ? ""
                                : controller.BGM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regionsByLocation[index] == "Cement"
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
                            (controller.regionsByLocation[index] == "Cement"
                                ? ""
                                : controller.KDP[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regionsByLocation[index] == "Cement"
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
                            (controller.regionsByLocation[index] == "Cement"
                                ? ""
                                : controller.CHA[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regionsByLocation[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regionsByLocation[index] == "Cement"
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
}
