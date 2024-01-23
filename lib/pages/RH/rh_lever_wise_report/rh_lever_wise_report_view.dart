import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/modules/leverWise/services/lever_wise_api_services.dart';

import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';

import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';

import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_controller.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_services.dart';

import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../Constants/constants.dart';
import '../../../common/dropdown_filed.dart';
import '../../../helper/sharedpref.dart';


class RhLeverWiseView extends StatefulWidget {
  String? refId;

  RhLeverWiseView({Key? key,required this.refId}) : super(key: key);

  @override
  _RhLeverWiseViewState createState() => new _RhLeverWiseViewState();
}

class _RhLeverWiseViewState extends State<RhLeverWiseView> {
  String name='';
  final RhLeverWiseReportServices rhLeverWiseReportServices =new RhLeverWiseReportServices();
  final ExportTableToExcel exportTableToExcel = new ExportTableToExcel();
  final RhLeverWiseController controller = Get.put(RhLeverWiseController());
  bool isLoading = true  ;
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? dropdown;
  String message="Loading ...";



  // void downloadExcel() {
  //   try {
  //     exportTableToExcel.exportLeverWiseReport(controller);
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Download Successful'),
  //           content: Text(
  //               'The Excel file has been downloaded successfully in your download folder.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     // Show error dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Download Error'),
  //           content:
  //           Text('An error occurred while downloading the Excel file.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

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
      List<dynamic> regionByRhIdList =
      await rhLeverWiseReportServices.getRegionByRhId(widget.refId!);
      Map<String,dynamic> rhLeverWiseReportByRegionId = await rhLeverWiseReportServices.getRhLeverWiseReportByRegionId(regionByRhIdList[0]['regionId']);
      setState(() {
        isLoading=false;
        controller.updateRegionByRhIdList(regionByRhIdList);
        dropdown=controller.selectedRegion;
        controller.updateRhLeverWiseReportByRegionId(rhLeverWiseReportByRegionId);
      });

    } catch (error) {
      setState(() {
        message="No Data found in your ID";
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,name,
              centerAlignText: true, title: "Reports"),
          body:  SingleChildScrollView(
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
              CustomDropdownFormField(
                title: controller.selectedRegion.toString(),
                options:
                controller.regionByRhIdList != null ? (controller.regionByRhIdList!
                    .map((region) =>
                    region['region'].toString())
                    .toList()) : [],
                selectedValue: controller.selectedRegion,
                onChanged: (String? newValue) async {
                  controller.selectedRegion=newValue;
                  Map<String,dynamic> rhLeverWiseReportByRegionId = await rhLeverWiseReportServices.getRhLeverWiseReportByRegionId(controller.regionByRhIdList![controller.regionByRhIdList!.indexWhere((element) => element['region']==newValue)]['regionId']);
                  setState(() {
                    controller.updateRhLeverWiseReportByRegionId(rhLeverWiseReportByRegionId);
                  });

                },
              ),
                    Space.height(14),

              regionsTables(
                0
              ),
                    Space.height(14),
                    GestureDetector(
                      onTap: () {

                      },
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
                                  fontSize: 14,
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Space.height(14),
                  ],
                ),

          )
      )
    );
  }

  Widget regionsTables(int i) {

    return isLoading==true?Center(
        child:Column(
      children: [
       message=="Loading ..."? CircularProgressIndicator(

        ):Container(),
        Text(message),
      ],
    )): SingleChildScrollView(
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
                  label: Container(
                    height: MySize.safeHeight! * 0.09,
                    width: MySize.safeWidth! * 0.4,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        "Levers",
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                for(var location in controller.rhLeverWiseReportByRegionId!.keys.toList())
                  for(var lever in controller.rhLeverWiseReportByRegionId![location].keys.toList())
                    DataColumn(
                      label: Container(
                        height: MySize.safeHeight! * 0.09,
                        width: MySize.safeWidth! * 0.4,
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            location.toString()+"\n"+lever.toString(),
                             textAlign: TextAlign.center,
                            style: TextStyle(

                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

              ],
              rows: List<DataRow>.generate(
                controller.levers.length,
                    (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                        (states) {
                      i = 0;
                      return Color(0xff008CD3).withOpacity(0.3);

                    },
                  ),
                  cells: [
                    DataCell(
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: MySize.safeHeight! * 0.09,
                        width: MySize.safeWidth! * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xff181818).withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              controller.levers[index],
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),


                          ],

                        ),
                      ),
                    ),

                    for(var location in controller.rhLeverWiseReportByRegionId!.keys.toList())
                       for(var lever in controller.rhLeverWiseReportByRegionId![location].keys.toList())
                          DataCell(
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              height: MySize.safeHeight! * 0.09,
                              width: MySize.safeWidth! * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff181818).withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    controller.rhLeverWiseReportByRegionId![location][lever][controller.levers[index]].toString()=="null"?"0":controller.rhLeverWiseReportByRegionId![location][lever][controller.levers[index]].toString(),
                                    style: AppStyle.textStyleInterMed(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),


                    // Additional row for total
                  ],
                ),
              )
          ),
        ));
  }
}
