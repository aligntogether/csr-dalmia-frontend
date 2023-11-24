import 'package:dalmia/app/modules/addLocation/views/add_cluster_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_location_controller.dart';

class AddLocationView extends GetView<AddLocationController> {
  const AddLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddLocationController a = Get.put(AddLocationController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Location',
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
            GetBuilder<AddLocationController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select a Region",
                    options: [
                      "South & Chandrapur",
                      "Sugar",
                      "East",
                      "North East",
                    ],
                    selectedValue: controller.selectLocation,
                    onChanged: (String? newValue) async {
                      controller.selectLocation = newValue;
                      controller.update(["add"]);
                    });
              },
            ),
            Space.height(15),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  controller: controller.nameController.value,
                  onChanged: (value) {
                    controller.update(["add"]);
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Location Name",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              ),
            ),
            Space.height(30),
            GetBuilder<AddLocationController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.nameController.value.text.isNotEmpty &&
                        controller.selectLocation != null) {
                      controller.selectedIndex=-1;
                      Get.to(AddClusterViewL());
                    }
                  },
                  child: commonButton(
                      title: "Add Location",
                      color: controller.nameController.value.text.isNotEmpty &&
                              controller.selectLocation != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }
}
