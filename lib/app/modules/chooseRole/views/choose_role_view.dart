import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/choose_role_controller.dart';

class ChooseRoleView extends GetView<ChooseRoleController> {
  const ChooseRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Space.height(65.5),
          Center(
            child: Container(
                height: MySize.size70,
                width: MySize.size70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff008CD3)),
                child: Center(
                    child: Image.asset(
                  ImageConstant.profile,
                  height: 38,
                  width: 38,
                  fit: BoxFit.cover,
                ))),
          ),
          Space.height(10),
          Text(
            "Choose a role to continue",
            style: AppStyle.textStyleInterMed(fontSize: 16),
          ),
          Space.height(46),
          Container(
            height: MySize.size50,
            width: MySize.size250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffF15A22),
                ),
                color: Color(0xffF15A22).withOpacity(0.2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space.width(15),
                Image.asset(
                  ImageConstant.radio,
                  height: 17,
                  width: 17,
                ),
                Space.width(20),
                Text(
                  "Gram Parivartan Lead",
                  style: AppStyle.textStyleBoldMed(
                      fontSize: 14, color: Color(0xffF15A22)),
                ),
                Spacer()
              ],
            ),
          ),
          Space.height(24),
          Container(
            height: MySize.size50,
            width: MySize.size250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffF15A22),
                ),
                color: Color(0xffF15A22).withOpacity(0.2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space.width(15),
                Image.asset(
                  ImageConstant.radio,
                  height: 17,
                  width: 17,
                ),
                Space.width(20),
                Text(
                  "Location Lead",
                  style: AppStyle.textStyleBoldMed(
                      fontSize: 14, color: Color(0xffF15A22)),
                ),
                Spacer()
              ],
            ),
          ),
          Space.height(80),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: MySize.size50,
              margin: EdgeInsets.symmetric(horizontal: 33),
              decoration: BoxDecoration(
                  color: Color(0xff0054A6),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "Continue",
                  style: AppStyle.textStyleBoldMed(
                      fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          Space.height(34),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Logout",
              style: TextStyle(
                color: Color(0xff0054A6),
                fontSize: 16,
                fontFamily: 'Inter-Bold',
                fontWeight: FontWeight.w500,
                decorationThickness: 1.5,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xff0054A6),
              ),
            ),
          )
        ],
      )),
    );
  }
}
