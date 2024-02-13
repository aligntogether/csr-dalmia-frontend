

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Constants/constants.dart';
import '../../../app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import '../../../app/modules/performanceVdf/controllers/performance_vdf_controller.dart';
import '../../../app/modules/performanceVdf/service/performanceVdfApiService.dart';
import '../../../common/app_style.dart';
import '../../../common/color_constant.dart';
import '../../../common/dropdown_filed.dart';
import '../../../common/size_constant.dart';
import '../../../helper/sharedpref.dart';
import '../../../theme.dart';

class WeeklyProgress extends StatefulWidget {
  int? locationId;

  WeeklyProgress({Key? key,required this.locationId}) : super(key: key);

  @override
  _WeeklyProgressState createState() => new _WeeklyProgressState();
}

class _WeeklyProgressState extends State<WeeklyProgress> {
  final PerformanceVdfApiService performanceVdfApiService = new PerformanceVdfApiService();

  bool isLoading = false;
  PerformanceVdfController controller = Get.put(PerformanceVdfController());
  late Future<Map<String, dynamic>> regionsFuture;
  late Future<Map<String, dynamic>> clustersFuture;
  ExportTableToExcel exportTableToExcel=new ExportTableToExcel();
  void downloadExcel() {
    try {
      exportTableToExcel.exportLocationWisePerformanceToExcel(controller);
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
  String name='';
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;

    }));
    ;
    update();
    regionsFuture = performanceVdfApiService.getListOfRegions();
  }
  void update()async{
    if (widget.locationId != null)  {
      controller.selectLocationId = widget.locationId ;

      controller.update(["add"]);

      controller.selectCluster = null;

      Map<String, dynamic>? clustersData =
      await performanceVdfApiService.getListOfClusters(
          controller.selectLocationId ?? 0);

      if (clustersData != null) {
        print("dfas${clustersData['clusters'][4]['vdfId']}");

        //dont insert in clusters if clustersData['clusters'][index]['vdfId'] is null
        List<Map<String, dynamic>> clusters = [];
        for (int i = 0; i < clustersData['clusters'].length; i++) {
          if (clustersData['clusters'][i]['vdfId'] != null) {
            clusters.add(clustersData['clusters'][i]);
          }
        }


        print("clusters $clusters");


        controller.updateClusters(clusters);

        controller.update(["add"]);
      }

      if (clustersData == null) {
        setState(() {
          controller.clusters = List.generate(
              1, (index) => <String, dynamic>{"vdfName": "No Data Found"});
        });
      }

      setState(() {
        controller.selectClusterId = 0;
        controller.selectCluster = null;
        controller.selectVdfName = null;
        controller.selectVdfId = null;
      });
    }
  }



  void updatePerformanceReport() async {
    Map<String, dynamic> performanceReport = await performanceVdfApiService.getPerformanceReport(controller.selectVdfId ?? 0);
    List<String> headerList= [];
    List<String> details=[];
    performanceReport.forEach((key, value) {
      print("key : $key");
      headerList.add(key);
      value.keys.forEach((element) {
        if(!details.contains(element)){

          details.add(element);
        }
      });

    });
    List<String> headerList1= [];
    num cummulative=0;
    performanceReport.forEach((key, value) {
      num sum=0;
      value.forEach((key, value) {
        if(value!=null){
          sum=sum+value;
        }
      });
      cummulative=cummulative+sum;

    });
    headerList.length>8?headerList1=headerList.sublist(0,8):headerList1=headerList;

    setState(() {

      controller.updatePerformanceReport(performanceReport);
      controller.updateHeaderList(headerList1);
      // controller.updateCummulative(cummulative);
      controller.updateDetails(details);
    });

  }

  @override
  Widget build(BuildContext context) {
    PerformanceVdfController c = Get.put(PerformanceVdfController());
    return SafeArea(
        child: Scaffold(
            appBar: appBarCommon(controller, context,name,
                centerAlignText: true, title: "Reports"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Space.height(16),
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
                  Space.height(32),

                  Text(
                    "Performance of VDF over past 8 weeks",
                    style: AppStyle.textStyleBoldMed(fontSize: 14),
                  ),

                  Space.height(15),

                  GetBuilder<PerformanceVdfController>(
                    id: "add",
                    builder: (controller) {
                      return CustomDropdownFormField(
                        title: "VDF Name",
                        options: controller.clusters != null ? (controller.clusters!
                            .map((cluster) =>
                            cluster['vdfName'].toString())
                            .toList()) : [],
                        selectedValue: controller.selectCluster,
                        onChanged: (String? newValue) async {
                          // Find the selected region and get its corresponding regionId
                          Map<String, dynamic>? selectedCluster = controller.clusters
                          !.firstWhere((cluster) => cluster['vdfName'] == newValue);


                          if (selectedCluster != null &&
                              selectedCluster['clusterId'] != null) {
                            controller.selectClusterId =
                            selectedCluster['clusterId'];
                            controller.selectCluster = newValue;
                            controller.selectVdfName = selectedCluster['vdfName'];
                            controller.selectVdfId= selectedCluster['vdfId'];
                            updatePerformanceReport();
                            controller.update(["add"]);
                            isLoading = true;

                          }


                        },
                      );
                    },

                  ),

                  SizedBox(
                    height:MySize.screenHeight*(20/MySize.screenHeight),
                  ),

                  GetBuilder<PerformanceVdfController>(
                    builder: (controller) {
                      return !isLoading?Center(child: Container(
                        height: MySize.screenHeight*0.1,
                        width: MySize.screenWidth*0.8,

                        child: Center(
                          child: Text("**No Data found**",style:
                          TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),),
                      )):allRegionsTables(0);


                    },
                  ),
                  SizedBox(
                    height:20,
                  ),
                  SizedBox(
                      width: 326,
                      child: Text(
                        "*Note: Cumulative figures are from the beginning of the project, NOT the total of figures displayed on this screen",
                        style: AppStyle.textStyleInterMed(fontSize: 12),
                      )),

                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                      if(controller.selectClusterId!=null && controller.selectLocationId!=null && controller.selectVdfId!=null){
                        downloadExcel();}
                      else
                        Get.snackbar("Error", "Please select a VDF",backgroundColor: Colors.red,colorText: Colors.white);
                      //
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
                    ),
                  ),
                  Space.height(30),
                ],
              ),

            )
        )
    );
  }
  Widget allRegionsTables(int i) {
    int sum = 0;
    return Visibility(
      visible: controller.performanceReport != null && controller.performanceReport!.isNotEmpty,
      child: !isLoading?Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
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

                  for (String date in controller.headerList==null?[]:controller.headerList!)
                    DataColumn(
                      label: Container(
                        height: 60,
                        width: MySize.screenWidth*(120/MySize.screenWidth),
                        color: Color(0xff008CD3),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            date=='cumulative'?"Cumulative":date,
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // DataColumn(label: Container(
                  //   height: 60,
                  //   width: MySize.screenWidth*(120/MySize.screenWidth),
                  //   color: Color(0xff008CD3),
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: Center(
                  //     child: Text(
                  //       "Cumulative",
                  //       style: TextStyle(
                  //         fontWeight: CustomFontTheme.headingwt,
                  //         fontSize: CustomFontTheme.textSize,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),)
                ],
                rows: List<DataRow>.generate(
                  controller.details!.length,
                      (index) => DataRow(
                    color: MaterialStateColor.resolveWith(
                          (states) {
                        i = 0;
                        return
                          Colors.white;
                      },
                    ),

                    cells: [
                      DataCell(
                        Container(
                          width: 200,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text(
                                controller.details![index],
                                style:  AppStyle.textStyleInterMed(fontSize: 14),
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
                      for (String date in controller.headerList!)
                        DataCell(
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                (controller.performanceReport![date]![controller.details![index]])==null
                                    ? "0"
                                    : controller.performanceReport![date]![controller.details![index]].toString(),

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
                      //
                      //   Row(
                      //     children: [
                      //       Spacer(),
                      //       Text(
                      //         ( "0"
                      //         ),
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





                    ],
                  ),
                )),
          )),
      replacement: Container(),
    );


  }


}
