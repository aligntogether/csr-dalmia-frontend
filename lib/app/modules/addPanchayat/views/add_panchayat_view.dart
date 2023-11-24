import 'package:dalmia/app/modules/addPanchayat/views/add_new_panchayat_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_panchayat_controller.dart';

class AddPanchayatView extends GetView<AddPanchayatController> {
  const AddPanchayatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Panchayat',
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
            Space.height(36),
            GetBuilder<AddPanchayatController>(
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
            GetBuilder<AddPanchayatController>(
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
            Space.height(30),
            GetBuilder<AddPanchayatController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null) {
                      Get.to(AddNewPView(location:controller.selectLocation ,region:   controller.selectRegion,));
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }
}
