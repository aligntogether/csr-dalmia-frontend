import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Reportss',
              style: AppStyle.textStyleInterMed(
                  fontSize: 16, fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close)),
              Space.width(20)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Space.height(40),
                listData("Overview Pan-India locations", () {
                  Get.toNamed(Routes.OVERVIEW_PAN);
                }),
                listData(
                    "Location wise EAAI and AAAI Achieved(as on <19 Oct 2023>)",
                    () {
                  Get.toNamed(Routes.LOCATION_WISE);
                }),
                listData("Lever wise number of interventions", () {
                  Get.toNamed(Routes.LEVER_WISE);
                }),
                listData(
                    "Amount utilized by each location for livelihood activities ",
                    () {
                  Get.toNamed(Routes.AMOUNT_UTILIZED);
                }),
                listData("Source of funds", () {
                  Get.toNamed(Routes.SOURCE_FUNDS);
                }),
                listData("Expected and actual additional incomes", () {
                  Get.toNamed(Routes.EXPECTED_ACTUAL);
                }),
                listData("Performance of VDFs", () {
                  Get.toNamed(Routes.PERFORMANCE_VDF);
                }),
              ],
            ),
          )),
    );
  }

  Widget listData(String title, Function onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Row(
            children: [
              SizedBox(
                  width: MySize.size278,
                  child: Text(
                    title,
                    style: AppStyle.textStyleInterMed(fontSize: 14),
                  )),
              Spacer(),
              Image.asset(
                ImageConstant.arrowB,
                height: 18,
              ),
            ],
          ),
        ),
        Space.height(20),
        Divider(
          height: 1,
          color: dividerColor.withOpacity(0.3),
        ),
        Space.height(20),
      ],
    );
  }
}
