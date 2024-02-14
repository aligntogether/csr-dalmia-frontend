import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/reports_controller.dart';
import 'gpl_amount_utilized_view.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todayDateIst = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(todayDateIst);

  return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Reports',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Space.height(MySize.screenHeight*(40/MySize.screenHeight)),
                  listData("Overview Pan-India locations", () {
                    Get.toNamed(Routes.OVERVIEW_PAN);
                  }),
                  listData(
                      "Number of interventions completed\n(as on $formattedDate)",
                          () {
                        Get.toNamed(Routes.INTERVENTION_COMPLETE);

                      }),
                  listData("Lever wise number of interventions", () {
                    Get.toNamed(Routes.LEVER_WISE);

                  }),
                  listData(
                      "Amount utilized by each location for livelihood activities ",
                          () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GplAmountUtilizedView(


                            ),
                          ),
                        );

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
        Space.height(MySize.screenHeight*(20/MySize.screenHeight)),
        Divider(
          height: 1,
          color: dividerColor.withOpacity(0.3),
        ),
        Space.height(MySize.screenHeight*(20/MySize.screenHeight)),
      ],
    );
  }
}
