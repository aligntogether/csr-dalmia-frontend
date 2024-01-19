import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void getReport() async {
    Map<String, dynamic> allReport = await locationWiseServices.getAllReport();
    controller.setAllReport(allReport);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    String todayDateIst = DateTime.now().toString().substring(0, 10);
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

                SizedBox(
                    width: MySize.size268,
                    child: Column(
                      children: [
                        Text(
                          "Number of interventions complete\n(as on <$todayDateIst>)",
                          style: AppStyle.textStyleBoldMed(fontSize: 14),
                        ),

                      ],
                    )),
                Space.height(14),
                allRegionsTables()
                    ,
              ],
            ),
          )),
    );
  }

  Widget allRegionsTables() {
    
    return isLoading?Center(child: CircularProgressIndicator()):SingleChildScrollView(
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
                for(var location in controller.allReport!.keys)
                  DataColumn(
                    label: Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff008CD3),),

                        padding: EdgeInsets.only(left: 10),
                        child: Center(
                          child: Text(
                            location,
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),


              ],
              rows: List<DataRow>.generate(
                controller.details.length,
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
                        width: 300,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.details[index],
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Space.width(5),
                            index == 3 || index == 4
                                ? VerticalDivider(
                                    width: 1,
                                    color: Color(0xff181818).withOpacity(0.3),
                                    thickness: 1,
                                  )
                                : SizedBox(),
                            Space.width(5),
                            index == 3 || index == 4
                                ? Column(
                                    children: [
                                      Text(
                                        "> Rs. 50k",
                                        style: AppStyle.textStyleInterMed(
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "> Rs. 1L",
                                        style: AppStyle.textStyleInterMed(
                                            fontSize: 14),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            Spacer(),
                            Space.width(5),
                            VerticalDivider(
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    for(var location in controller.allReport!.keys.toList())
                      DataCell(
                        Container(
                          width: 100,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Text(
                              controller.allReport![location][controller.details2[index]].toString().startsWith('{')
                                  ? "${controller.allReport![location][controller.details2[index]].toString().split('{')[1].split('}')[0]}"==""?"0":"${controller.allReport![location][controller.details2[index]].toString().split('{')[1].split('}')[0]}"
                             : controller.allReport![location][controller.details2[index]].toString()=="null"?"0":"${controller.allReport![location][controller.details2[index]]}",
                                textAlign: TextAlign.start,
                                style: AppStyle.textStyleInterMed(fontSize: 14),
                              ),


                            ],
                          ),
                        ),
                      ),


                    // Additional row for total
                  ],
                ),
              )),
        ));
  }

}
