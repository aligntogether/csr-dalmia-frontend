import 'package:flutter/material.dart';

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

Widget commonHeadingText(String title, {Color? color,double? h}) {
  return SizedBox(
    width: h??80,
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