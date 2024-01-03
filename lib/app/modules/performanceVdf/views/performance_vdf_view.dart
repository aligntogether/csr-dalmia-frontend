import 'package:dalmia/app/modules/overviewPan/views/overview_pan_view.dart';
import 'package:dalmia/app/modules/performanceVdf/service/performanceVdfApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/performance_vdf_controller.dart';



class PerformanceVdfView extends StatefulWidget {

  PerformanceVdfView({Key? key}) : super(key: key);

  @override
  _PerformanceVdfViewState createState() => new _PerformanceVdfViewState();
}

class _PerformanceVdfViewState extends State<PerformanceVdfView> {
  final PerformanceVdfApiService performanceVdfApiService = new PerformanceVdfApiService();

  PerformanceVdfController controller = Get.put(PerformanceVdfController());
  late Future<Map<String, dynamic>> regionsFuture;
  late Future<Map<String, dynamic>> clustersFuture;

  @override
  void initState() {
    super.initState();
    regionsFuture = performanceVdfApiService.getListOfRegions();
  }
  
  
  @override
  Widget build(BuildContext context) {
    PerformanceVdfController c = Get.put(PerformanceVdfController());
    return SafeArea(
      child: Scaffold(
          appBar: appBarCommon(controller, context,
              centerAlignText: true, title: "Reports"),
          body: Column(
            children: [
              //appBar(context, title: "Performance of VDF "),
              Space.height(16),

              ///_________________________________ main menu __________________________///
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
              Space.height(32),
              GetBuilder<PerformanceVdfController>(
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
                                controller.selectRegion = newValue;

                                controller.update(["add"]);

                                // Get locations based on the selected regionId
                                Map<String, dynamic> locationsData =
                                await performanceVdfApiService.getListOfLocations(
                                    controller.selectRegionId!);

                                // Extract the list of locations from the returned data
                                List<Map<String, dynamic>> locations =
                                locationsData['locations'];

                                // Update the controller with the new list of locations
                                controller.updateLocations(locations);
                                controller.update(["add"]);

                                setState(() {
                                  controller.selectLocation =
                                  null;
                                  controller.selectLocationId = null;
                                  controller.selectCluster = null;
                                  controller.selectVdfName = null;
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
              Space.height(15),
              GetBuilder<PerformanceVdfController>(
                id: "add",
                builder: (controller) {
                  return CustomDropdownFormField(
                    title: "Select Location",
                    options:
                    controller.locations != null ? (controller.locations!
                        .map((location) =>
                        location['location'].toString())
                        .toList()) : [],
                    selectedValue: controller.selectLocation,
                    onChanged: (String? newValue) async {

                      // Find the selected location and get its corresponding locationId
                      if (controller.locations != null) {
                        // Find the selected location object based on the 'location' property

                        // print('controller.locations: ${controller.locations}');


                        Map<String, dynamic>? selectedLocation = controller.locations
                            ?.firstWhere((location) => location['location'] == newValue);

                        if (selectedLocation != null) {

                          // Access the locationId property and convert it to int
                          int? selectedLocationId =
                          selectedLocation['locationId'];

                          // print('selectedLocationId: $selectedLocationId');

                          if (selectedLocationId != null) {
                            // Assign 'location' to controller.selectLocation

                            controller.selectLocation =
                            selectedLocation['location'] as String;
                            controller.selectLocationId = selectedLocationId;

                            controller.update(["add"]);

                            controller.selectCluster = null;


                            Map<String, dynamic>? clustersData = await performanceVdfApiService.getListOfClusters(controller.selectLocationId ?? 0);


                            if (clustersData != null) {

                              List<Map<String, dynamic>> clusters =
                              clustersData?['clusters'];

                              print("clusters.length : ${clusters.length}");
                              print("clusters : $clusters");

                              controller.updateClusters(clusters);
                              controller.update(["add"]);
                            }

                            if (clustersData == null) {
                              setState(() {
                                controller.clusters = List.generate(1, (index) => <String, dynamic>{"vdfName" : "No Data Found"});
                              });
                            }

                            setState(() {
                              controller.selectClusterId =
                              0;
                              controller.selectCluster = null;
                              controller.selectVdfName = null;
                            });

                          }
                        }
                      }
                    },
                  );
                },
              ),
              Space.height(15),

              GetBuilder<PerformanceVdfController>(
                id: "add",
                builder: (controller) {
                  return CustomDropdownFormField(
                    title: "VDF Name",
                    options: controller.clusters != null ? (controller.clusters!
                        .map((cluster) =>
                        cluster['vdfName'].toString())
                        .toList()) : [],
                    selectedValue: controller.selectCluster,
                    onChanged: (String? newValue) async {
                      // Find the selected region and get its corresponding regionId
                      Map<String, dynamic>? selectedCluster = controller.clusters
                      !.firstWhere((cluster) => cluster['vdfName'] == newValue);

                      print('controller.selectedCluster: ${selectedCluster}');


                      if (selectedCluster != null &&
                          selectedCluster['clusterId'] != null) {

                        controller.selectClusterId =
                        selectedCluster['clusterId'];
                        controller.selectCluster = newValue;
                        controller.selectVdfName = selectedCluster['vdfName'];


                        controller.update(["add"]);


                        print('controller.selectedCluster: ${controller
                            .selectClusterId}, name : ${controller.selectVdfName}');
                      }


                    },
                  );
                },

              ),

              Space.height(20),
              Text(
                "Performance of VDF over past 8 weeks",
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              ),
              Space.height(16),

              SizedBox(
                  width: 326,
                  child: Text(
                    "*Note: Cumulative figures are from the beginning of the project, NOT the total of figures displayed on this screen",
                    style: AppStyle.textStyleInterMed(fontSize: 12),
                  )),
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
              Space.height(30),
            ],
          )),
    );
  }
}
