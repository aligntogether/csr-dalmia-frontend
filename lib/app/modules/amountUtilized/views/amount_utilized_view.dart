import 'package:dalmia/Constants/constant_export.dart';
import 'package:dalmia/app/modules/amountUtilized/service/amountUtilizedApiService.dart';
import 'package:dalmia/app/modules/downloadExcelFromTable/ExportTableToExcel.dart';
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
  String? refId;

  AmountUtilizedView({Key? key, this.refId}) : super(key: key);

  @override
  _AmountUtilizedViewState createState() => new _AmountUtilizedViewState();
}

class _AmountUtilizedViewState extends State<AmountUtilizedView> {
  final AmountUtilizedApiService amountUtilizedApiService =
      new AmountUtilizedApiService();
  int isRH = 0;
  bool isLoading = true;
  String name = "";
  String userId = "";

  AmountUtilizedController controller = Get.put(AmountUtilizedController());

  @override
  void initState() {
    super.initState();
    print("refId: ${widget.refId}");
    setRegions(widget.refId!);
  }

  void setRegions(String userId) async {
    Map<int, String> regions =
        await amountUtilizedApiService.getListOfRegions(userId);
    Map<String, List<String>> locations =
        await amountUtilizedApiService.getListOfLocations(regions);
    Map<String,dynamic> data =
    await amountUtilizedApiService.getAmountUtilizedByRhId(
        userId);
    setState(() {
      controller.updateRegions(regions);
      controller.updateLocations(locations);
      print(data['Dalmiapuram']['utilized']);
      controller.updateData(data);
      isLoading = false;
    });
  }
  ExportTableToExcel exportTableToExcel = new ExportTableToExcel();
  void downloadExcel() {
    try {
      exportTableToExcel.exportAmountUtilizedToExcel(controller);
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

  @override
  Widget build(BuildContext context) {
    AmountUtilizedController amountUtilizedController =
        Get.put(AmountUtilizedController());
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context, name,
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
                        "(Rupees /in Lakhs)",
                        style: AppStyle.textStyleInterMed(fontSize: 14),
                      ),
                    ],
                  )),
              amountUtilizedReport(0),
              // selectedRHRegionsTables(0),

              Space.height(14),

              GestureDetector(
                onTap: () {
                  downloadExcel();
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

  Widget amountUtilizedReport(int i) {
    List<DataColumn> buildColumns() {
      List<DataColumn> columns = [];
      columns.add(
        DataColumn(
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
        ),
      );

      for (var region in controller.locations!.keys) {
        for (var location in controller.locations![region]!) {
          // Add the Location column
          columns.add(
            DataColumn(
              label: Expanded(
                child: Container(
                  height: 60,
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
        if (controller.locations![region]!.isNotEmpty) {
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
        }
      }
      return columns;
    }

    List<DataRow> buildRows() {
      List<DataRow> rows = [];
      bool isEven = false;
      for (var firstColumn in controller.columns) {
        isEven = !isEven;
        List<DataCell> cells = [];
        cells.add(
          DataCell(
            Container(
              height: MySize.safeHeight!*(70/MySize.screenHeight),
              decoration: BoxDecoration(
                color: isEven ? Colors.white : Colors.blue.shade50,

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


        for (var region in controller.locations!.keys) {
          num sum=0;
          for (var location in controller.locations![region]!) {

            controller.data!.keys.contains(location)
                ? sum+=controller.data![location][controller.objectKeys[i]]:sum+=0;
            cells.add(
              DataCell(
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: isEven ? Colors.white : Colors.blue.shade50,

                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                        controller.data!.keys.contains(location)
                            ? controller.data![location][controller.objectKeys[i++]].toString()
                            : "0",


                      style: TextStyle(

                        fontSize: CustomFontTheme.textSize,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );

          }
          // Add an empty cell for the Region column if there are locations in the region
          if (controller.locations![region]!.isNotEmpty) {
            cells.add(
              DataCell(
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: isEven ? Colors.white : Colors.blue.shade50,

                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: Center(
                      child: Text(
                         sum.toString(),
                        style: TextStyle(

                          fontSize: CustomFontTheme.textSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ),
            );
          }
        }

        rows.add(DataRow(cells: cells));
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

}
