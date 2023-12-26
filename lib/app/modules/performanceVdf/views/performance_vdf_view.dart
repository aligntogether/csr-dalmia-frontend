import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/performance_vdf_controller.dart';

class PerformanceVdfView extends GetView<PerformanceVdfController> {
  const PerformanceVdfView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PerformanceVdfController c = Get.put(PerformanceVdfController());
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,
              centerAlignText: true, title: "Reports"),
          body: Column(
            children: [
              //appBar(context, title: "Performance of VDF "),
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
                    viewOtherReports(context),
                    Space.width(16),
                  ],
                ),
              ),
              Space.height(32),
              GetBuilder<PerformanceVdfController>(
                builder: (controller) {
                  return CustomDropdownFormField(
                      title: "Select a Region",
                      options: [
                        "South & Chandrapur",
                        "Sugar",
                        "East",
                        "North East",
                      ],
                      selectedValue: controller.selectLocation,
                      onChanged: (String? newValue) async {
                        controller.selectLocation = newValue;
                        controller.update();
                      });
                },
              ),

              GetBuilder<PerformanceVdfController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomDropdownFormField(
                        title: "Select a Location",
                        options: [
                          "South & Chandrapur",
                          "Sugar",
                          "East",
                          "North East",
                          "All Regions"
                        ],
                        selectedValue: controller.selectP,
                        onChanged: (String? newValue) async {
                          controller.selectP = newValue;
                          controller.update();
                        }),
                  );
                },
              ),
              GetBuilder<PerformanceVdfController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomDropdownFormField(
                        title: "VDF Name",
                        options: [
                          "Balamurugan",
                          "Gujrat",
                          "Rajkot",
                        ],
                        selectedValue: controller.selectVdf,
                        onChanged: (String? newValue) async {
                          controller.selectVdf = newValue;
                          controller.update();
                        }),
                  );
                },
              ),
              Space.height(20),
              Text(
                "Performance of VDF over past 8 weeks",
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),
              Space.height(16),

              SizedBox(
                  width: 326,
                  child: Text(
                    "*Note: Cumulative figures are from the beginning of the project, NOT the total of figures displayed on this screen",
                    style: AppStyle.textStyleInterMed(fontSize: 12),
                  )),
              Space.height(30),
              GestureDetector(
                onTap: () {},
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
                      Text(
                        'Download  Excel',
                        style: AppStyle.textStyleInterMed(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Space.height(30),
            ],
          )),
    );
  }
}
