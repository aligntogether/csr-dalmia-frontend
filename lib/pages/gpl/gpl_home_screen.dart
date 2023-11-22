import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class GPLHomeScreen extends StatefulWidget {
  const GPLHomeScreen({super.key});

  @override
  State<GPLHomeScreen> createState() => _GPLHomeScreenState();
}

class _GPLHomeScreenState extends State<GPLHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [appBar(), Space.height(30), dataList()],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 22),
      height: MySize.size83,
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
          Text(
            "Welcome Balamurugan !",
            style: TextStyle(
                fontFamily: "Inter-Medium",
                fontSize: 12,
                color: Color(0xff181818)),
          )
        ],
      ),
    );
  }

  Widget dataList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "View Data",
            style: AppStyle.textStyleInterMed(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.REPORTS);
                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFF2D4C9),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/reports.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Reports",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB94217),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space.width(21),
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.GENERAL_INFO);

                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFF2D4C9),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/General Info.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "General Info",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB94217),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space.width(21),
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.MONITOR_PROGRESS);

                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFF2D4C9),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/monitor_p.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Monitor Progress",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB94217),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///__________________________________Add intervational Details ___________________

          Space.height(40),
          Text(
            "Add Intervention Details",
            style: AppStyle.textStyleInterMed(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          GestureDetector(onTap: () {
            Get.toNamed(Routes.ADD_INTERVAL);

          },
            child: Container(
              height: 110,
              width: 95,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Card(
                color: Color(0xFFC2D7CD),
                // elevation: 4.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.10000000149011612),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/bp_t.png",
                        width: 38,
                        height: 38,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          "Add\nInterv.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0D7344),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///__________________________________Add Location Details ___________________
          Space.height(40),
          Text(
            "Add Location Details",
            style: AppStyle.textStyleInterMed(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.ADD_LOCATION);

                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFC2D3E3),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/Location.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Add Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff064F96),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space.width(21),
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.ADD_PANCHAYAT);

                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFC2D3E3),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/Panchayat.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Add Panchayat",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff064F96),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Space.width(21),
              Expanded(
                child: GestureDetector(onTap: () {
                  Get.toNamed(Routes.ADD_VILLAGE);

                },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xFFC2D3E3),
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "images/Village.png",
                              width: 38,
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Add Village",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff064F96),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Space.height(15),

          Row(
            children: [
              GestureDetector(onTap: () {
                Get.toNamed(Routes.ADD_CLUSTER);

              },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Card(
                    color: Color(0xFFC2D3E3),
                    // elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "images/Vector.png",
                            width: 38,
                            height: 38,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Add\nCluster",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff064F96),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Space.width(21),
              GestureDetector(onTap: () {
                Get.toNamed(Routes.REPLACE_VDF);

              },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Card(
                    color: Color(0xFFC2D3E3),
                    // elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.10000000149011612),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "images/male-icon.png",
                            width: 38,
                            height: 38,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Replace VDF",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff064F96),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Space.height(40),

          ///__________________________ feed back _________________________
          Text(
            "Feedback",
            style: AppStyle.textStyleInterMed(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          GestureDetector(onTap: () {
            Get.toNamed(Routes.FEEDBACK);
          },
            child: Container(
              height: 110,
              width: 95,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Card(
                color: Color(0xFFF1CBCB),
                // elevation: 4.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.10000000149011612),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/Chat.png",
                        width: 38,
                        height: 38,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          "Feedback",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffED4949),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Space.height(64),
        ],
      ),
    );
  }
}

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
