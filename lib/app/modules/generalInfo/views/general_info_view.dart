import 'package:dalmia/app/modules/generalInfo/views/cluster_formation_view.dart';
import 'package:dalmia/app/modules/generalInfo/views/location_wise_household_view.dart';
import 'package:dalmia/app/modules/locationWise/views/location_wise_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/general_info_controller.dart';

class GeneralInfoView extends GetView<GeneralInfoController> {
  const GeneralInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'General Information',
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
            listData("Location wise Household and Population details", () {
              Get.to(LocationWiseViewHouseHold());
            }),
            listData("Cluster formation details of PAN India locations", () {
              Get.to(ClusterFormationView());
            }),
          ],
        ),
      ),
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
