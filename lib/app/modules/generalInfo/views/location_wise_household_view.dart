import 'package:dalmia/app/modules/generalInfo/controllers/general_info_controller.dart';
import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationWiseViewHouseHold extends StatelessWidget {
  const LocationWiseViewHouseHold({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralInfoController controller = Get.put(GeneralInfoController());
    return SafeArea(
        child: Scaffold(
      appBar: appBarCommon(controller, context,
          centerAlignText: true, title: "General Information"),
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
                  viewOtherReports(context, title: "Cluster Details"),
                  Space.width(16),
                ],
              ),
            ),
            Space.height(35),
            SizedBox(width: MySize.size240,
              child: Text(
                "Location wise Household and Population details",textAlign: TextAlign.center,
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),
            ),
            Space.height(16),
            allRegionsTables(controller)
          ],
        ),
      ),
    ));
  }

  Widget allRegionsTables(GeneralInfoController controller) {
    return SingleChildScrollView(
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
              columnSpacing: 0,horizontalMargin: 0,
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Container( height: 60,width: 20,
                      decoration: BoxDecoration(color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text(
                          'S.No.',
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
                    height: 60,width: 100,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                DataColumn(
                  label: Container(
                    height: 60,width: 80,color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'No. of VDF',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(  height: 60,width: 120,color: Color(0xff008CD3),
                    child: Center(
                      child: Text(
                        'Panchayats',
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
                        'Village',
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
                        'HH',
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
                    decoration: BoxDecoration(color: Color(0xff008CD3),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0))),
                    height: 60,width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Population',
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
                      Container(width: 50,
                        padding: EdgeInsets.only(left: 10),

                        child: Row(
                          children: [
                            Text(
                              controller.locations[index]=="Total"?"":"${index}",
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.locations[index]=="Total"?SizedBox(): VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                          ],
                        ),
                      ),

                    ),
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            ( controller.locations[index]),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //alr
                    DataCell(
                      Row(

                        children: [
                          Spacer(),

                          Text(
                            ( controller.ALR[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //bgm
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.BGM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //kdp
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.KDP[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    //cha
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.CHA[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(width: 1,color: Color(0xff181818).withOpacity(0.3),thickness: 1,)
                        ],
                      ),
                    ),
                    ///__________________________ South _______________________
                    DataCell(
                      Container(height: 60,
                        width: 120,
                        child: Center(
                          child: Text(
                            controller.CHA[index].toString(),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
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
