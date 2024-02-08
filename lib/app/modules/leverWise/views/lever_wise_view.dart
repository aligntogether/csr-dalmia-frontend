import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/modules/leverWise/services/lever_wise_api_services.dart';
import 'package:dalmia/app/modules/overviewPan/service/overviewReportApiService.dart';
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
import 'package:intl/intl.dart';

import '../../../../Constants/constants.dart';
import '../../../../helper/sharedpref.dart';
import '../controllers/lever_wise_controller.dart';

class LeverWiseView extends StatefulWidget {
  LeverWiseView({Key? key}) : super(key: key);

  @override
  _LeverWiseViewState createState() => new _LeverWiseViewState();
}

class _LeverWiseViewState extends State<LeverWiseView> {
  final LeverWiseApiServices leverWiseApiServices =
  new LeverWiseApiServices();
final ExportTableToExcel exportTableToExcel = new ExportTableToExcel();
  LeverWiseController controller = Get.put(LeverWiseController());
bool isLoading = true  ;
  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }
  void downloadExcel() {
    try {
      exportTableToExcel.exportLeverWiseReport(controller);
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
  String name=' ';

  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;
    }));
    ;
    getLeverWiseReport();

  }


  void getLeverWiseReport() async {
    try {
      Map<int,String> regions=await leverWiseApiServices.getAllRegions();
      Map<String,List<String>> regionLocation=await leverWiseApiServices.getRegionLocation(regions);
      print("hh1$regionLocation");
      setState(() {
        controller.updateRegionLocation(regionLocation);
      });
      print("hh2${controller.regionLocation}");
      List<String> allLocations=controller.regionLocation!.values.toList().expand((i) => i).toList();
      print("hh3$allLocations");
      List<Map<String, Map<String, dynamic>>> leverWiseReportData =
      await leverWiseApiServices.getLeverWiseReport(allLocations, controller.levers);

      setState(() {
        isLoading=false;
        controller.updateRegionLocation(regionLocation);
        controller.updateLeverWiseApiReportList(leverWiseReportData);
        print("hh4$leverWiseReportData");
        print("hh$regionLocation");

      });

    } catch (error) {
      // Handle errors
      print("Error fetching report: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final LeverWiseApiServices leverWiseApiServices = LeverWiseApiServices();

    LeverWiseController leverWiseController = Get.put(LeverWiseController());
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,name!,
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
                  "Lever wise number of interventions",
                  style: AppStyle.textStyleBoldMed(fontSize: 14),
                ),
                Space.height(14),
                allRegionsTables(0),
                Space.height(14),
                GestureDetector(
                  onTap: () {
                   downloadExcel();
                  },
                  child: Container(
                        height: MySize.screenHeight*(40/MySize.screenHeight),
                        width: MySize.screenWidth*(150/MySize.screenWidth),
                        decoration: BoxDecoration(
                            border: Border.all(color: darkBlueColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/Excel.svg',
                              height: MySize.screenHeight*(25/MySize.screenHeight),
                              width: MySize.screenWidth*(25/MySize.screenWidth),
                            ),
                            Space.width(3),
                            Text(
                              'Download  Excel',
                              style: TextStyle(
                                  fontSize: MySize.screenHeight*(14/MySize.screenHeight), color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        ),
                      )
                ),
                Space.height(14),
              ],
            ),
          )),
    );
  }
  Widget allRegionsTables(int i) {
    int j =0;
    List<DataColumn> buildColumns() {
      List<DataColumn> columns = [];
      columns.add(
        DataColumn(
          label: Expanded(
            child: Container(
              height: 60,
              width: MySize.screenWidth*(80/MySize.screenWidth),
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
        ),
      );

      for (var region in controller.regionLocation!.keys) {
        for (var location in controller.regionLocation![region]!) {
          // Add the Location column
          columns.add(
            DataColumn(
              label: Expanded(
                child: Container(
                  height: 60,
                  width:MySize.screenWidth*(80/MySize.screenWidth),
                  decoration: BoxDecoration(
                    color: Color(0xff008CD3),

                  ),
                  padding: EdgeInsets.only(left: 10),
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
              ),
            ),
          );
        }
        // Add the Region column if there are locations in the region
        if (controller.regionLocation![region]!.isNotEmpty) {
          columns.add(
            DataColumn(
              label: Expanded(
                child: Container(
                  height: 60,
                  width: MySize.safeWidth!*0.3,
                  decoration: BoxDecoration(
                    //#096C9F

                    color: Color(0xFF096C9F),

                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      region,

                      style: TextStyle(


                        fontWeight: CustomFontTheme.headingwt,
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.white,
                      ),
                      maxLines: 2, // Adjust as needed
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),

          );
          if(region =="East"){
            columns.add(
              DataColumn(
                label: Expanded(
                  child: Container(
                    height: 60,
                    width: MySize.safeWidth!*0.3,
                    decoration: BoxDecoration(
                      //#096C9F

                      color: Color(0xFF096C9F),

                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: Center(
                      child: Text(
                        'Cement',
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      }

      columns.add(
        DataColumn(
          label: Expanded(
            child: Container(
              height: 60,
              width: MySize.safeWidth!*0.3,
              decoration: BoxDecoration(
                //#096C9F

                color: Color(0xFF096C9F),

              ),
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  'Pan India',
                  style: TextStyle(
                    fontWeight: CustomFontTheme.headingwt,
                    fontSize: CustomFontTheme.textSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return columns;
    }

    List<DataRow> buildRows() {

      List<DataRow> rows = [];
      bool isEven = false;
      for (var firstColumn in controller.levers) {
        isEven = !isEven;
        List<DataCell> cells = [];
        cells.add(
          DataCell(
            Container(
              height: MySize.safeHeight!*(70/MySize.screenHeight),
              decoration: BoxDecoration(
                color:isEven
                    ? Colors.blue.shade50
                    : Colors.white,

              ),

              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      firstColumn,
                      style: TextStyle(
                        fontWeight: CustomFontTheme.headingwt,
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.black,
                      ),

                  ),
                ],
              ),
            ),
          ),

        );


        num total=0;
        num sugar=0;
        for (var region in controller.regionLocation!.keys) {

          num sum=0;
          for (var location in controller.regionLocation![region]!) {
            controller.leverWiseApiReportList![0][controller.levers[j]]![location] !=
                null
                ? sum+=controller.leverWiseApiReportList![0][controller.levers[j]]![location]
                : sum+=0;
             cells.add(
              DataCell(
                Container(
                  height: 60,
                  width: MySize.screenWidth*(80/MySize.screenWidth),
                  decoration: BoxDecoration(
                    color:
                   isEven
                        ? Colors.blue.shade50
                        : Colors.white,

                  ),

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerticalDivider(
                        width: 1,
                        color: Color(0xff181818).withOpacity(0.3),
                        thickness: 1,
                      ),
                      Text(
                        // "hi",
                        controller.leverWiseApiReportList![0][controller.levers[j]]![location] !=
                            null
                            ? formatNumber(controller.leverWiseApiReportList![0][controller.levers[j]]![location])+'  '
                            : '0  ',
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.black,
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            );
          }
          // Add an empty cell for the Region column if there are locations in the region
          if (controller.regionLocation![region]!.isNotEmpty) {
            cells.add(
              DataCell(
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF096C9F),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      sum.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          };
          total+=sum;
          if(region=='Sugar'){
            sugar=sum;
          }
          if(region=="East"){
            cells.add(
              DataCell(
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF096C9F),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      (total-sugar).toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );

          }
        }


        cells.add(
          DataCell(
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF096C9F),
              ),
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  total.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );




        rows.add(DataRow(cells: cells));
        j++;
      }
      return rows;
    }
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          dividerThickness: 0,
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
          columns: buildColumns(),
          rows: buildRows(),
        ),
      ),
    );
  }
  // Widget allRegionsTables(int i) {
  //   return isLoading==true?Center(child:CircularProgressIndicator()): SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: DataTable(
  //             dividerThickness: 00,
  //             columnSpacing: 0,
  //             horizontalMargin: 0,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 0,
  //                   blurRadius: 4,
  //                   offset: Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             columns: <DataColumn>[
  //               DataColumn(
  //                 label: Expanded(
  //                   child: Container(
  //                     height: 60,
  //                     decoration: BoxDecoration(
  //                         color: Color(0xff008CD3),
  //                         borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(10.0))),
  //                     padding: EdgeInsets.only(left: 10),
  //                     child: Center(
  //                       child: Text(
  //                         'Locations',
  //                         style: TextStyle(
  //                             fontWeight: CustomFontTheme.headingwt,
  //                             fontSize: CustomFontTheme.textSize,
  //                             color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'DPM',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'ALR',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   child: Center(
  //                     child: Text(
  //                       'BGM',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'KDP',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'CHA',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   color: Color(0xff096C9F),
  //                   height: 60,
  //                   width: 80,
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'SOUTH',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //
  //
  //                       'MEG',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //umg
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'UMG',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //jgr
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'JGR',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //lan
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'LAN',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //NE
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff096C9F),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'NE',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //CUT
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'CUT',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //MED
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'MED',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //BOK
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'BOK',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //RAJ
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'RAJ',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //KAL
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'KAL',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //EAST
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff096C9F),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'East',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //CEMENT
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff2E8CBB),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'Cement',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //NIG
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'NIG',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //RAM
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'RAM',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //JOW
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'JOW',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //NIN
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'NIN',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //KOL
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'KOL',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //SUGAR
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff2E8CBB),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'SUGAR',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               //PANIND
  //               DataColumn(
  //                 label: Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff096C9F),
  //                       borderRadius:
  //                           BorderRadius.only(topRight: Radius.circular(10.0))),
  //                   height: 60,
  //                   width: 80,
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'PANIND',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //             rows: List<DataRow>.generate(
  //               controller.levers.length,
  //                   (index) => DataRow(
  //                 color: MaterialStateColor.resolveWith(
  //                       (states) {
  //                     i = 0;
  //                     return controller.levers[index] == "Households" ||
  //                             controller.levers[index] == "Interventions" ||
  //                             controller.levers[index] ==
  //                                 "HH with Annual Addl. Income"
  //                         ? Color(0xff008CD3).withOpacity(0.3)
  //                         : index.isEven
  //                             ? Colors.blue.shade50
  //                             : Colors.white;
  //                   },
  //                 ),
  //                 cells: [
  //                   DataCell(
  //                     Container(
  //                       width: 150,
  //                       padding: EdgeInsets.only(left: 10),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             controller.levers[index],
  //                             style: controller.levers[index] ==
  //                                         "Households" ||
  //                                     controller.levers[index] ==
  //                                         "Interventions" ||
  //                                     controller.levers[index] ==
  //                                         "HH with Annual Addl. Income"
  //                                 ? TextStyle(
  //                                     color: CustomColorTheme.textColor,
  //                                     fontWeight: CustomFontTheme.headingwt,
  //                                     fontSize: CustomFontTheme.textSize)
  //                                 : AppStyle.textStyleInterMed(fontSize: 14),
  //                           ),
  //                           Spacer(),
  //                           VerticalDivider(
  //                             width: 1,
  //                             color: Color(0xff181818).withOpacity(0.3),
  //                             thickness: 1,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //alr
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //bgm
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //kdp
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //cha
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text( (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                             null
  //                             ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                             : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   ///__________________________ South _______________________
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff096C9F),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   // meg
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //umg
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //jgr
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //lan
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   ///__________________________ NE _______________________
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff096C9F),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                             (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                                 0
  //                                 ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                                 : '0'),
  //                               // : controller.SOUTH[index].toString(),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   //CUT
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //MED
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //BOK
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //RAJ
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //KAL
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //EAST
  //                   ///__________________________ EAST _______________________
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff096C9F),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   //CEMENT
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff2E8CBB),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   //NIG
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   //RAM
  //
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   //JOW
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   //NIN
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               null
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   //KOL
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.leverWiseApiReportList?[0][controller.levers[index]] !=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         VerticalDivider(
  //                           width: 1,
  //                           color: Color(0xff181818).withOpacity(0.3),
  //                           thickness: 1,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   //SUGAR
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff2E8CBB),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   //PANIND
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff096C9F),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           (controller.leverWiseApiReportList![0][controller.levers[index]]!=
  //                               0
  //                               ? controller.leverWiseApiReportList![0][controller.levers[index]]![controller.allLocations[i++]].toString()
  //                               : '0'),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   // Additional row for total
  //                 ],
  //               ),
  //             ) /*+
  //                           [
  //                             DataRow(
  //                               color: MaterialStateColor.resolveWith(
  //                                       (states) => Colors.white),
  //                               cells: [
  //                                 DataCell(
  //                                   Text(
  //                                     'Total',
  //                                     style: TextStyle(
  //                                       fontSize: CustomFontTheme.textSize,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   Text(
  //                                     "44444",
  //                                     style: TextStyle(
  //                                       color: CustomColorTheme.textColor,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                       fontSize: CustomFontTheme.textSize,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   Text(
  //                                     "64546",
  //                                     style: TextStyle(
  //                                       color: CustomColorTheme.textColor,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                       fontSize: CustomFontTheme.textSize,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],*/
  //             ),
  //       ));
  // }
}
