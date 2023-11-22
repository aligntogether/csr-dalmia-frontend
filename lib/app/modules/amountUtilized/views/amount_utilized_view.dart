import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/amount_utilized_controller.dart';

class AmountUtilizedView extends GetView<AmountUtilizedController> {
  const AmountUtilizedView({Key? key}) : super(key: key);

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

          SizedBox(
              width: MySize.size268,
              child: Column(
                children: [
                  Text(
                    "Amount Utilized by each location for Livelihood activities",
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyleBoldMed(fontSize: 14),
                  ),
                  Text(
                    "(in Lakhs)",
                    style: AppStyle.textStyleInterMed(fontSize: 14),
                  ),
                ],
              )),
          tableDataAll(),
          Space.height(14),

          GestureDetector(onTap: () {

          },
            child: Container(height: MySize.size48,width: MySize.size168,
              decoration: BoxDecoration(border: Border.all(color: darkBlueColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('images/Excel.svg',height: 25,width: 25,),
                  Space.width(3),
                  const Text(
                    'Download  Excel',
                    style: TextStyle(fontSize: 14,
                        color: CustomColorTheme.primaryColor),
                  ),
                ],
              ),),
          ),
          Space.height(20),
        ],
      )),
    );
  }

  Widget tableDataAll() {
    return Expanded(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              child: Container(

                decoration: BoxDecoration(  borderRadius: BorderRadius.circular(20), // Set border radius
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Set shadow color
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///________________________________________________ TITLES __________________________
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        height: 63,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                        child: Row(
                          children: [
                            commonHeadingText("Details"),
                            Space.width(26),
                            commonHeadingText("DPM"),
                            Space.width(22),
                            commonHeadingText("ALR"),
                            Space.width(22),
                            commonHeadingText("BGM"),
                            Space.width(22),
                            commonHeadingText("KDP"),
                            Space.width(22),
                            commonHeadingText("CHA"),
                            commonContainer("SOUTH", Color(0xff096C9F)),
                            Space.width(22),
                            commonHeadingText("MEG"),
                            Space.width(22),
                            commonHeadingText("UGM"),
                            Space.width(22),
                            commonHeadingText("JGR"),
                            Space.width(22),
                            commonHeadingText("LAN"),
                            commonContainer("  NE  ", Color(0xff096C9F)),
                            Space.width(22),
                            commonHeadingText("CUT"),
                            Space.width(22),
                            commonHeadingText("MED"),
                            Space.width(22),
                            commonHeadingText("BOK"),
                            Space.width(22),
                            commonHeadingText("RAJ"),
                            Space.width(22),
                            commonHeadingText("KAL"),
                            commonContainer("  East  ", Color(0xff096C9F)),
                            commonContainer("cement", Color(0xff2E8CBB)),
                            Space.width(22),
                            commonHeadingText("NIG"),
                            Space.width(22),
                            commonHeadingText("RAM"),
                            Space.width(22),
                            commonHeadingText("JOW"),
                            Space.width(22),
                            commonHeadingText("NIN"),
                            Space.width(22),
                            commonHeadingText("KOL"),
                            commonContainer("SUGAR", Color(0xff2E8CBB)),
                            commonContainer("PAN IND", Color(0xff096C9F)),
                          ],
                        ),
                      ),

                      ///________________________________________________ HOUSEHOLDERS LISTS __________________________
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        height: 40,
                        child: Row(
                          children: [
                            commonHeadingText("Budget Allocated", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(25),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer("", Color(0xff096C9F)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            commonContainer("6500", Color(0xff096C9F)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(23),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer("6500", Color(0xff096C9F)),
                            commonContainer("6500", Color(0xff2E8CBB)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(22),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer(" ", Color(0xff2E8CBB)),
                            commonContainer(" ", Color(0xff096C9F)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        height: 40,
                        color: Color(0xff008CD3).withOpacity(0.1),
                        child: Row(
                          children: [
                            commonHeadingText("Amount Utilized", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(25),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer("", Color(0xff096C9F)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            commonContainer("6500", Color(0xff096C9F)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(23),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer("6500", Color(0xff096C9F)),
                            commonContainer("6500", Color(0xff2E8CBB)),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(21),
                            commonHeadingText("6500", color: Colors.black),
                            Container(
                              height: 40,
                              width: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Space.width(22),
                            commonHeadingText("6500", color: Colors.black),
                            commonContainer(" ", Color(0xff2E8CBB)),
                            commonContainer(" ", Color(0xff096C9F)),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
