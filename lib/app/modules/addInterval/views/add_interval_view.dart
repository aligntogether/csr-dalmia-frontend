import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/add_interval_controller.dart';

class AddIntervalView extends GetView<AddIntervalController> {
  const AddIntervalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddIntervalController a = Get.put(AddIntervalController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Intervention',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Space.height(50),
              GetBuilder<AddIntervalController>(
                id: "add",
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.nVdfN.value,
                      onChanged: (value) {
                        controller.update(["add"]);
                      },
                      decoration: const InputDecoration(
                        labelText: "New VDF Name",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.0),
                      ),
                    ),
                  );
                },
              ),
              Space.height(15),
              GetBuilder<AddIntervalController>(
                id: "add",
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.lever.value,
                      onChanged: (value) {
                        controller.update(["add"]);
                      },
                      decoration: const InputDecoration(
                        labelText: "Lever",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.0),
                      ),
                    ),
                  );
                },
              ),
              Space.height(15),
              GetBuilder<AddIntervalController>(
                id: "add",
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.exAnnualIncome.value,
                      onChanged: (value) {
                        controller.update(["add"]);
                      },
                      decoration: const InputDecoration(
                        labelText: "Expected Annual Income",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.0),
                      ),
                    ),
                  );
                },
              ),
              Space.height(15),
              GetBuilder<AddIntervalController>(
                id: "add",
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.noOfDay.value,
                      onChanged: (value) {
                        controller.update(["add"]);
                      },
                      decoration: const InputDecoration(
                        labelText: "No. of days required for completion",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.0),
                      ),
                    ),
                  );
                },
              ),
              Space.height(30),
              GetBuilder<AddIntervalController>(
                id: "add",
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.nVdfN.value.text.isNotEmpty &&
                          controller.lever.value.text.isNotEmpty &&
                          controller.exAnnualIncome.value.text.isNotEmpty &&
                          controller.noOfDay.value.text.isNotEmpty) {}
                    },
                    child: commonButton(
                        title: "Add Intervention",
                        color: controller.nVdfN.value.text.isNotEmpty &&
                                controller.lever.value.text.isNotEmpty &&
                                controller
                                    .exAnnualIncome.value.text.isNotEmpty &&
                                controller.noOfDay.value.text.isNotEmpty
                            ? Color(0xff27528F)
                            : Color(0xff27528F).withOpacity(0.7)),
                  );
                },
              ),
              Space.height(16),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  shadows: [
                    const BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF27528F),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Get.to(InterventionListView());
                    },
                    icon: const Icon(Icons.folder_outlined),
                    label: Text(
                      'Intervention List',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}

class InterventionListView extends StatelessWidget {
  const InterventionListView({super.key});

  @override
  Widget build(BuildContext context) {
    AddIntervalController controller = Get.put(AddIntervalController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Space.height(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 15,
                    ),
                    Space.width(5),
                    Text(
                      "Back",
                      style: AppStyle.textStyleInterMed(fontSize: 14),
                    ),
                    Spacer(),
                    Icon(
                      Icons.clear,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Space.height(18),
            Text(
              "Intervention List",
              style: AppStyle.textStyleBoldMed(fontSize: 16),
            ),
            Space.height(16),
            dataTable(controller),
            Space.height(30),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: MySize.size48,
                width: MySize.size168,
                decoration: BoxDecoration(
                    border: Border.all(color: darkBlueColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/Excel.svg',
                      height: 25,
                      width: 25,
                    ),
                    Space.width(3),
                    Text(
                      'Download  Excel',
                      style: AppStyle.textStyleInterMed(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget dataTable(AddIntervalController controller) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DataTable(
              dividerThickness: 00,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              columnSpacing: 0,
              horizontalMargin: 0,
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 60,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text(
                          'S.No.',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 333,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Intervention Titles',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 80,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Lever',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 157,
                    color: Color(0xff008CD3),
                    child: Center(
                      child: Text(
                        'Expected additional\nannual income Rs.',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    height: 60,
                    width: 190,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Days required to\ncomplete Intervention',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                controller.locations.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      return controller.locations[index] == "Households" ||
                              controller.locations[index] == "Interventions" ||
                              controller.locations[index] ==
                                  "HH with Annual Addl. Income"
                          ? Color(0xff008CD3).withOpacity(0.3)
                          : index.isEven
                              ? Colors.blue.shade50
                              : Colors.white;
                    },
                  ),
                  cells: [
                    DataCell(
                      Container(
                        width: 50,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.locations[index] == "Total"
                                  ? ""
                                  : "${index}",
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.locations[index] == "Total"
                                ? SizedBox()
                                : VerticalDivider(
                                    width: 1,
                                    color: Color(0xff181818).withOpacity(0.3),
                                    thickness: 1,
                                  )
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.locations[index]),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //alr
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.ALR[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //bgm
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.BGM[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //kdp
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            (controller.KDP[index].toString()),
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
