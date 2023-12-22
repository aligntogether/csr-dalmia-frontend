import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*Widget appBar(BuildContext context,{String? title}) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 22),
    height: MySize.size90,
    width: MySize.screenWidth,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
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
                _showConfirmationDialog(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Logout.png',
                    height: 28,
                    width: 28,
                  ),
                  Space.height(6),
                  Text(
                    'Logout',
                    style: TextStyle(
                        fontFamily: "Inter-Medium",
                        color: Color(0xff181818),
                        fontSize: 12,
                        fontWeight: CustomFontTheme.labelwt),
                  )
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            title!,
            style: AppStyle.textStyleInterMed(fontSize: 16,color: Color(0xff181818),fontWeight: FontWeight.w700)
             *//* TextStyle(
                fontFamily: "Inter-Medium",
                fontSize: 16,
                color: Color(0xff181818)),*//*
          ),
        )
      ],
    ),
  );
}*/
void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: SizedBox(
          height: 165,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              SizedBox(
                child: Text(
                    'Are you sure you want to\nlogout of the application?',
                    style: AppStyle.textStyleInterMed(fontSize: 16)),
              ),
              Space.height(30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 157,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff27528F)),
                  child: Center(
                    child: Text(
                      "Yes",
                      style: AppStyle.textStyleInterMed(
                          fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}


AppBar commonAppBarWidget({String? title}){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      title??'Send New Feedback',
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
  );
}