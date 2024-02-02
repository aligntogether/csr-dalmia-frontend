import 'dart:convert';

import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/CDO/action.dart';
import 'package:dalmia/pages/CDO/expected.dart';
import 'package:dalmia/pages/CDO/sourceoffunds.dart';
import 'package:dalmia/pages/CDO/vdf_report_controller.dart';
import 'package:dalmia/pages/CDO/vdffund.dart';
import 'package:dalmia/pages/CDO/vdfreports.dart';
import 'package:dalmia/pages/CDO/WeeklyPerformance/weeklyprogress.dart';
import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../common/app_style.dart';
import '../../common/size_constant.dart';
import 'CdoController.dart';
int LLid = 0;

class CDOHome extends StatefulWidget {
  const CDOHome({Key? key}) : super(key: key);

  @override
  _CDOHomeState createState() => _CDOHomeState();
}


  
class _CDOHomeState extends State<CDOHome> {
  String name = "";
  String cdoId = "";
  VDFReportController controller1 = VDFReportController();
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
      value == '' ? cdoId = '10001' : cdoId = value;

        var url = Uri.parse(
            'https://mobileqacloud.dalmiabharat.com:443/csr/locations/search/findLocationIdByCdoId?cdoId=$cdoId');
        http.get(url).then((response) {
          var data = json.decode(response.body);

          controller1.selectLocationId = data;
          return controller1.selectLocationId;
        });



    }));
    ;
  }


  CdoController controller = Get.put(CdoController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:appBarCommon(controller, context,name),
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
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfReport(),
                    ),
                  );
                },
                child: cards(
                  title: 'VDF Reports',
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
                      builder: (context) =>  WeeklyProgress(
                        locationId: controller1.selectLocationId,
                      ),
                    ),
                  );
                },
                child: cards(
                  title: 'Weekly progress report',
                  imageUrl: 'images/weeklyreports.svg',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Expectedincome(),
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
                      builder: (context) => const SourceOfFunds(),
                    ),
                  );
                },
                child: cards(
                  title: 'Source of funds',
                  imageUrl: 'images/sourceoffunds.svg',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VDFFunds(),
                    ),
                  );
                },
                child: cards(
                  title: 'Funds utilized by VDFs',
                  imageUrl: 'images/fundsutilized.svg',
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
                height: MySize.screenHeight*(20/MySize.screenHeight),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ActionAgainstHH(),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: MySize.screenHeight*(75/MySize.screenHeight),
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
                              width: MySize.screenWidth*(34/MySize.screenWidth),
                              height: MySize.screenHeight*(31/MySize.screenHeight),
                            ),
                            SizedBox(
                              width: MySize.screenWidth*(20/MySize.screenWidth),
                            ),
                            Flexible(
                              child: Text(
                                'Drop or Select HH for Int.',
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
                            '5',
                            style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: CustomFontTheme.headingwt,
                                color: Colors.white),
                          )),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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
          width: MySize.screenWidth*(34/MySize.screenWidth),
          height: MySize.screenHeight*(31/MySize.screenHeight),
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
