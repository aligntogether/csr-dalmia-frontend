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
          Space.height(31),
         GetBuilder<ChooseRoleController>(builder: (controller) {
           return  SizedBox(height: 230,
             child: ListView.builder(
               itemCount: controller.roleList.length,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (context, index) {
                 return GestureDetector(
                   onTap: () {
                     controller.roleIndex = index;
                     controller.update();
                   },
                   child: Container(
                     height: MySize.size50,
                     width: MySize.size250,
                     margin: EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(
                           color: controller.roleIndex == index
                               ? Color(0xffF15A22)
                               : Color(0xff181818).withOpacity(0.6),
                         ),
                         color: controller.roleIndex == index
                             ? Color(0xffF15A22).withOpacity(0.2)
                             : Colors.white),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Space.width(15),
                         controller.roleIndex == index
                             ? Image.asset(
                           ImageConstant.radio,
                           height: 17,
                           width: 17,
                         )
                             : Container(
                           height: 17,
                           width: 17,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border:
                               Border.all(color: Color(0xff2D2D2D))),
                         ),
                         Space.width(20),
                         Text(
                           controller.roleList[index],
                           style: AppStyle.textStyleBoldMed(
                               fontSize: 14,
                               color: controller.roleIndex == index
                                   ? Color(0xffF15A22)
                                   : Color(0xff181818).withOpacity(0.6)),
                         ),
                         Spacer()
                       ],
                     ),
                   ),
                 );
               },
             ),
           );
         },),
          /*  Container(
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
          ),*/

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
