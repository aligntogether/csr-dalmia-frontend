import 'package:dalmia/app/modules/generalInfo/controllers/general_info_controller.dart';
import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClusterFormationView extends StatelessWidget {
  const ClusterFormationView({super.key});

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
                  viewOtherReports(context,
                      title: "HH and Population\nDetails "),
                  Space.width(16),
                ],
              ),
            ),
            Space.height(24),

            GetBuilder<GeneralInfoController>(
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select a Region",
                    options: [
                      "South & Chandrapur",
                      "Sugar",
                      "East",
                      "North East",
                      "All Regions"
                    ],
                    selectedValue: controller.selectLocation,
                    onChanged: (String? newValue) async {
                      controller.selectLocation = newValue;
                      controller.update();
                    });
              },
            ),
            Space.height(30),

            SizedBox(
              width: MySize.size210,
              child: Text(
                "Cluster formation details of PAN India regions",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),
            ),
            Space.height(18),
            allRegionsTables(controller),
            Space.height(16),

            //allRegionsTables(controller)
          ],
        ),
      ),
    ));
  }

  Widget allRegionsTables(GeneralInfoController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xff181818).withOpacity(0.2))),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///_________________Regions
                Container(
                  width: 172,
                  height: 33,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Regions",
                      style: AppStyle.textStyleInterMed(
                          color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),

                ///Details

                Container(
                  width: 172,
                  height: 33,
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      "Details",
                      style: AppStyle.textStyleInterMed(
                          color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),

                ///Clusters

                Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Clusters",
                          style: AppStyle.textStyleInterMed(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                      Space.height(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text(
                                "1",
                                style: AppStyle.textStyleInterMed(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text("2",
                                  style: AppStyle.textStyleInterMed(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text("3",
                                  style: AppStyle.textStyleInterMed(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text("4",
                                  style: AppStyle.textStyleInterMed(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text("5",
                                  style: AppStyle.textStyleInterMed(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                          Container(
                            height: 33,
                            width: 79,
                            child: Center(
                              child: Text("Total",
                                  style: AppStyle.textStyleInterMed(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 33,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
