import 'package:dalmia/app/modules/addLocation/controllers/add_location_controller.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/gpl/gpl_controller.dart';
import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';
class GPLHomeScreen extends StatefulWidget {
  const GPLHomeScreen({super.key});

  @override
  State<GPLHomeScreen> createState() => _GPLHomeScreenState();
}

class _GPLHomeScreenState extends State<GPLHomeScreen> {
  String name=' ';
  GplController controller = Get.put(GplController());
  List locationList = [
    {"text": "Add Location", "img": "images/Location.png"},
    {"text": "Add Panchayat", "img": "images/Panchayat.png"},
    {"text": "Add Village", "img": "images/Village.png"},
    {"text": "Add Cluster", "img": "images/Vector.png"},
    {"text": "Replace VDF", "img": "images/male-icon.png"},
  ];
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      value == '' ? name = 'user' : name = value;
    }));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller, context,name),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Space.height(30), dataList()],
          ),
        ),
      ),
    );
  }

  Widget dataList() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MySize.safeHeight! * (16/MySize.screenHeight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "View Data",
            style: AppStyle.textStyleInterMed(
                fontSize: MySize.safeHeight! * (16/MySize.screenHeight), fontWeight: FontWeight.w600),
          ),
          Space.height(MySize.screenHeight * 0.01),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REPORTS);
                  },
                  child: Container(
                      height: MySize.screenHeight*(100/MySize.screenHeight),
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
                                  fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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

          Space.height(MySize.screenHeight * 0.02),
          Text(
            "Add Intervention Details",
            style: AppStyle.textStyleInterMed(
                fontSize: MySize.safeHeight! * (16/MySize.screenHeight), fontWeight: FontWeight.w600),
          ),
          Space.height(MySize.screenHeight * 0.01),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.ADD_INTERVAL);
            },
            child: Container(
              height: MySize.safeHeight! * 0.15,
              width: MySize.safeWidth! ,

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
                  borderRadius: BorderRadius.circular(MySize.safeWidth! * 0.03),
                ),
                child: Container(
                  padding:  EdgeInsets.only(
                    left: MySize.safeWidth! * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/bp_t.png",
                        width: MySize.safeWidth! * 0.1,
                        height: MySize.safeHeight! * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          "Add\nInterv.",
                          style: TextStyle(
                            fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
          Space.height(MySize.screenHeight * 0.02),
          Text(
            "Add Location Details",
            style: AppStyle.textStyleInterMed(
                fontSize: MySize.safeHeight! * (16/MySize.screenHeight), fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 20.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemCount: locationList.length,
              // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      AddLocationController col =
                          Get.put(AddLocationController());
                      col.nameController.value.clear();
                      col.selectLocation = null;
                      Get.toNamed(Routes.ADD_LOCATION);
                    } else if (index == 1) {
                      Get.toNamed(Routes.ADD_PANCHAYAT);
                    } else if (index == 2) {
                      Get.toNamed(Routes.ADD_VILLAGE);
                    } else if (index == 3) {
                      Get.toNamed(Routes.ADD_CLUSTER);
                    } else {
                      Get.toNamed(Routes.REPLACE_VDF);
                    }
                  },
                  child: Container(
                    height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                              locationList[index]["img"],
                              width: index == 4 ? 26 : 35,
                              height: index == 4 ? 25.3 : 35,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                locationList[index]["text"],
                                style: TextStyle(
                                  fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
                );
              },
            ),
          ),
          /*Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_LOCATION);
                  },
                  child: Container(
                    height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                                  fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_PANCHAYAT);
                  },
                  child: Container(
                    height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                                "Add Panchayat",
                                style: TextStyle(
                                  fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_VILLAGE);
                  },
                  child: Container(
                    height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                                  fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ADD_CLUSTER);
                },
                child: Container(
                  height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                                fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REPLACE_VDF);
                },
                child: Container(
                  height: MySize.safeHeight! * (100/MySize.screenHeight),
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
                                fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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
          ),*/
          Space.height(MySize.screenHeight * 0.02),

          ///__________________________ feed back _________________________
          Text(
            "Feedback",
            style: AppStyle.textStyleInterMed(
                fontSize: MySize.safeHeight! * (16/MySize.screenHeight), fontWeight: FontWeight.w600),
          ),
          Space.height(10),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.FEEDBACK);
            },
            child: Container(
              height:  MySize.safeHeight! * (110/MySize.screenHeight),
              width: MySize.safeWidth!,
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
                            fontSize: MySize.safeHeight! * (14/MySize.screenHeight),
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

void showConfirmationDialog(BuildContext context) {
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
                    style: AppStyle.textStyleInterMed(fontSize: MySize.safeHeight! * (16/MySize.screenHeight))),
              ),
              Space.height(30),
              GestureDetector(
                onTap: () async {
                  await SharedPrefHelper.clearSharedPrefAccess();
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                          fontSize: MySize.safeHeight! * (14/MySize.screenHeight), color: Colors.white),
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
