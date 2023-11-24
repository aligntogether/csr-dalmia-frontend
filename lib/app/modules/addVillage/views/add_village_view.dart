import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_village_controller.dart';

class AddVillageView extends GetView<AddVillageController> {
  const AddVillageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Village',
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
        ),
        body: Column(
          children: [
            Space.height(10),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select a Region",
                    options: [
                      "South & Chandrapur",
                      "Sugar",
                      "East",
                      "North East",
                      "All Regions"
                    ],
                    selectedValue: controller.selectLocation,
                    onChanged: (String? newValue) async {
                      controller.selectLocation = newValue;
                      controller.update(["add"]);
                    });
              },
            ),
            Space.height(15),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select Location",
                    options: [
                      "South & Chandrapur",
                      "Sugar",
                      "East",
                      "North East",
                    ],
                    selectedValue: controller.selectRegion,
                    onChanged: (String? newValue) async {
                      controller.selectRegion = newValue;
                      controller.update(["add"]);
                    });
              },
            ),
            Space.height(15),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select Panchayat",
                    options: [
                      "South & Chandrapur",
                      "Sugar",
                      "East",
                      "North East",
                    ],
                    selectedValue: controller.selectP,
                    onChanged: (String? newValue) async {
                      controller.selectP = newValue;
                      controller.update(["add"]);
                    });
              },
            ),
            Space.height(30),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null &&
                        controller.selectP != null) {
                      Get.to(AddVillageNew(
                        location: controller.selectLocation,
                        region: controller.selectRegion,
                        p: controller.selectP,
                      ));
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null &&
                              controller.selectP != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }
}

class AddVillageNew extends StatelessWidget {
  String? location, region, p;

  AddVillageNew({super.key, this.location, this.region, this.p});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Village',
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
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space.height(15),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MySize.size95,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff006838).withOpacity(0.15)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text("Region: ",style: AppStyle.textStyleBoldMed(color: Color(0xff006838)),)
                  RichText(
                    text: TextSpan(
                      text: 'Region: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: region,
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14,
                                color: Color(0xff006838).withOpacity(0.5))),
                      ],
                    ),
                  ),
                  Space.height(8),
                  RichText(
                    text: TextSpan(
                      text: 'Location: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: location,
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14,
                                color: Color(0xff006838).withOpacity(0.5))),
                      ],
                    ),
                  ),
                  Space.height(8),
                  RichText(
                    text: TextSpan(
                      text: 'Panchayat: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: p,
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14,
                                color: Color(0xff006838).withOpacity(0.5))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Space.height(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Text(
              "Check whether the village is already added?",
              style: AppStyle.textStyleBoldMed(fontSize: 14),
            ),
          ),
          Space.height(11),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 21.5, vertical: 10),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff008CD3).withOpacity(0.15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1.  Mullicheval",
                  style: AppStyle.textStyleInterMed(
                      fontSize: 14, color: Color(0xff181818).withOpacity(0.7)),
                ),
                Text(
                  "2.  Upathur",
                  style: AppStyle.textStyleInterMed(
                      fontSize: 14, color: Color(0xff181818).withOpacity(0.7)),
                ),
                Text(
                  "3.  Chinnaodaipatti",
                  style: AppStyle.textStyleInterMed(
                      fontSize: 14, color: Color(0xff181818).withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Space.height(12),
          GestureDetector(onTap: () {
             Get.to(AddPName(p: p,location: location,region: region,));
          },
            child: commonButton(
                title: "Add New",
                color: Color(0xff27528F)),
          )
        ],
      ),
    ));
  }
}


class AddPName extends StatelessWidget {
  String? location, region, p;
   AddPName({super.key,this.p,this.region,this.location});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Add Village',
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
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.height(15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MySize.size95,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff006838).withOpacity(0.15)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("Region: ",style: AppStyle.textStyleBoldMed(color: Color(0xff006838)),)
                      RichText(
                        text: TextSpan(
                          text: 'Region: ',
                          style: AppStyle.textStyleBoldMed(
                              fontSize: 14, color: Color(0xff006838)),
                          children: <TextSpan>[
                            TextSpan(
                                text: region,
                                style: AppStyle.textStyleInterMed(
                                    fontSize: 14,
                                    color: Color(0xff006838).withOpacity(0.5))),
                          ],
                        ),
                      ),
                      Space.height(8),
                      RichText(
                        text: TextSpan(
                          text: 'Location: ',
                          style: AppStyle.textStyleBoldMed(
                              fontSize: 14, color: Color(0xff006838)),
                          children: <TextSpan>[
                            TextSpan(
                                text: location,
                                style: AppStyle.textStyleInterMed(
                                    fontSize: 14,
                                    color: Color(0xff006838).withOpacity(0.5))),
                          ],
                        ),
                      ),
                      Space.height(8),
                      RichText(
                        text: TextSpan(
                          text: 'Panchayat: ',
                          style: AppStyle.textStyleBoldMed(
                              fontSize: 14, color: Color(0xff006838)),
                          children: <TextSpan>[
                            TextSpan(
                                text: p,
                                style: AppStyle.textStyleInterMed(
                                    fontSize: 14,
                                    color: Color(0xff006838).withOpacity(0.5))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Space.height(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    labelText: "Enter Panchayat Name",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              ),
              Space.height(30),
              GestureDetector(onTap: () {
                showConfirmationDialog(context);
              },
                child: commonButton(
                    title: "Add Village",
                    color: Color(0xff27528F)),
              )
            ],
          ),
        ));
  }
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 91),
          child: AlertDialog(
            backgroundColor: Colors.white,
            alignment: Alignment.topCenter,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 338,
              child: Column(
                children: [
                  Space.height(16),

                  Image.asset(ImageConstant.check_circle,height: 50,width: 50,),
                  Space.height(18),
                  SizedBox(
                    width: MySize.size296,
                    child: Text(
                        '“<Village name>” is added successfully. What do you wish to do next? Add another Panchayat Save and Close',
                        style: AppStyle.textStyleInterMed(fontSize: 16)),
                  ),
                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                      /*   Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GPLHomeScreen(),
                        ),
                      );*/
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff27528F)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Add another Panchayat",
                          style: AppStyle.textStyleInterMed(
                              fontSize: 14, color: Color(0xff27528F)),
                        ),
                      ),
                    ),
                  ),
                  Space.height(16),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(GPLHomeScreen());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff27528F)),
                      child: Center(
                        child: Text(
                          "Save and Close",
                          style: AppStyle.textStyleInterMed(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
