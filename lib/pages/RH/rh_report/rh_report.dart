import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_controller.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_services.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/constants.dart';
import '../../../../helper/sharedpref.dart';
import '../../../app/modules/overviewPan/controllers/overview_pan_controller.dart';
import '../../../app/modules/overviewPan/service/overviewReportApiService.dart';



class RhReportView extends StatefulWidget {
  String? refId;

  RhReportView({Key? key,required this.refId}) : super(key: key);

  @override
  _RhReportViewState createState() => new _RhReportViewState();
}

class _RhReportViewState extends State<RhReportView> {
  final OverviewReportApiService overviewReportApiService = new OverviewReportApiService();

  OverviewPanController controller = Get.put(OverviewPanController());
  late Future<Map<String, dynamic>> regionsFuture;
  late Future<Map<String, dynamic>> clustersFuture;
  bool isLoading = true;
  bool isLoadingLocation=true;
  ExportTableToExcel exportsTableToExcel = new ExportTableToExcel();
  RhLeverWiseReportServices rhLeverWiseReportServices=new RhLeverWiseReportServices();

  void downloadExcel(String location) {
    try {
      exportsTableToExcel.exportPanIndiaReportAllRegion(
        controller, location
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
  String name=' ';

  String? dropdown;
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;
    }));
    ;
    getPanIndiaReport();

