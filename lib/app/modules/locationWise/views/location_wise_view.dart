import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/constants.dart';
import '../../../../common/app_style.dart';
import '../../../../common/size_constant.dart';
import '../../../../helper/sharedpref.dart';
import '../../../../pages/gpl/gpl_home_screen.dart';
import '../../../../theme.dart';
import '../../overviewPan/views/overview_pan_view.dart';
import '../controllers/location_wise_controller.dart';
import '../services/location_wise_services.dart';

class LocationWiseView extends StatefulWidget {
  const LocationWiseView({Key? key}) : super(key: key);

  @override
  _LocationWiseViewState createState() => _LocationWiseViewState();
}

class _LocationWiseViewState extends State<LocationWiseView> {
  bool isLoading = true;
  LocationWiseController controller = Get.put(LocationWiseController());
  LocationWiseServices locationWiseServices = LocationWiseServices();
  String name=' ';
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;
    }));
    ;
    getReport();
  }
  String formatNumber(int number) {
    NumberFormat format = NumberFormat('#,##,###', 'en_IN');
    return format.format(number);
  }

  void getReport() async {
    Map<String, dynamic> allReport = await locationWiseServices.getAllReport();
    Map<int,String> regions=await locationWiseServices.getAllRegions();
    Map<String,List<String>> regionLocation=await locationWiseServices.getRegionLocation(regions);

    setState(() {
      isLoading = false;
      controller.setAllReport(allReport);
      controller.updateRegionLocation(regionLocation);
    });
  }

  @override
  Widget build(BuildContext context) {

    var todayDateIst = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(todayDateIst);
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
                          "Number of interventions completed\n(as on $formattedDate)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.black),
                          ),
                Space.height(14),
                allRegionsTables(0)
                    ,
              ],
            ),
          )),
    );
  }

  Widget allRegionsTables(int i) {

    int j=1;
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
              color: Color(0xFF096C9F),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                ),
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
      for (var firstColumn in controller.details) {
        isEven = !isEven;
        List<DataCell> cells = [];
        if(firstColumn =='No. of HHs with planned int.' || firstColumn== 'No. of HHs with AAAI'){
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
                    children:[
                      Text(
                        firstColumn,
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.black,
                        ),

                      ),
                      VerticalDivider(
                        width: 1,
                        color: Color(0xff181818).withOpacity(0.3),
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text(
                            "> Rs. 1L",
                            style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "> Rs. 50k",
                            style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ),
          );
        }
        else{
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
                    children:[
                      Text(
                        firstColumn,
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.black,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          );
        }
        num total=0;

        for (var region in controller.regionLocation!.keys) {
          num sum =0;
          num sumPlanned=0;
          num sumActual=0;
          for (var location in controller.regionLocation![region]!) {
            print("location : $location region : $region j : $j  ${controller.details2[j]}");
            if(controller.allReport![location]!=null){
              if(controller.allReport![location][controller.details2[j]]!=null){
                if(controller.details2[j]=='plannedEaai'){
                  // sumPlanned+=controller.allReport![location][controller.details2[j]].toString()=="{}"?0:controller.allReport![location][controller.details2[j]]["50k-1L"];
                  // sumActual+=controller.allReport![location][controller.details2[j]].toString()=="{}"?0:controller.allReport![location][controller.details2[j]][">1L"];
                }
                else if(controller.details2[j]=='actualAaai'){
                  // sumPlanned+=controller.allReport![location][controller.details2[j]].toString()=="{}"?0:controller.allReport![location][controller.details2[j]]["50k-1L"];
                  // sumActual+=controller.allReport![location][controller.details2[j]].toString()=="{}"?0:controller.allReport![location][controller.details2[j]][">1L"];
                }
                else{
                  sum+=controller.allReport![location][controller.details2[j]];
                }

              }
            }

            cells.add(
              DataCell(
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 60,
                  width: MySize.screenWidth * (80 / MySize.screenWidth),
                  decoration: BoxDecoration(
                    color: isEven
                        ? Colors.blue.shade50
                        : Colors.white,

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerticalDivider(
                        width: 1,
                        color: Color(0xff181818).withOpacity(0.3),
                        thickness: 1,
                      ),
                      controller.allReport![location]==null?
                      Text(
                        "0",
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.black,
                        ),
                      ):
                      controller.allReport![location][controller.details2[j]]==null?
                      Text("0"):(controller.details2[j]=='plannedEaai'||controller.details2[j]=='actualAaai')
                          ?
                      Column(
                        children: [
                          Text(
                            "${controller.allReport![location][controller.details2[j]].toString()=="{}"?"0  ":controller.allReport![location][controller.details2[j]][">1L"]}  ",
                            style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${controller.allReport![location][controller.details2[j]].toString()=="{}"?"0  ":controller.allReport![location][controller.details2[j]]["50k-1L"]}  ",
                            style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                          :
                      Text(
                        controller.allReport![location]==null?
                        "0":
                        "${controller.allReport![location][controller.details2[j]]==null?
                        "0":
                        formatNumber(controller.allReport![location][controller.details2[j]])}  "
                        ,style: TextStyle(
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
          if (controller.regionLocation![region]!.isNotEmpty) {
            total+=sum;
            cells.add(
              DataCell(
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 60,
                  width: MySize.safeWidth! * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xFF096C9F),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerticalDivider(
                        width: 1,
                        color: Color(0xff181818).withOpacity(0.3),
                        thickness: 1,
                      ),
                      Text(
                        formatNumber(sum.toInt())+"  ",
                        // controller.overviewMappedList![0][controller.objectKeys[j]]![region]==null?"0":formatNumber(controller.overviewMappedList![0][controller.objectKeys[j]]![region])+"  ",

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
            if(region=='East'){
              cells.add(
                DataCell(
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 60,
                    width: MySize.safeWidth! * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFF096C9F),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VerticalDivider(
                          width: 1,
                          color: Color(0xff181818).withOpacity(0.3),
                          thickness: 1,
                        ),
                        Text(
                          "00",
                          // controller.overviewMappedList![0][controller.objectKeys[j]]!["Cement"]==null?"0":formatNumber(controller.overviewMappedList![0][controller.objectKeys[j]]!["Cement"])+"  ",

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
          }
        }

        cells.add(
          DataCell(
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 60,
              width: MySize.safeWidth! * 0.3,
              decoration: BoxDecoration(
                color: Color(0xFF096C9F),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalDivider(
                    width: 1,
                    color: Color(0xff181818).withOpacity(0.3),
                    thickness: 1,
                  ),
                  Text(
                    formatNumber(total.toInt())+"  ",
                    // controller.overviewMappedList![0][controller.objectKeys[j]]!["Pan India"]==null?"0":formatNumber(controller.overviewMappedList![0][controller.objectKeys[j]]!["Pan India"])+"  ",

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
        rows.add(DataRow(cells: cells));
        j++;
      }
      return rows;
    }
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {

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
              columns: buildColumns(),
              rows: buildRows()),
        ));
    }
  }

}
