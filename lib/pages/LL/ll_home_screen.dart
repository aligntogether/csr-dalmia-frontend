import 'dart:convert';

import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/CDO/vdfreports.dart';
import 'package:dalmia/pages/LL/action.dart';
import 'package:dalmia/pages/LL/expectedActualReport/expected_actual_additional_income.dart';

import 'package:dalmia/pages/LL/sourceoffunds.dart';
import 'package:dalmia/pages/LL/vdffund.dart';
import 'package:dalmia/pages/LL/vdfreports.dart';
//import as http
import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/app_style.dart';
import '../../common/size_constant.dart';
import '../CDO/expected.dart';
import '../CDO/sourceoffunds.dart';
import '../CDO/vdffund.dart';
import 'll_controller.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);
class LLHome extends StatefulWidget {
  const LLHome({Key? key}) : super(key: key);

  @override
  _LLHomeState createState() => _LLHomeState();
}

class _LLHomeState extends State<LLHome> {
  String name = "";
  String? refId;
  String? locationId;
  String count='0';
  String? accessId;
  LLController controller = Get.put(LLController());
  @override
  void initState() {
    super.initState();

    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? name = 'user' : name = value;
            }));
    ;
    SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? refId = 'user' : refId = value;
              SharedPrefHelper.getSharedPref(ACCESS_TOKEN_SHAREDPREF_KEY, context, false).then((value){
                accessId=value;
                fetch(value, refId!);
              });


    }));
    ;
  }
  void fetch(String accessId, String refId1) async{
    try {
      var url = Uri.parse(
          'https://mobileqacloud.dalmiabharat.com:443/csr/locations/search/findLocationIdByLocationLead?locationLead=$refId1');
      http.get(url, headers: {'X-Access-Token': accessId}).then((response) {
        var data = json.decode(response.body);
        print("ds$data");

        locationId= data;

        var url=Uri.parse('https://mobileqacloud.dalmiabharat.com:443/csr/action-dropped-household-details-ll?locationId=$locationId');
        http.get(url,headers: {'X-Access-Token': accessId}).then((response) {
          var data = json.decode(response.body);
          print("ds$data");

          setState(() {
            count = data==null?'0':data['totalCount'].toString();
          });

        });
        return locationId;
      });
    } catch (e) {
      locationId = '10001';
      print(e);

    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller, context,name),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.screenWidth*(40/MySize.screenWidth), vertical: MySize.screenHeight*(40/MySize.screenHeight)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View Data',
                  style: TextStyle(
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.headingwt),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  VdfReport(
                          accessId: accessId!,
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'View Report',
                    imageUrl: 'images/vdfreports.svg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VDFFunds(
                          locationId: locationId!,
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Funds Utilized By VDFs',
                    imageUrl: 'images/fundsutilizationll.svg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  Expectedincome(
                          locationId: int.tryParse(locationId!),
                          accessId:accessId! ,
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Expected and actual income reports',
                    imageUrl: 'images/expectedreports.svg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SourceOfFunds(
                          locationId: int.tryParse(locationId!),
                          accessId: accessId!,
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Source of Funds',
                    imageUrl: 'images/sourceoffunds.svg',
                  ),
                ),
                SizedBox(
                  height: MySize.screenHeight*(40/MySize.screenHeight),
                ),
                Text(
                  'Take Action',
                  style: TextStyle(
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.headingwt),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ActionAgainstHHLL(
                          locationId: locationId!,
                          accessId: accessId!,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            // width: 284,
                            // height: 55,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Color(0xFFC2DEEC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.10000000149011612),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            // color: Color(0xFFF2D4C9),
                            child: Row(children: [
                              SvgPicture.asset(
                                'images/takeaction.svg',
                                width: 34,
                                height: 31,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  'Drop HH from intervention',
                                  style: TextStyle(
                                      fontSize: CustomFontTheme.textSize,
                                      color: const Color(0xFF0374AD),
                                      fontWeight: CustomFontTheme.labelwt),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 20,
                          child: Container(
                            width: 23,
                            height: 23,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF15A22),
                              shape: OvalBorder(),
                            ),
                            child: Center(
                                child: Text(
                              count,
                              style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                  color: Colors.white),
                            )),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.FEEDBACK);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            // width: 284,

                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Color(0xFFC2DEEC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black
                                      .withOpacity(0.10000000149011612),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            // color: Color(0xFFF2D4C9),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'images/Feedback.svg',
                                  width: 34,
                                  height: 31,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Text(
                                    'Reply to Feedback',
                                    style: TextStyle(
                                      fontSize: CustomFontTheme.textSize,
                                      color: const Color(0xFF0374AD),
                                      fontWeight: CustomFontTheme.labelwt,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 20,
                        child: Container(
                          width: 23,
                          height: 23,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF15A22),
                            shape: OvalBorder(),
                          ),
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: CustomFontTheme.headingwt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cards extends StatelessWidget {
  final String imageUrl;
  final String title;

  const cards({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 284,
      // height: 55,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Color(0x33F15A22),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.10000000149011612),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      // color: Color(0xFFF2D4C9),
      child: Row(children: [
        SvgPicture.asset(
          imageUrl,
          width: 34,
          height: 31,
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                color: Color(0xFFB94216),
                fontWeight: CustomFontTheme.labelwt),
          ),
        )
      ]),
    );
  }
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: SizedBox(
          width: 283,
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
              const Text(
                'Are you sure you want to logout of the application?',
                style: TextStyle(
                  fontSize: 16,
                  // fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 157,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () async {
                  await SharedPrefHelper.clearSharedPrefAccess();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
