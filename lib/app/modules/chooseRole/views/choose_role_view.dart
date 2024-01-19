import 'dart:io';

import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/Accounts/accounthome.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/pages/CEO/ceohome.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/RH/rhhome.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/choose_role_controller.dart';

class ChooseRoleView extends GetView<ChooseRoleController> {
  const ChooseRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup(context) async{
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Do you want to exit?"),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('yes selected');
                              exit(0);
                            },
                            child: Text("Yes", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0054A6)),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                print('no selected');
                                Navigator.of(context).pop();
                              },
                              child: Text("No", style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }
    void checkUserType() async {
      var userType;
      try {
        userType = await SharedPrefHelper.getSharedPref(
            USER_TYPES_SHAREDPREF_KEY, context, false);
      } catch (e) {
        return;
      }

      if (!userType.contains(',')) {
        switch (userType) {
          case VDF_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => VdfHome()));
            break;
          case CDO_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CDOHome()));
            break;
          case GPL_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GPLHomeScreen()));
            break;
          case LL_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LLHome()));
            break;
          case RH_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RHHome()));
            break;
          case CEO_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CEOHome()));
            break;
          case ACCOUNTS_USERTYPE:
            await SharedPrefHelper.storeSharedPref(
                USER_TYPE_SHAREDPREF_KEY, userType);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountsHome()));
            break;
          default:
            // For any other userType we have to show a prompt "You  can not use the Application" and redirect on Login page
            await SharedPrefHelper.clearSharedPrefAccess();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
        }
      }
      print(userType);
      print(userType.split(","));

      controller.roleList = userType.split(",");
      controller.update();
    }

    checkUserType();

    return WillPopScope(child:  SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                GetBuilder<ChooseRoleController>(
                  builder: (controller) {
                    return SizedBox(
                      height: 230,
                      child: SingleChildScrollView(
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: 55, vertical: 15),
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
                                          border: Border.all(
                                              color: Color(0xff2D2D2D))),
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
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    var userType;
                    try {
                      userType = controller.roleList[controller.roleIndex];
                    } catch (e) {
                      return;
                    }
                    switch (userType) {
                      case VDF_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => VdfHome()));
                        break;
                      case CDO_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CDOHome()));
                        break;
                      case GPL_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GPLHomeScreen()));
                        break;
                      case LL_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LLHome()));
                        break;
                      case RH_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RHHome()));
                        break;
                      case CEO_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CEOHome()));
                        break;
                      case ACCOUNTS_USERTYPE:
                        await SharedPrefHelper.storeSharedPref(
                            USER_TYPE_SHAREDPREF_KEY, userType);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountsHome()));
                        break;
                      default:
                      // For any other userType we have to show a prompt "You  can not use the Application" and redirect on Login page
                        await SharedPrefHelper.clearSharedPrefAccess();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
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
                  onTap: () async {
                    await SharedPrefHelper.clearSharedPrefAccess();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
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
            ),
          )),
    ), onWillPop: ()=>showExitPopup(context));

  }
}
