import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addPanchayat/Service/apiService.dart';
import '../controllers/replace_vdf_controller.dart';
import '../service/replaceVdfApiService.dart';


class ReplaceVdfView extends StatefulWidget {
  String? region, location;

  ReplaceVdfView({Key? key}) : super(key: key);

  @override
  _ReplaceVdfViewState createState() => _ReplaceVdfViewState();
}

class _ReplaceVdfViewState extends State<ReplaceVdfView> {
  final ApiService addPanchayatApiService = ApiService();
  final ReplaceVdfApiService addClusterApiService = ReplaceVdfApiService();

  ReplaceVdfController controller = Get.put(ReplaceVdfController());
  late Future<Map<String, dynamic>> regionsFuture;
  late Future<Map<String, dynamic>> clustersFuture;
  String? validationResult;

  @override
  void initState() {
    super.initState();
    regionsFuture = addPanchayatApiService.getListOfRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Replace VDF',
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
            Space.height(20),

            GetBuilder<ReplaceVdfController>(
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
                              await addPanchayatApiService.getListOfLocations(
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
                              controller.selectCluster = null;

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
            GetBuilder<ReplaceVdfController>(
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


                          Map<String, dynamic> clustersData = await addPanchayatApiService.getListOfClusters(controller.selectLocationId ?? 0);

                          List<Map<String, dynamic>> clusters =
                          clustersData['clusters'];

                          print("clusters.length : ${clusters.length}");
                          print("clusters : $clusters");

                          controller.updateClusters(clusters);
                          controller.update(["add"]);

                        }
                      }
                    }
                  },
                );
              },
            ),
            Space.height(15),

            GetBuilder<ReplaceVdfController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                  title: "Select Cluster",
                  options: controller.clusters != null ? (controller.clusters!
                      .map((cluster) =>
                      cluster['clusterName'].toString())
                      .toList()) : [],
                  selectedValue: controller.selectLocation,
                  onChanged: (String? newValue) async {
                    // Find the selected region and get its corresponding regionId
                    Map<String, dynamic>? selectedCluster = controller.clusters
                        ?.firstWhere((cluster) => cluster['cluster'] == newValue);

                    print('controller.selectedCluster: ${selectedCluster}');


                    if (selectedCluster != null &&
                        selectedCluster['clusterId'] != null) {
                      controller.selectClusterId =
                      selectedCluster['clusterId'];
                      controller.selectCluster = newValue;
                      controller.update(["add"]);

                      print('controller.selectedCluster: ${controller
                          .selectClusterId}');
                    }
                  },
                );
              },

            ),

            Space.height(30),
            GetBuilder<ReplaceVdfController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null &&
                        controller.selectCluster != null) {
                      Get.to(ReplaceVdfNewView(
                        regions: controller.selectRegion,
                        location: controller.selectLocation,
                        cl: controller.selectCluster,
                      ));
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null &&
                              controller.selectCluster != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }
}

class ReplaceVdfNewView extends StatelessWidget {
  String? location, regions, cl;

  ReplaceVdfNewView({super.key, this.location, this.regions, this.cl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Replace VDF',
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height:122,
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
                      text: 'Panchayat: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: cl,
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14,
                                color: Color(0xff006838).withOpacity(0.5))),
                      ],
                    ),
                  ),
                  Space.height(8),
                  RichText(
                    text: TextSpan(
                      text: 'Existing VDF: ',
                      style: AppStyle.textStyleBoldMed(
                          fontSize: 14, color: Color(0xff006838)),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Lakshmi",
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
          Space.height(15),
          GetBuilder<ReplaceVdfController>(
            id: "add",
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                //  controller: controller.vdfController.value,
                  onChanged: (value) {
                    controller.update(["add"]);
                  },
                  decoration: const InputDecoration(
                    labelText: "New VDF Name",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              );
            },
          ),
          Space.height(19),
          GestureDetector(onTap: () {
            showConfirmationDialog(context);
          },
            child: commonButton(
                title: "Add VDF",
                color:  Color(0xff27528F)),
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
                      child: Text('VDF replaced successfully. ',
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