    regionsFuture = overviewReportApiService.getListOfRegions();
    controller.selectRegion = "All Regions";
  }
  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }
  void getPanIndiaReport() async {
    List<dynamic> regionByRhIdList =
    await rhLeverWiseReportServices.getRegionByRhId(widget.refId!);
    List<Map<String, Map<String, dynamic>>> panIndiaMappedData = await overviewReportApiService.getPanIndiaReport(controller.allLocations, controller.objectKeys);
    Map<int,String> regions=await overviewReportApiService.getAllRegions();
    Map<String,List<String>> regionLocation=await overviewReportApiService.getRegionLocation(regions);
    setState(() {
      isLoading = false;
      controller.updateRegionByRhId(regionByRhIdList);
      dropdown=controller.selectedRegion;
      controller.updateOverviewMappedList(panIndiaMappedData);
      controller.updateRegionLocation(regionLocation);
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
          appBar: appBarCommon(controller, context,name,
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

                ///_________________________________ drop downs__________________________///
                GetBuilder<OverviewPanController>(
                  id: "add",
                  builder: (controller) {
                    return FutureBuilder<Map<String, dynamic>>(
                      // Assuming that getListOfRegions returns a Future<Map<String, dynamic>>
                      future: regionsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          Map<String, dynamic> responseData = snapshot.data ?? {};

                          if (responseData.containsKey('regions')) {
                            List<Map<String, dynamic>> regionOptions =
                            responseData['regions'];

                            return CustomDropdownFormField(
                              title: controller.selectedRegion.toString(),
                              options: controller.regionByRhIdList != null ? (controller.regionByRhIdList!
                                  .map((region) =>
                                  region['region'].toString())
                                  .toList()) : [],
                              selectedValue: controller.selectedRegion,
                              onChanged: (String? newValue) async {
                                controller.selectedRegion=newValue;


                                  controller.update(["add"]);

                                  // Get locations based on the selected regionId
                                  Map<String, dynamic> locationsData =
                                  await overviewReportApiService.getListOfLocations(
                                          controller.regionByRhIdList![controller.regionByRhIdList!.indexWhere(
                                                  (element) => element['region']==newValue)]['regionId']);

                                  // Extract the list of locations from the returned data
                                  List<Map<String, dynamic>> locations =
                                  locationsData['locations'];

                                  // Update the controller with the new list of locations
                                  controller.updateLocations(locations);
                                  controller.update(["add"]);

                                  List<String> locationsCode = locations != null ? (controller.locations!
                                      .map((location) =>
                                      location['locationCode'].toString())
                                      .toList()) : [];
                                  locationsCode.add("TOTAL");

                                  List<Map<String, Map<String, dynamic>>> regionWiseMappedList = await overviewReportApiService.getRegionWiseReport(locationsCode, controller.objectKeys, controller.regionByRhIdList![controller.regionByRhIdList!.indexWhere(
                                          (element) => element['region']==newValue)]['regionId']);

                                  print("regionWiseMappedList : $regionWiseMappedList \n\n");
                                  // print("regionWiseMappedList1 : ${regionWiseMappedList[0]}");
                                  // print("regionWiseMappedList2 : ${regionWiseMappedList[0]["allotted"]}");
                                  // print("regionWiseMappedList3 : ${regionWiseMappedList[0]["mapped"]!["DPM"]}");
                                  // print("regionWiseMappedList3 : ${regionWiseMappedList[0]["mapped"]!["TOTAL"]}");

                                  setState(() {
                                    controller.updateRegionWiseMappedList(regionWiseMappedList);
                                    controller.updateParticularWiseList(locationsCode);

                                  });






                                }

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
                controller.selectRegion != "All Regions" ?
                GetBuilder<OverviewPanController>(
                  id: "add",
                  builder: (controller) {
                    return CustomDropdownFormField(
                      title: "Select Location",
                      options:
                      controller.locations != null ? (controller.locations!
                          .map((location) =>
                          location['location'].toString())
                          .toList()) : [],
                      selectedValue: controller.selectLocation,
                      onChanged: (String? newValue) async {

                        // Find the selected location and get its corresponding locationId
                        if (controller.locations != null) {
                          // Find the selected location object based on the 'location' property

                          // print('controller.locations: ${controller.locations}');


                          Map<String, dynamic>? selectedLocation = controller.locations
                              ?.firstWhere((location) => location['location'] == newValue);

                          if (selectedLocation != null) {

                            // Access the locationId property and convert it to int
                            int? selectedLocationId =
                            selectedLocation['locationId'];

                            // print('selectedLocationId: $selectedLocationId');

                            if (selectedLocationId != null) {
                              // Assign 'location' to controller.selectLocation

                              setState(() {
                                controller.selectLocationId = selectedLocationId;
                                controller.selectLocation =
                                selectedLocation['location'] as String;
                              });

                              controller.update(["add"]);

                              controller.selectCluster = null;

                              Map<String, dynamic>? clustersData = await overviewReportApiService.getListOfClusters(controller.selectLocationId ?? 0);


                              if (clustersData != null) {
                                List<Map<String, dynamic>> clusters =
                                clustersData['clusters'];

                                print("clusters.length : ${clusters.length}");
                                print("clusters : $clusters");


                                setState(() {
                                  controller.updateClusters(clusters);
                                });
                                controller.update(["add"]);


                                var clustersVdfNameList = clusters.map((
                                    cluster) => cluster['vdfName'].toString())
                                    .toList();
                                clustersVdfNameList.add("TOTAL");

                                List<Map<String,
                                    Map<String,
                                        dynamic>>> locationWiseMappedList = await overviewReportApiService
                                    .getLocationWiseReport(
                                    clustersVdfNameList, controller.objectKeys,
                                    controller.selectLocationId!);

                                if (locationWiseMappedList.isNotEmpty) {
                                  setState(() {
                                    controller.updateLocationWiseMappedList(
                                        locationWiseMappedList);
                                    controller.updateLocationVdfNames(
                                        clustersVdfNameList);
                                    isLoadingLocation = false;
                                  });
                                }

                                if (locationWiseMappedList.isEmpty) {
                                  setState(() {
                                    controller.updateLocationWiseMappedList([]);
                                  });
                                }


                              }


                              print("controller.vdfNames : ${controller.vdfNames}");

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
                    :
                Container(),


                Space.height(30),
                GetBuilder<OverviewPanController>(
                  builder: (controller) {
                    return commonTitle(controller.selectLocation == null
                        ? "Overview ${controller.selectedRegion} Locations"
                        : "Overview ${controller.selectLocation}");
                  },
                ),
                Space.height(16),
                GetBuilder<OverviewPanController>(
                  builder: (controller) {
                    return  tableParticularRegion(0);

                  },
                ),
                Space.height(34),
                GestureDetector(
                    onTap: () {
                      downloadExcel(controller.selectRegion!);
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
                Space.height(10)
              ],
            ),
          )),
    );
  }




  Widget tableParticularRegion(int i) {
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


      for (var location in controller.regionLocation![controller.selectedRegion]!) {
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
      if (controller.regionLocation![controller.selectedRegion]!.isNotEmpty) {
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
                    controller.selectedRegion!,

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
      }

      return columns;
    }

    List<DataRow> buildRows() {

      List<DataRow> rows = [];
      bool isEven = false;
      for (var firstColumn in controller.locationsList) {
        isEven = !isEven;
        List<DataCell> cells = [];
        cells.add(
          DataCell(
            Container(
              height: MySize.safeHeight!*(70/MySize.screenHeight),
              decoration: BoxDecoration(
                color:firstColumn == "Households" ||
                    firstColumn == "Interventions" ||
                    firstColumn ==
                        "HH with Annual Addl. Income"
                    ? Color(0xff008CD3).withOpacity(0.3)
                    :isEven
                    ? Colors.blue.shade50
                    : Colors.white,

              ),

              padding: EdgeInsets.only(left: 10),
              child:  Row(
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
        print("j$j");


        num sum=0;
        for (var location in controller.regionLocation![controller.selectedRegion]!) {
          controller.objectKeys[j] == "Households" ||
              controller.objectKeys[j] == "Interventions" ||
              controller.objectKeys[j] == "HH with Annual Addl. Income"
              ?sum+=0
              :controller.overviewMappedList![0][controller.objectKeys[j]]![location]==null?sum+=0:sum+=controller.overviewMappedList![0][controller.objectKeys[j]]![location];
          cells.add(
            DataCell(
              Container(
                height: 60,
                width: MySize.screenWidth*(80/MySize.screenWidth),
                decoration: BoxDecoration(
                  color:
                  firstColumn == "Households" ||
                      firstColumn == "Interventions" ||
                      firstColumn == "HH with Annual Addl. Income"
                      ? Color(0xff008CD3).withOpacity(0.3)
                      :isEven
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
                      firstColumn == "Households" ||
                          firstColumn == "Interventions" ||
                          firstColumn == "HH with Annual Addl. Income"
                          ?""
                          :controller.overviewMappedList![0][controller.objectKeys[j]]![location]==null?"0":formatNumber(controller.overviewMappedList![0][controller.objectKeys[j]]![location])+"  ",

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
        if (controller.regionLocation![controller.selectedRegion]!.isNotEmpty) {
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
                    firstColumn == "Households" ||
                        firstColumn == "Interventions" ||
                        firstColumn == "HH with Annual Addl. Income"
                        ?"":sum.toString(),
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
  Widget tableDataLocationView(int i) {
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
                  'Details',
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


      for (var name in controller.vdfNames!) {
        // Add the Location column
        if(name=="null"){
          continue;
        }
        else if(name=="TOTAL"){
          columns.add(
            DataColumn(
              label: Expanded(
                child: Container(
                  height: 60,
                  width:MySize.screenWidth*(80/MySize.screenWidth),
                  decoration: BoxDecoration(
                    color: Color(0xFF096C9F),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                    ),

                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      softWrap: true,
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
        else {
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
                      name,
                      textAlign: TextAlign.center,
                      softWrap: true,
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


      return columns;
    }

    List<DataRow> buildRows() {

      List<DataRow> rows = [];
      bool isEven = false;
      for (var firstColumn in controller.locationsList) {
        isEven = !isEven;
        List<DataCell> cells = [];
        cells.add(
          DataCell(
            Container(
              height: MySize.safeHeight!*(70/MySize.screenHeight),
              decoration: BoxDecoration(
                color:firstColumn == "Households" ||
                    firstColumn == "Interventions" ||
                    firstColumn ==
                        "HH with Annual Addl. Income"
                    ? Color(0xff008CD3).withOpacity(0.3)
                    :isEven
                    ? Colors.blue.shade50
                    : Colors.white,

              ),

              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  firstColumn,
                  style: TextStyle(
                    fontWeight: CustomFontTheme.headingwt,
                    fontSize: CustomFontTheme.textSize,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

        );



        num sum=0;
        for (var name in controller.vdfNames!) {
          controller.objectKeys[j] == "Households" ||
              controller.objectKeys[j] == "Interventions" ||
              controller.objectKeys[j] == "HH with Annual Addl. Income"
              ?sum+=0
              :controller.locationWiseMappedList![0][controller.objectKeys[j]]![name]==null
              ?sum+=0:sum+=controller.locationWiseMappedList![0][controller.objectKeys[j]]![name];
          if(name=="null"){
            continue;
          }
          else if(name=="TOTAL"){
            cells.add(
              DataCell(
                Container(
                  height: 60,
                  width: MySize.screenWidth*(80/MySize.screenWidth),
                  decoration: BoxDecoration(

                      color: Color(0xFF096C9F)


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
                        firstColumn == "Households" ||
                            firstColumn == "Interventions" ||
                            firstColumn == "HH with Annual Addl. Income"
                            ?""
                            :controller.locationWiseMappedList![0][controller.objectKeys[j]]![name]==null
                            ?"0":formatNumber(controller.locationWiseMappedList![0][controller.objectKeys[j]]![name])+"  ",

                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.white,
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            );
          }
          else{
            cells.add(
              DataCell(
                Container(
                  height: 60,
                  width: MySize.screenWidth*(80/MySize.screenWidth),
                  decoration: BoxDecoration(
                    color:
                    firstColumn == "Households" ||
                        firstColumn == "Interventions" ||
                        firstColumn == "HH with Annual Addl. Income"
                        ? Color(0xff008CD3).withOpacity(0.3)
                        :isEven
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
                        firstColumn == "Households" ||
                            firstColumn == "Interventions" ||
                            firstColumn == "HH with Annual Addl. Income"
                            ?""
                            :controller.locationWiseMappedList![0][controller.objectKeys[j]]![name]==null
                            ?"0":formatNumber(controller.locationWiseMappedList![0][controller.objectKeys[j]]![name])+"  ",

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
        }


        rows.add(DataRow(cells: cells));
        j++;
      }
      return rows;
    }
    return isLoadingLocation == true
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



}
