import 'dart:convert';

import 'package:dalmia/app/modules/addPanchayat/views/add_new_panchayat_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_panchayat_controller.dart';
import '../Service/apiService.dart';

class AddPanchayatView extends StatefulWidget {
  AddPanchayatView({Key? key}) : super(key: key);

  @override
  _AddPanchayatViewState createState() => _AddPanchayatViewState();
}

class _AddPanchayatViewState extends State<AddPanchayatView> {
  final ApiService apiService = ApiService();
  late Future<Map<String, dynamic>> regionsFuture;

  @override
  void initState() {
    super.initState();
    regionsFuture = apiService.getListOfRegions();
  }

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
                                  await apiService.getListOfLocations(
                                      controller.selectRegionId!);

                              // Extract the list of locations from the returned data
                              List<Map<String, dynamic>> locations =
                                  locationsData['locations'];

                              // Update the controller with the new list of locations
                              controller.updateLocations(locations);
                              controller.update(["add"]);

                              // Update the selected location's name and ID in the controller
                              controller.selectLocation =
                                  null; // Assuming you initially set it to null
                              controller.selectLocationId = null;
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
            GetBuilder<AddPanchayatController>(
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
                  onChanged: (String? newValue) {

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
                        }
                      }
                    }
                  },
                );
              },
            ),
            Space.height(30),
            GetBuilder<AddPanchayatController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () async {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null) {
                      print("object1");

                      try {
                        int? locationId = controller.selectLocationId;
                        print('object2 : $locationId');

                        Map<String, dynamic> panchayatsData =
                            await apiService.getPanchayatsByLocations(controller
                                .selectLocationId!); // controller.selectLocationId

                        print("object31");

                        // Extract the list of panchayats from the returned data
                        List<Map<String, dynamic>> panchayats =
                            panchayatsData['panchayats'];

                        // Update the controller with the new list of panchayats
                        controller.updatePanchayats(panchayats
                            .map((panchayat) =>
                                panchayat['panchayatName'].toString())
                            .toList());
                        controller.update(["add"]);

                        // Navigate to the next screen
                        Get.to(AddNewPView(
                          location: controller.selectLocation,
                          region: controller.selectRegion,
                        ));
                      } catch (e) {
                        // Handle API error, e.g., show a toast or error message
                        print('Error fetching panchayats: $e');
                      }

                      // Get.to(AddNewPView(
                      //   location: controller.selectLocation,
                      //   region: controller.selectRegion,
                      // ));
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
