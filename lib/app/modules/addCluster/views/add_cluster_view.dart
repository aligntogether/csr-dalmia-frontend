import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_cluster_controller.dart';

class AddClusterView extends GetView<AddClusterController> {
  const AddClusterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Cluster',
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
            GetBuilder<AddClusterController>(
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
            GetBuilder<AddClusterController>(
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
            GetBuilder<AddClusterController>(
              id: "add",
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: TextFormField(
                    controller: controller.nameController.value,
                    onChanged: (value) {
                      controller.update(["add"]);
                    },
                    decoration: const InputDecoration(
                      labelText: "Total Clusters added",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                  ),
                );
              },
            ),
            Space.height(30),
            GetBuilder<AddClusterController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null &&
                        controller.nameController.value.text.isNotEmpty) {
                      showConfirmationDialog(context,
                          location: controller.selectLocation,
                          p: controller.nameController.value.text,
                          r: controller.selectRegion);
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null &&
                              controller.nameController.value.text.isNotEmpty
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }

  void showConfirmationDialog(BuildContext context,
      {String? location, String? r, String? p}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 91),
          child: AlertDialog(
            backgroundColor: Colors.white,
            alignment: Alignment.topCenter,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 365,
              child: Column(
                children: [
                  Space.height(16),
                  Image.asset(
                    ImageConstant.check_circle,
                    height: 50,
                    width: 50,
                  ),
                  Space.height(18),
                  SizedBox(
                    width: MySize.size296,
                    child: Text(
                        '“<Cluster 5>” is added successfully. What do you wish to do next?',
                        style: AppStyle.textStyleInterMed(fontSize: 16)),
                  ),
                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddClusterView());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff27528F)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Add another Cluster",
                          style: AppStyle.textStyleInterMed(
                              fontSize: 14, color: Color(0xff27528F)),
                        ),
                      ),
                    ),
                  ),
                  Space.height(16),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddVdfView(
                        p: p,
                        location: location,
                        regions: r,
                      ));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff27528F)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Add VDF to this Cluster",
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

class AddVdfView extends StatelessWidget {
  String? location, regions, p;

  AddVdfView({super.key, this.location, this.p, this.regions});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add VDF',
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MySize.size98,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff006838).withOpacity(0.15)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  //Text("Region: ",style: AppStyle.textStyleBoldMed(color: Color(0xff006838)),)
                  RichText(
                    text: TextSpan(
                      text: 'Region: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: regions,
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
                      text: 'Cluster: ',
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
                  Spacer(),
                ],
              ),
            ),
          ),
          Space.height(15),
          GetBuilder<AddClusterController>(
            id: "add",
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  controller: controller.vdfController.value,
                  onChanged: (value) {
                    controller.update(["add"]);
                  },
                  decoration: const InputDecoration(
                    labelText: "VDF Name",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              );
            },
          ),
          Space.height(19),
          GestureDetector(
            onTap: () {
              showConfirmationDialog(context);
            },
            child: commonButton(title: "Add VDF", color: Color(0xff27528F)),
          )
        ],
      ),
    ));
  }

  void showConfirmationDialog(BuildContext context,
      {String? location, String? r, String? p}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 91),
          child: AlertDialog(
            backgroundColor: Colors.white,
            alignment: Alignment.topCenter,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Space.height(16),
                  Image.asset(
                    ImageConstant.check_circle,
                    height: 50,
                    width: 50,
                  ),
                  Space.height(18),
                  SizedBox(
                    width: MySize.size296,
                    child: Center(
                      child: Text('VDF is added successfully.',
                          style: AppStyle.textStyleBoldMed(
                              fontSize: 16,
                              color: Color(0xff181818).withOpacity(0.8))),
                    ),
                  ),
                  Space.height(25),
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
