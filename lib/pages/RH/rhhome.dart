import 'dart:convert';

import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/app/modules/sourceFunds/views/source_region_location_view.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/RH/RhHomeController.dart';
import 'package:dalmia/pages/RH/rh_lever_wise_report/rh_lever_wise_report_view.dart';
import 'package:dalmia/pages/RH/rh_report/rh_report.dart';

import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../app/modules/amountUtilized/views/amount_utilized_view.dart';
import '../../common/app_style.dart';
import '../../common/size_constant.dart';
class RHHome extends StatefulWidget {
  const RHHome({Key? key}) : super(key: key);

  @override
  _RHHomeState createState() => _RHHomeState();
}

class _RHHomeState extends State<RHHome> {
  int length = 0;
  String? refId;
  String name = "";

  @override
  void initState() {
    super.initState();
    // fetchDataAndProcess(context);
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? name = 'user' : name = value;
            }));
    SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              refId = value;
            }));
    fetchData(context);
  }



  Future<List<Map<String, dynamic>>> fetchData(BuildContext context) async {
    String userIdSharedPref = await SharedPrefHelper.getSharedPref(
        USER_ID_SHAREDPREF_KEY, context, true);

    print("userIdSharedPref: " + userIdSharedPref);

    final response = await http.get(
      Uri.parse(
          'https://mobileqacloud.dalmiabharat.com:443/csr/list-feedback?userId=${userIdSharedPref}'),
      // SharedPrefHelper.storeSharedPref(
      // USER_ID_SHAREDPREF_KEY, authResponse.referenceId)
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> respBody = responseData['resp_body'];
      print('response body $respBody');
      // Convert the response body into a List of maps
      setState(() {
        length = respBody.length;
        print('length = $length');
      });
      return respBody.entries.map((entry) {
        return {
          'name': entry.key,
          'feedback_id': entry.value['feedback_id'],
          'created_at': entry.value['created_at'],
          'sender_id': entry.value['sender_id'],
          'recipient_id': entry.value['recipient_id'],
        };
      }).toList();
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
      return [];
    }
  }
  RhHomeController controller=Get.put(RhHomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller,context, name),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MySize.screenHeight*(20/MySize.screenHeight)),
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
                        builder: (context) => RhReportView(
                            refId: refId
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'View Reports',
                    imageUrl: 'images/vdfreports.svg',
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PERFORMANCE_VDF);
                  },
                  child: cards(
                    title: 'Performance of VDFs',
                    imageUrl: 'images/weeklyreports.svg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EXPECTED_ACTUAL);
                  },
                  child: cards(
                    title: 'Expected and Actual Income Report',
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
                        builder: (context) => RhLeverWiseView(refId: refId),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Lever wise details of HH & int.',
                    imageUrl: 'images/leverwise.svg',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SourceRegionsView());
                  },
                  child: cards(
                    title: 'Source of Funds',
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
                        builder: (context) => AmountUtilizedView(
                          refId: refId,
                        ),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Amount utilized by Location',
                    imageUrl: 'images/sendmoney.svg',


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
                              length.toString(),
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
      height: MySize.screenHeight*(60/MySize.screenHeight),
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
