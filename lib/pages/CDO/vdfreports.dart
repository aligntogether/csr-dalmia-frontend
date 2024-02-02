import 'dart:convert';

import 'package:dalmia/Constants/constant_export.dart';
import 'package:dalmia/app/modules/overviewPan/service/overviewReportApiService.dart';
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/pages/CDO/vdf_report_controller.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../common/size_constant.dart';
import '../../helper/sharedpref.dart';

class VdfReport extends StatefulWidget {
  const VdfReport({Key? key}) : super(key: key);

  @override
  State<VdfReport> createState() => _VdfReportState();
}

class _VdfReportState extends State<VdfReport> {
  List<Map<String, dynamic>> VdfReportData = [];
  VDFReportController controller = VDFReportController();
  String cdoId = '';

  @override
  void initState() {
    super.initState();

    SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? cdoId = '10001' : cdoId = value;
      fetchlocationId(cdoId);
    }));
    ;

  }
  void fetchlocationId(String cdoId) {
    var url = Uri.parse(
        'https://mobileqacloud.dalmiabharat.com:443/csr/locations/search/findLocationIdByCdoId?cdoId=$cdoId');
    http.get(url).then((response) {
      var data = json.decode(response.body);

      controller.selectLocationId = data;
      fetchData();
      return controller.selectLocationId;
    });

  }
  bool isLoadingLocation = true;

  Future<void> fetchData() async {
    OverviewReportApiService overviewReportApiService = OverviewReportApiService();

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
  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }

  List<String> vdfDetails = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: PreferredSize(

          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
            heading: 'VDF Reports',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CDOHome(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_sharp,
                      ),
                      Text(
                        'Main Menu',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                tableDataLocationView(0),
                SizedBox(
                  height: MySize.screenHeight*(40/MySize.screenHeight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate a random number
  int _generateRandomNumber() {
    return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
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
        // Add an empty cell for the Region column if there are locations in the region

        // cells.add(
        //   DataCell(
        //     Container(
        //       height: 60,
        //       decoration: BoxDecoration(
        //         color: Color(0xFF096C9F),
        //       ),
        //       padding: EdgeInsets.only(left: 10),
        //       child: Center(
        //         child: Text(
        //           firstColumn == "Households" ||
        //               firstColumn == "Interventions" ||
        //               firstColumn == "HH with Annual Addl. Income"
        //               ?"":sum.toString(),
        //           textAlign: TextAlign.right,
        //
        //           style: TextStyle(
        //             fontSize: CustomFontTheme.textSize,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // );


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
