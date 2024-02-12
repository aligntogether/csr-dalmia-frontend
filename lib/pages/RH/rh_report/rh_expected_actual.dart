import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
import 'package:dalmia/app/modules/leverWise/controllers/lever_wise_controller.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../common/color_constant.dart';
import '../../../app/modules/expectedActual/controllers/expected_actual_controller.dart';
import '../../../app/modules/expectedActual/services/expected_actual_service.dart';
class RhExpectedActualView extends StatefulWidget {
  List<String> regions;
   RhExpectedActualView({Key? key,required this.regions}) : super(key: key);
  @override
  State<RhExpectedActualView> createState() => _RhExpectedActualViewState();
}
class _RhExpectedActualViewState extends State<RhExpectedActualView> {
  ExpectedActualController controller = Get.put(ExpectedActualController());
  ExpectedActualServices services = ExpectedActualServices();
  bool isLoading = false;
  LeverWiseController leverWiseController = Get.put(LeverWiseController());
  ExportTableToExcel exportTableToExcel = ExportTableToExcel();
  @override
  void initState() {
    super.initState();
    getExpectActualAdditionalIncome();
    isLoading = true;
  }
  void downloadExcel() {
    try {
      exportTableToExcel.exportExpectedActual(controller,"");
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

  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }
  void getExpectActualAdditionalIncome() async{
    Map<String, dynamic> expectedActualReport=await services.getExpectedActualIncomeReport();
    List<String> clusterIdList = [];
    Map<String, dynamic> clusterList = {};
    List<String> clusterPropertyKeys = [];
    Map<int,String> regions= await services.getAllRegions();
    Map<String,List<String>> regionLocation=await services.getRegionLocation(regions);
    expectedActualReport.forEach((key, value) {
      value.keys.forEach((element) {
        clusterIdList.add(element);
      });
      value.forEach((key, value) {
        clusterList[key] = value;
      });

    });
    clusterList.forEach((key, value) {
      value.keys.forEach((element) {
        clusterPropertyKeys.add(element);
      });
    });
    setState(() {
      controller.updateExpectedActualReport(expectedActualReport);
      print("expectedActualReport $expectedActualReport");
      controller.updateClusterIdList(clusterIdList);
      controller.updateClusterList(clusterList);
      print("clusterList $clusterList");
      controller.updateClusterPropertyKeys(clusterPropertyKeys);
      controller.updateRegionLocation(regionLocation);
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child:appBarCommon(controller, context,"",
              centerAlignText: true, title: "Reports"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
                Center(
                  child: Text(
                    'Expected and actual additional incomes',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<ExpectedActualController>(
                  builder: (cc) {
                    return isLoading
                        ? Center(child: CircularProgressIndicator())
                        : eaaireport(0, cc);
                  },
                ),
                Space.height(14),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        print("download excel");
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
                ),
                Space.height(14),
                Space.height(30),
              ],
            ),
          ),
        ),
      ),
    );}
  Widget eaaireport(int i, ExpectedActualController cc) {
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
                  'Clusters',
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
        if(widget.regions.contains(region)){

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
            if(region=="East"){
              columns.add(
                  DataColumn(
                    label: Expanded(
                      child: Container(
                        height: 60,
                        width: MySize.safeWidth!*0.3,
                        decoration: BoxDecoration(
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
                  )

              );
            }
          }
        }
        else{
         continue;
      }
      }
      //
      // columns.add(
      //     DataColumn(
      //       label: Expanded(
      //         child: Container(
      //           height: 60,
      //           width: MySize.safeWidth!*0.3,
      //           decoration: BoxDecoration(
      //             color: Color(0xFF096C9F),
      //             borderRadius: BorderRadius.only(
      //               topRight: Radius.circular(10.0),
      //             ),
      //           ),
      //           padding: EdgeInsets.only(left: 10),
      //           child: Center(
      //             child: Text(
      //               'Pan India',
      //               style: TextStyle(
      //                 fontWeight: CustomFontTheme.headingwt,
      //                 fontSize: CustomFontTheme.textSize,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //
      // );
      return columns;
    }
    List<DataRow> buildRows() {

      List<DataRow> rows = [];
      bool isEven = false;
      for (var firstColumn in controller.clusterPropertyKeys!) {
        isEven = !isEven;
        List<DataCell> cells = [];
        cells.add(
          DataCell(

            Container(
              height: MySize.safeHeight!*(70/MySize.screenHeight),
              decoration: BoxDecoration(
                color: firstColumn=='clusterId'?Color(0xff008CD3).withOpacity(0.3):
                isEven
                    ? Colors.blue.shade50
                    : Colors.white,

              ),

              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    capitalizeFirstLetter(firstColumn=='clusterId'?'Cluster ${i+1}':firstColumn),
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
          if(widget.regions.contains(region)){
            num sum=0;
            for (var location in controller.regionLocation![region]!) {
              controller.expectedActualReport![location] !=
                  null && firstColumn!='clusterId'
                  ?sum+=(controller.expectedActualReport![location]![cc.clusterIdList![i]]![firstColumn]??0)
                  : sum+=0;
              cells.add(
                DataCell(
                  Container(
                    height: 60,
                    width: MySize.screenWidth*(80/MySize.screenWidth),
                    decoration: BoxDecoration(
                      color:firstColumn=='clusterId'?Color(0xff008CD3).withOpacity(0.3):
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
                          firstColumn=='clusterId'?"": controller.expectedActualReport![location] !=
                              null
                              ? formatNumber(controller.expectedActualReport![location]![cc.clusterIdList![i]]![firstColumn]??0)+"  "
                              : '0  ',
                          // controller.clusterList![cc.clusterIdList![i]]![firstColumn] !=
                          //     null
                          //     ? (controller.clusterList![cc.clusterIdList![i]]![firstColumn]).toString()
                          //     : '0',

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
              if(firstColumn=="sugar"){
                sugar=sum;
              }
              total+=sum;

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
                        firstColumn!='clusterId'?formatNumber(sum.toInt()):"",
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
                          firstColumn!='clusterId'?
                          formatNumber((total-sugar).toInt())+"  ":""
                          ,
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
            };
          }
          else {
            continue
                ;
          }
        }

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
        //           firstColumn!='clusterId'?
        //           formatNumber(total.toInt())+"  ":""
        //           ,
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
        // j++;
      }
      return rows;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DataTable(

          dividerThickness: 0,
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
          columns: buildColumns(),
          rows: buildRows(),

        ),
      ),

    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Return the original string if it's empty
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
