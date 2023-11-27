import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'size_constant.dart';

class AppStyle {
  static TextStyle textStyleInterMed(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      color: color ?? Color(0xff181818),
      fontSize: fontSize ?? 12,
      fontFamily: 'Inter-Medium',
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }

  static TextStyle textStyleBoldMed(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      color: color ?? Color(0xff181818),
      fontSize: fontSize ?? 12,
      fontFamily: 'Inter-Bold',
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }
}

Widget commonTitle(String title) {
  return Text(
    title,
    style: AppStyle.textStyleBoldMed(fontSize: 14),
  );
}

Widget commonContainer(String value, Color color, {double? h}) {
  return Container(
    height: h ?? 63,
    width: 80,
    padding: EdgeInsets.symmetric(horizontal: 5),
    color: color,
    child: Center(
      child: Text(
        value,
        style: AppStyle.textStyleInterMed(fontSize: 14, color: Colors.white),
      ),
    ),
  );
}

Widget commonHeadingText(String title, {Color? color, double? h}) {
  return SizedBox(
    width: h ?? 80,
    child: Text(
      title,
      style: AppStyle.textStyleInterMed(
          fontSize: 14, color: color ?? Colors.white),
    ),
  );
}

Widget commonTitleText(String title) {
  return Text(
    title,
    style: AppStyle.textStyleBoldMed(fontSize: 14),
  );
}

PreferredSize appBarCommon(controller, BuildContext context,
    {bool? centerAlignText, String? title}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(180),
      child: Obx(() => controller.openMenu.value == true
          ? Container(
              padding: EdgeInsets.only(left: 16, right: 22),
              height: 142,
              width: MySize.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Space.height(13),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          controller.onTapOpenMenu();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 30,
                        ),
                      )),
                  Space.height(5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CHOOSE_ROLE);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.switch_accounts,
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                        Space.width(10),
                        Text(
                          "Switch Role",
                          style: AppStyle.textStyleInterMed(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Space.height(10),
                  Divider(
                    height: 1,
                    color: Color(0xff181818).withOpacity(0.2),
                  ),
                  Space.height(10),
                  GestureDetector(
                    onTap: () {
                      showConfirmationDialog(context);
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const Login(),
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'images/logout.svg',
                        ),
                        Space.width(
                          10,
                        ),
                        Text(
                          'Logout',
                          style: AppStyle.textStyleInterMed(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 16, right: 22),
              height: MySize.size95,
              width: MySize.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.height(8),
                  Row(
                    children: [
                      Image.asset(
                        "images/icon.jpg",
                        height: MySize.size38,
                        width: MySize.size69,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          controller.onTapOpenMenu();
                          //  _showConfirmationDialog(context);
                        },
                        child: Image.asset(
                          'images/hMenue.png',
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ],
                  ),
                  Space.height(14),
                  centerAlignText == true
                      ? Center(
                          child: Text(
                            title ?? "Welcome Balamurugan !",
                            style: AppStyle.textStyleBoldMed( fontSize: CustomFontTheme.textSize,fontWeight: CustomFontTheme.headingwt),
                          ),
                        )
                      : Text(
                          title ?? "Welcome Balamurugan !",
                          style: TextStyle(
                              fontFamily: "Inter-Medium",
                              fontSize: 12,
                              color: Color(0xff181818)),
                        )
                ],
              ),
            )));
}

Widget commonButton({String? title,Color? color, Color? textColor,double? margin}){
  return    Container(
    height: MySize.size50,
    margin: EdgeInsets.symmetric(horizontal: margin??33),
    decoration: BoxDecoration(
        color: color??Color(0xff27528F),
        borderRadius: BorderRadius.circular(5)),
    child: Center(
      child: Text(
        title??"Continue",
        style: AppStyle.textStyleBoldMed(
            fontSize: 14, color:textColor?? Colors.white),
      ),
    ),
  );
}
