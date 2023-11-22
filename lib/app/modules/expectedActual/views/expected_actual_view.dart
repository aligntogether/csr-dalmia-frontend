import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/expected_actual_controller.dart';

class ExpectedActualView extends GetView<ExpectedActualController> {
  const ExpectedActualView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              appBar(context, title: "Reports"),
              Space.height(16),

              ///_________________________________ main menu __________________________///
              Row(
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: MySize.size40,
                      width: MySize.size150,
                      decoration: BoxDecoration(
                          color: blueColor, borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.menu,
                            height: 15,
                            width: 19,
                          ),
                          Space.width(2),
                          Text(
                            "View other Reports",
                            style: AppStyle.textStyleInterMed(
                                fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Space.width(16),
                ],
              ),
              Space.height(34),

              Text(
                "Expected and actual additional incomes",
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),
              Space.height(14),

            ],
          )),
    );
  }
}
