// import 'dart:html';
import 'dart:io';

import 'package:dalmia/app/modules/addIntervention/service/addInterventionApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/theme.dart';
import 'package:excel/excel.dart' as excels;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import '../../../../common/image_constant.dart';
import '../../../../pages/gpl/gpl_home_screen.dart';
import '../../downloadExcelFromTable/ExportTableToExcel.dart';
import '../controllers/add_intervention_controller.dart';
import 'package:path_provider/path_provider.dart';


class AddInterventionView extends StatefulWidget {

  AddInterventionView({Key? key}) : super(key: key);

  @override
  _AddInterventionViewState createState() => _AddInterventionViewState();
}

class _AddInterventionViewState extends State<AddInterventionView> {

  AddInterventionController controller = new AddInterventionController();
  AddInterventionApiService addInterventionApiService = new AddInterventionApiService();
  String? validationResult;

  @override
  Widget build(BuildContext context) {
    AddInterventionController a = Get.put(AddInterventionController());
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
              GetBuilder<AddInterventionController>(
                id: "add",
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.newInterventionTitle.value,
                      onChanged: (value) {
                        controller.update(["add"]);
                      },
                      decoration: const InputDecoration(
                        labelText: "Add Intervention Title",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.0),
                      ),
                    ),
                  );
                },
              ),
              Space.height(15),
              GetBuilder<AddInterventionController>(
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
              GetBuilder<AddInterventionController>(
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
              GetBuilder<AddInterventionController>(
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
              GetBuilder<AddInterventionController>(
                id: "add",
                builder: (controller) {
                  return GestureDetector(
                    onTap: () async {
                      if (controller.newInterventionTitle.value.text.isNotEmpty &&
                          controller.lever.value.text.isNotEmpty &&
                          controller.exAnnualIncome.value.text.isNotEmpty &&
                          controller.noOfDay.value.text.isNotEmpty) {

                        String duplicateResponse = await addInterventionApiService.validateDuplicateIntervention(controller.newInterventionTitle.value.text);

                        if (duplicateResponse == "Data Found") {
                          setState(() {
                            validationResult = "Intervention title already exists";
                          });
                        }
                        else {

                          try {
                            String addResponse = await addInterventionApiService.addIntervention(controller.newInterventionTitle.value.text,  controller.lever.value.text, int.tryParse(controller.exAnnualIncome.value.text)!, int.tryParse(controller.noOfDay.value.text)!);

                            if (addResponse == "Data Added") {
                              showConfirmationDialog(context);
                            }
                            else {

                              setState(() {
                                validationResult = "Something went wrong!";
                              });
                            }

                          }
                          catch (e) {
                            setState(() {
                              validationResult = "Something went wrong!, $e";
                            });
                          }

                        }

                      }
                    },
                    child: commonButton(
                        title: "Add Intervention",
                        color: controller.newInterventionTitle.value.text.isNotEmpty &&
                            controller.lever.value.text.isNotEmpty &&
                            controller
                                .exAnnualIncome.value.text.isNotEmpty &&
                            controller.noOfDay.value.text.isNotEmpty
                            ? Color(0xff27528F)
                            : Color(0xff27528F).withOpacity(0.7)),
                  );
                },
              ),

              // Display the error message with red color if there's an error
              if (validationResult != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    validationResult!,
                    style: TextStyle(color: Colors.red),
                  ),
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


  void showConfirmationDialog(BuildContext context) {
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
                      child: Text('Intervention added successfully. ',
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




class InterventionListView extends StatefulWidget {

  InterventionListView({super.key});

  @override
  _InterventionListViewState createState() => _InterventionListViewState();
}

class _InterventionListViewState extends State<InterventionListView> {

  AddInterventionController controller = Get.put(AddInterventionController());
  AddInterventionApiService addInterventionApiService = new AddInterventionApiService();
  ExportTableToExcel exportsTableToExcel = new ExportTableToExcel();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData(){
    addInterventionApiService.fetchInterventionsData(controller, controller.skipRecordsCount, controller.recordsCount).then((value) => {
      setState(()=> controller.updateInterventionsData(value!))
    });
  }

  void nextPage(){
    if(controller.pageNumber == (controller.totalInterventionsCount / 20).ceil()) return;

    setState(() {
      controller.pageNumber++;
      controller.skipRecordsCount = 20 * (controller.pageNumber - 1);
      fetchData();
    });
  }

  void prevPage(){
    if(controller.pageNumber == 1) return;

    setState(() {
      controller.pageNumber--;
      controller.skipRecordsCount = 20 * (controller.pageNumber - 1);
      fetchData();
    });
  }

  void goToFirst(){
    setState(() {
      controller.pageNumber = 1;
      controller.skipRecordsCount = 20 * (controller.pageNumber - 1);
      fetchData();
    });
  }

  void goToLast(){
    setState(() {
      controller.pageNumber = (controller.totalInterventionsCount / 20).ceil();
      controller.skipRecordsCount = 20 * (controller.pageNumber - 1);
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    print("exportTableToExcel(controller)");
                    exportsTableToExcel.exportTableToExcel(controller,
                        ['S.No.', 'Intervention Titles', 'Lever', 'Expected additional annual income Rs.', 'Days required to complete Intervention'],
                        ['interventionName', 'lever', 'expectedIncomeGeneration', 'requiredDaysCompletion']);

                    print("exportTableToExcel(controller)  1");
                  },
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

  Widget dataTable(AddInterventionController controller) {
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
                          'S.No. ',
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
                controller.interventionsData != null ? controller.interventionsData!.length : 0,
                    (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                        (states) {

                      // print("lllllcontroller.interventionsData : ${controller.interventionsData}");

                      return controller.interventionsData![index]['interventionName'] == "Households" ||
                          controller.interventionsData![index]['interventionName'] == "Interventions" ||
                          controller.interventionsData![index]['interventionName'] ==
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
                              "${index+1}",
                              style: AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.interventionsData![index]['interventionName'] == "Total"
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
                            controller.interventionsData![index]['interventionName'] ?? '',
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
                            controller.interventionsData![index]['lever'].toString() ?? '',
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
                            controller.interventionsData![index]['expectedIncomeGeneration'].toString() ?? '',
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
                            controller.interventionsData![index]['requiredDaysCompletion'].toString() ?? '',
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
              )
          ),

        ));
  }
}