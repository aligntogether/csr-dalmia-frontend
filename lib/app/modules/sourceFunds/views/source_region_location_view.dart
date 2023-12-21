import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/app/modules/sourceFunds/service/sourceOfFundsApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class SourceRegionsView extends StatefulWidget {
  const SourceRegionsView({super.key});

  @override
  _SourceRegionsViewState createState() => _SourceRegionsViewState();
}

class _SourceRegionsViewState extends State<SourceRegionsView> {
  final SourceOfFundsApiService sourceOfFundsApiService = new SourceOfFundsApiService();
  SourceFundsController controller = new SourceFundsController();
  late Future<Map<String, dynamic>> regionsFuture;

  @override
  void initState() {
    super.initState();
    regionsFuture = sourceOfFundsApiService.getListOfRegions(controller);
  }


  @override
  Widget build(BuildContext context) {
    SourceFundsController controller = Get.put(SourceFundsController());
    return SafeArea(
      child: Scaffold(
        appBar: appBarCommon(controller, context,
            centerAlignText: true, title: "Reports"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Space.height(16),

              ///_________________________________ main menu __________________________///
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return GPLHomeScreen();
                    },
                  ));
                },
                child: Row(
                  children: [
                    Space.width(16),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                    Text(
                      "Main Menu",
                      style: AppStyle.textStyleInterMed(fontSize: 14),
                    ),
                    Spacer(),
                    viewOtherReports(context),
                    Space.width(16),
                  ],
                ),
              ),
              Space.height(34),

              Text(
                "Source of Funds for Interventions\n(in Lakhs) ",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),

              Space.height(30),
              GetBuilder<SourceFundsController>(
                id: "add",
                builder: (controller) {
                  return FutureBuilder<Map<String, dynamic>>(
                    // Assuming that getListOfRegions returns a Future<Map<String, dynamic>>
                    future: regionsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        Map<String, dynamic> responseData = snapshot.data ?? {};

                        if (responseData.containsKey('regions')) {
                          List<Map<String, dynamic>> regionOptions =
                          responseData['regions'];

                          return CustomDropdownFormField(
                            title: "Select a Region",
                            options: regionOptions
                                .map((region) => region['region'].toString())
                                .toList(),
                            selectedValue: controller.selectRegion,
                            onChanged: (String? newValue) async {
                              // Find the selected region and get its corresponding regionId
                              Map<String, dynamic>? selectedRegion =
                              regionOptions.firstWhereOrNull(
                                      (region) => region['region'] == newValue);

                              // print('controller.selectedRegions: ${selectedRegion}');


                              if (selectedRegion != null &&
                                  selectedRegion['regionId'] != null) {
                                controller.selectRegionId =
                                selectedRegion['regionId'];

                                setState(() {
                                  controller.selectRegion = newValue;
                                });

                                controller.update(["add"]);

                                // Get locations based on the selected regionId
                                Map<String, dynamic> locationsData =
                                await sourceOfFundsApiService.getListOfLocations(
                                    controller.selectRegionId!);

                                // Extract the list of locations from the returned data
                                List<Map<String, dynamic>> locations =
                                locationsData['locations'];

                                controller.updateLocations(locations);
                                controller.update(["add"]);


                                // Update the controller with the new list of locations
                                if (locationsData != null) {
                                 setState(() {
                                   controller.regions = controller.locationsList != null ? (controller.locationsList!
                                       .map((location) =>
                                       location['location'].toString())
                                       .toList()) : [];
                                   controller.regions.add('Total');
                                 });
                                }

                                var fetchRegionWiseSourceOfFundsData = await sourceOfFundsApiService.fetchRegionWiseSourceOfFundsData(controller);

                                setState(() {
                                  controller.regionWiseSourceOfFundsData = fetchRegionWiseSourceOfFundsData;
                                  print(" \n \n controller.updateRegionWiseSourceOfFundsData e2bf : ${fetchRegionWiseSourceOfFundsData}");
                                });


                                // ----------------------

                                List<String> targetRegions = controller.locationsList != null ? (controller.locationsList!
                                    .map((location) =>
                                    location['location'].toString())
                                    .toList()) : [];
                                List<String> targetKeys = ['noOfHouseholds', 'beneficiary', 'subsidy', 'credits', 'dbf'];

                                print("\n \n con reached: ");

                                Map<String, dynamic> allTotal = await calculateIndividualKeySumsForRegions(targetRegions, controller.regionWiseSourceOfFundsData!, targetKeys);


                                setState(() {
                                  controller.regionWiseSourceOfFundsData!.putIfAbsent('Total', () => allTotal);
                                });

                                print("controller.sourceOfFundsData  hafsb1: ${controller.regionWiseSourceOfFundsData}");

                                // ----------------------



                                // Update the selected location's name and ID in the controller
                                setState(() {
                                  controller.selectLocation = null;
                                  controller.selectLocationId = null;
                                });

                              }
                            },
                          );
                        } else {
                          return Text('No regions available');
                        }
                      }
                    },
                  );
                },
              ),

              Space.width(10),
              Space.height(10),

              GetBuilder<SourceFundsController>(
                id: "add",
                builder: (controller) {
                  return CustomDropdownFormField(
                    title: "Select Location",
                    options:
                    controller.locationsList != null ? (controller.locationsList!
                        .map((location) =>
                        location['location'].toString())
                        .toList()) : [],
                    selectedValue: controller.selectLocation,
                    onChanged: (String? newValue) {

                      // Find the selected location and get its corresponding locationId
                      if (controller.locationsList != null) {
                        // Find the selected location object based on the 'location' property

                        // print('controller.locations: ${controller.locations}');

                        Map<String, dynamic>? selectedLocation = controller.locationsList
                            ?.firstWhere((location) => location['location'] == newValue);

                        if (selectedLocation != null) {

                          // Access the locationId property and convert it to int
                          int? selectedLocationId =
                          selectedLocation['locationId'];

                          // print('selectedLocationId: $selectedLocationId');

                          if (selectedLocationId != null) {

                            setState(() {
                              controller.selectLocation =
                              selectedLocation['location'] as String;
                              controller.selectLocationId = selectedLocationId;
                            });


                            //

                            // Update the controller with the new list of locations
                            // if (clustersData != null) {
                            //   setState(() {
                            //     controller.regions = controller.locationsList != null ? (controller.locationsList!
                            //         .map((location) =>
                            //         location['location'].toString())
                            //         .toList()) : [];
                            //     controller.regions.add('Total');
                            //   });
                            // }
                            //
                            // var fetchRegionWiseSourceOfFundsData = await sourceOfFundsApiService.fetchRegionWiseSourceOfFundsData(controller);
                            //
                            // setState(() {
                            //   controller.updateRegionWiseSourceOfFundsData(fetchRegionWiseSourceOfFundsData);
                            //   print(" \n \n controller.updateRegionWiseSourceOfFundsData e2bf : ${controller.updateRegionWiseSourceOfFundsData}");
                            // });

                            //


                            controller.update(["add"]);
                          }
                        }
                      }
                    },
                  );
                },
              ),

              Space.height(30),
             GetBuilder<SourceFundsController>(builder: (controller) {
               return Text(
                 controller.selectRegionId == null
                     ? '' : "${ controller.selectLocation??controller.selectRegion }",
                 style: AppStyle.textStyleBoldMed(fontSize: 14),
               );
             },),
              Text(
                controller.selectRegionId == null
                    ? '' : "Source of Funds (Rs. in Lakhs)",
                style: AppStyle.textStyleInterMed(fontSize: 14),
              ),
              Space.height(16),

              ///_________________________________ Table __________________________///
              // controller.selectLocation==null?tableDataRegionsView(controller):tableDataLocationView(controller),
            controller.selectRegionId == null
                ? Container() // Display nothing if region is not selected
                : controller.selectLocation == null
                ? tableDataRegionsView(controller) // Display tableDataRegionsView if region is selected but location is not
                : tableDataLocationView(controller),
              /*    SingleChildScrollView(
            child: Table(border: TableBorder.all(), children: [
              const TableRow(children: [
                Text('Details'),
                Text('No. of HH with completed Int.'),
              ]),
              TableRow(children: [
                const Text('Cement'),
                Table(border: TableBorder.all(), children: const [
                  TableRow(children: [
                    Text('Nested Entry 1'),
                    Text('Nested Entry 2'),
                  ]),
                  TableRow(children: [
                    Text('Nested Entry 3'),
                    Text('Nested Entry 4'),
                  ]),
                ]),
              ]),
            ]),
          ),*/
              Space.height(20),
              controller.selectRegionId == null
                  ? Container() :
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
              Space.height(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableDataRegionsView(SourceFundsController controller) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      decoration: BoxDecoration(
                          color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text(
                          'Details',
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
                    width: 150,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'No. of HH with\ncompleted Int.',
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
                    width: 110,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Beneficiary',
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
                    child: Center(
                      child: Text(
                        'Subsidy',
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
                        'Credits',
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
                        'DBF  ',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //PANIND
                DataColumn(
                  label: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff096C9F),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10.0))),
                    height: 60,
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Total',
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
                controller.regions!.length,
                (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                    (states) {
                      return controller.regionWiseSourceOfFundsData![index] == "Households" ||
                              controller.regionWiseSourceOfFundsData![index] == "Interventions" ||
                              controller.regionWiseSourceOfFundsData![index] ==
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
                        width: 150,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.regions[index],
                              style: controller.regions[index] == "Cement"
                                  ? TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.regions[index] == "Cement"
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['noOfHouseholds'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['beneficiary'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['subsidy'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['credits'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
                                  width: 1,
                                  color: Color(0xff181818).withOpacity(0.3),
                                  thickness: 1,
                                )
                        ],
                      ),
                    ),
                    //cha
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['dbf'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
                                  width: 1,
                                  color: Color(0xff181818).withOpacity(0.3),
                                  thickness: 1,
                                )
                        ],
                      ),
                    ),

                    ///__________________________ South _______________________
                    DataCell(
                      Container(
                        height: 60,
                        color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.regions[index] == "Cement"?""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? _calculateSumForLocation(controller.regions[index], controller.regionWiseSourceOfFundsData!).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // Additional row for total
                  ],
                ),
              ) /*+



                            [
                              DataRow(
                                color: MaterialStateColor.resolveWith(
                                        (states) => Colors.white),
                                cells: [
                                  DataCell(
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: CustomFontTheme.textSize,
                                        fontWeight: CustomFontTheme.headingwt,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "44444",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "64546",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],*/
              ),
        ));
  }

  // Widget tableDataLocationView(SourceFundsController controller) {
  //   return SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: DataTable(
  //             dividerThickness: 00,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 0,
  //                   blurRadius: 4,
  //                   offset: Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             columnSpacing: 0,
  //             horizontalMargin: 0,
  //             columns: <DataColumn>[
  //               DataColumn(
  //                 label: Expanded(
  //                   child: Container(
  //                     height: 60,
  //                     decoration: BoxDecoration(
  //                         color: Color(0xff008CD3),
  //                         borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(10.0))),
  //                     padding: EdgeInsets.only(left: 10),
  //                     child: Center(
  //                       child: Text(
  //                         'Details',
  //                         style: TextStyle(
  //                             fontWeight: CustomFontTheme.headingwt,
  //                             fontSize: CustomFontTheme.textSize,
  //                             color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 150,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'No. of HH with\ncompleted Int.',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 110,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'Beneficiary',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   child: Center(
  //                     child: Text(
  //                       'Subsidy',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'Credits',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               DataColumn(
  //                 label: Container(
  //                   height: 60,
  //                   width: 80,
  //                   color: Color(0xff008CD3),
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'DBF  ',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //               //PANIND
  //               DataColumn(
  //                 label: Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff096C9F),
  //                       borderRadius:
  //                           BorderRadius.only(topRight: Radius.circular(10.0))),
  //                   height: 60,
  //                   width: 80,
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   child: Center(
  //                     child: Text(
  //                       'Total',
  //                       style: TextStyle(
  //                           fontWeight: CustomFontTheme.headingwt,
  //                           fontSize: CustomFontTheme.textSize,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //             rows: List<DataRow>.generate(
  //               controller.clustersByLocation.length,
  //               (index) => DataRow(
  //                 color: MaterialStateColor.resolveWith(
  //                   (states) {
  //                     return index.isEven
  //                             ? Colors.blue.shade50
  //                             : Colors.white;
  //                   },
  //                 ),
  //                 cells: [
  //                   DataCell(
  //                     Container(
  //                       width: 150,
  //                       padding: EdgeInsets.only(left: 10),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             controller.clustersByLocation[index],
  //                             style: controller.clustersByLocation[index] == "Cement"
  //                                 ? TextStyle(
  //                                     color: CustomColorTheme.textColor,
  //                                     fontWeight: CustomFontTheme.headingwt,
  //                                     fontSize: CustomFontTheme.textSize)
  //                                 : AppStyle.textStyleInterMed(fontSize: 14),
  //                           ),
  //                           Spacer(),
  //                           controller.clustersByLocation[index] == "Cement"
  //                               ? SizedBox()
  //                               : VerticalDivider(
  //                                   width: 1,
  //                                   color: Color(0xff181818).withOpacity(0.3),
  //                                   thickness: 1,
  //                                 )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.lDPM[index].toString()),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         controller.clustersByLocation[index] == "Cement"
  //                             ? SizedBox()
  //                             : VerticalDivider(
  //                                 width: 1,
  //                                 color: Color(0xff181818).withOpacity(0.3),
  //                                 thickness: 1,
  //                               )
  //                       ],
  //                     ),
  //                   ),
  //                   //alr
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.ALR[index].toString()),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         controller.clustersByLocation[index] == "Cement"
  //                             ? SizedBox()
  //                             : VerticalDivider(
  //                                 width: 1,
  //                                 color: Color(0xff181818).withOpacity(0.3),
  //                                 thickness: 1,
  //                               )
  //                       ],
  //                     ),
  //                   ),
  //                   //bgm
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.BGM[index].toString()),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         controller.clustersByLocation[index] == "Cement"
  //                             ? SizedBox()
  //                             : VerticalDivider(
  //                                 width: 1,
  //                                 color: Color(0xff181818).withOpacity(0.3),
  //                                 thickness: 1,
  //                               )
  //                       ],
  //                     ),
  //                   ),
  //                   //kdp
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.KDP[index].toString()),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         controller.clustersByLocation[index] == "Cement"
  //                             ? SizedBox()
  //                             : VerticalDivider(
  //                                 width: 1,
  //                                 color: Color(0xff181818).withOpacity(0.3),
  //                                 thickness: 1,
  //                               )
  //                       ],
  //                     ),
  //                   ),
  //                   //cha
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Spacer(),
  //                         Text(
  //                           (controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.CHA[index].toString()),
  //                           style: AppStyle.textStyleInterMed(fontSize: 14),
  //                         ),
  //                         Spacer(),
  //                         controller.clustersByLocation[index] == "Cement"
  //                             ? SizedBox()
  //                             : VerticalDivider(
  //                                 width: 1,
  //                                 color: Color(0xff181818).withOpacity(0.3),
  //                                 thickness: 1,
  //                               )
  //                       ],
  //                     ),
  //                   ),
  //
  //                   ///__________________________ South _______________________
  //                   DataCell(
  //                     Container(
  //                       height: 60,
  //                       color: Color(0xff096C9F),
  //                       width: 80,
  //                       child: Center(
  //                         child: Text(
  //                           controller.clustersByLocation[index] == "Cement"
  //                               ? ""
  //                               : controller.SOUTH[index].toString(),
  //                           style: AppStyle.textStyleInterMed(
  //                               fontSize: 14, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   // Additional row for total
  //                 ],
  //               ),
  //             ) /*+
  //                           [
  //                             DataRow(
  //                               color: MaterialStateColor.resolveWith(
  //                                       (states) => Colors.white),
  //                               cells: [
  //                                 DataCell(
  //                                   Text(
  //                                     'Total',
  //                                     style: TextStyle(
  //                                       fontSize: CustomFontTheme.textSize,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   Text(
  //                                     "44444",
  //                                     style: TextStyle(
  //                                       color: CustomColorTheme.textColor,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                       fontSize: CustomFontTheme.textSize,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   Text(
  //                                     "64546",
  //                                     style: TextStyle(
  //                                       color: CustomColorTheme.textColor,
  //                                       fontWeight: CustomFontTheme.headingwt,
  //                                       fontSize: CustomFontTheme.textSize,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],*/
  //             ),
  //       ));
  // }

  Widget tableDataLocationView(SourceFundsController controller) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      decoration: BoxDecoration(
                          color: Color(0xff008CD3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.only(left: 10),
                      child: Center(
                        child: Text(
                          'Details',
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
                    width: 150,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'No. of HH with\ncompleted Int.',
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
                    width: 110,
                    color: Color(0xff008CD3),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Beneficiary',
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
                    child: Center(
                      child: Text(
                        'Subsidy',
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
                        'Credits',
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
                        'DBF  ',
                        style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //PANIND
                DataColumn(
                  label: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff096C9F),
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10.0))),
                    height: 60,
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Total',
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
                controller.regions!.length,
                    (index) => DataRow(
                  color: MaterialStateColor.resolveWith(
                        (states) {
                      return controller.regionWiseSourceOfFundsData![index] == "Households" ||
                          controller.regionWiseSourceOfFundsData![index] == "Interventions" ||
                          controller.regionWiseSourceOfFundsData![index] ==
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
                        width: 150,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              controller.regions[index],
                              style: controller.regions[index] == "Cement"
                                  ? TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize)
                                  : AppStyle.textStyleInterMed(fontSize: 14),
                            ),
                            Spacer(),
                            controller.regions[index] == "Cement"
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['noOfHouseholds'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['beneficiary'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['subsidy'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
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
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['credits'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                    //cha
                    DataCell(
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            controller.regions[index] == "Cement"
                                ? ""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? (controller.regionWiseSourceOfFundsData![controller.regions[index]]!['dbf'] ?? 0).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(fontSize: 14),
                          ),
                          Spacer(),
                          controller.regions[index] == "Cement"
                              ? SizedBox()
                              : VerticalDivider(
                            width: 1,
                            color: Color(0xff181818).withOpacity(0.3),
                            thickness: 1,
                          )
                        ],
                      ),
                    ),

                    ///__________________________ South _______________________
                    DataCell(
                      Container(
                        height: 60,
                        color: Color(0xff096C9F),
                        width: 80,
                        child: Center(
                          child: Text(
                            controller.regions[index] == "Cement"?""
                                : controller.regionWiseSourceOfFundsData!.containsKey(controller.regions[index])
                                ? _calculateSumForLocation(controller.regions[index], controller.regionWiseSourceOfFundsData!).toString()
                                : "0",
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // Additional row for total
                  ],
                ),
              ) /*+



                            [
                              DataRow(
                                color: MaterialStateColor.resolveWith(
                                        (states) => Colors.white),
                                cells: [
                                  DataCell(
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: CustomFontTheme.textSize,
                                        fontWeight: CustomFontTheme.headingwt,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "44444",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "64546",
                                      style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],*/
          ),
        ));
  }


  num _calculateSumForLocation(String location, Map<String, Map<String, dynamic>>? regionWiseSourceOfFundsData) {
    num sum = 0;

    if (regionWiseSourceOfFundsData!.containsKey(location)) {

      Map<String, dynamic>? locationData = regionWiseSourceOfFundsData![location];

      if (locationData != null) {
        for (var key in locationData.keys) {
          if (key != "noOfHouseholds" && locationData[key] is num) {
            sum += locationData[key];
          }
        }
      }
    }
    return sum;
  }


  Map<String, num> calculateIndividualKeySumsForRegions(List<String> locations, Map<String, Map<String, dynamic>> regionWiseSourceOfFundsData, List<String> targetData) {
    Map<String, num> totalKeySums = {};

    for (var location in locations) {
      Map<String, dynamic>? locationsData = regionWiseSourceOfFundsData[location];
      if (locationsData != null) {
        Map<String, num> individualKeySums = calculateIndividualKeySums(locationsData, targetData);
        // Sum values for existing keys:
        individualKeySums.forEach((key, value) {
          totalKeySums[key] = (totalKeySums[key] ?? 0) + value;
        });

        print("\n \n totalKeySums : $location : ${totalKeySums} \n \n");

      }
    }

    return totalKeySums;
  }

  Map<String, num> calculateIndividualKeySums(Map<String, dynamic> locationData, List<String> targetKeys) {
    Map<String, num> keySums = {};

    for (var key in locationData.keys) {
      if (targetKeys.contains(key) && locationData[key] is num) {
        keySums[key] = locationData[key]; // Store key-value pairs as a Map
      }
    }

    return keySums;
  }


}
