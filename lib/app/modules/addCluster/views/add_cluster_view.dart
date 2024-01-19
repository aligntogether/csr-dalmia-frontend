import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addPanchayat/Service/apiService.dart';
import '../controllers/add_cluster_controller.dart';
import '../service/addClusterApiService.dart';

class AddClusterView extends StatefulWidget {
  String? region, location;

  AddClusterView({Key? key}) : super(key: key);

  @override
  _AddClusterViewState createState() => _AddClusterViewState();
}

class _AddClusterViewState extends State<AddClusterView> {
  final ApiService addPanchayatApiService = ApiService();
  final AddClusterApiService addClusterApiService = AddClusterApiService();

  AddClusterController controller = Get.put(AddClusterController());
  late Future<Map<String, dynamic>> regionsFuture;
  String? validationResult;
  int? clusterCount = 0;

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
                                  await addPanchayatApiService
                                      .getListOfLocations(
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
                              controller.nameController.value =
                                  new TextEditingController();
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

            GetBuilder<AddClusterController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                  title: "Select Location",
                  options: controller.locations != null
                      ? (controller.locations!
                          .map((location) => location['location'].toString())
                          .toList())
                      : [],
                  selectedValue: controller.selectLocation,
                  onChanged: (String? newValue) async {
                    // Find the selected location and get its corresponding locationId
                    if (controller.locations != null) {
                      // Find the selected location object based on the 'location' property

                      // print('controller.locations: ${controller.locations}');

                      Map<String, dynamic>? selectedLocation =
                          controller.locations?.firstWhere(
                              (location) => location['location'] == newValue);

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

                          controller.nameController.value =
                              new TextEditingController();
                          setState(() {
                            clusterCount = 0;
                          });

                          Map<String, dynamic> clustersData =
                              await addPanchayatApiService.getListOfClusters(
                                  controller.selectLocationId ?? 0);

                          List<Map<String, dynamic>> clusters =
                              clustersData['clusters'];

                          controller.nameController.value.text =
                              clusters.length.toString() ?? '0';
                          controller.clusterCounts = clusters.length ?? 0;

                          setState(() {
                            clusterCount = clusters.length ?? 0;
                          });

                          print("clusters.length : ${clusters.length}");
                          print("clusters : $clusters");
                        }
                      }
                    }
                  },
                );
              },
            ),
            Space.height(15),
            GetBuilder<AddClusterController>(
              id: "add",
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.nameController.value,
                    onChanged: (value) {
                      if (clusterCount! > 4 && int.tryParse(value)! > 5) {
                        setState(() {
                          validationResult = "Cannot add more than 5 Clusters";
                        });
                      } else if (int.tryParse(value)! > 5) {
                        setState(() {
                          validationResult = "Cannot add more than 5 Clusters";
                        });
                      } else if (controller.clusterCounts! >
                          int.tryParse(value)!) {
                        setState(() {
                          validationResult = "Cannot reduce Clusters!";
                        });
                      } else if (controller.clusterCounts ==
                          int.tryParse(value!)) {
                        setState(() {
                          validationResult =
                              "Already contains $value Clusters!";
                        });
                      } else {
                        setState(() {
                          validationResult = null;
                        });
                        print("value : $value : $clusterCount");
                        clusterCount = int.tryParse(value);
                        print("value1 : $value : $clusterCount");
                      }
                      print("validationResult : $validationResult");

                      controller.update(["add"]);
                    },
                    decoration: const InputDecoration(
                      labelText: "Total Cluster",
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
                  onTap: () async {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null &&
                         clusterCount! <= 5 &&
                        validationResult == null) {
                      try {
                        Map<String, dynamic> clusterMap =
                            await addClusterApiService.updateAddCluster(
                                controller.selectLocationId ?? 0,
                                clusterCount ??
                                    int.tryParse(
                                        controller.nameController.value.text)!);

                        controller.addedClusterName = clusterMap['clusterName']==null?"":clusterMap['clusterName'];
                        controller.addedClusterId = clusterMap['clusterId'];


                        // controller.addedClusterName = "31";
                        // controller.addedClusterId = 10073;

                        if (clusterMap != null && clusterMap['clusterId'] != null && clusterCount! <= 5 ) {
                          clusterCount = clusterCount! + 1;
                          showConfirmationDialog(context,
                              location: controller.selectLocation,
                              p: controller.nameController.value.text,
                              r: controller.selectRegion);
                        } else {
                          validationResult = "Something went wrong!";
                        }
                      } catch (e) {
                        validationResult = "Something went wrong!, $e";
                      }
                    }

                    if(clusterCount! > 5){
                      setState(() {
                        validationResult = "Cannot add more than 5 Clusters";
                      });
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null &&
                              clusterCount != 0 &&
                              validationResult == null
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
                        '${controller.addedClusterName} is added successfully. What do you wish to do next?',
                        style: AppStyle.textStyleInterMed(fontSize: 16)),
                  ),
                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                      if(controller.clusterCounts! < 5){
                        Get.back();
                      }else{
                        Get.to(AddClusterView());
                      }
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

class AddVdfView extends StatefulWidget {
  String? location, regions, p;

  AddVdfView({super.key, this.location, this.p, this.regions});

  @override
  _AddVdfViewState createState() => _AddVdfViewState();
}

class _AddVdfViewState extends State<AddVdfView> {
  final ApiService addPanchayatApiService = ApiService();
  final AddClusterApiService addClusterApiService = AddClusterApiService();

  AddClusterController controller = Get.put(AddClusterController());
  String? validationResult;

  @override
  void initState() {
    super.initState();
  }

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
                            text: widget.regions,
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
                            text: widget.location,
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
                            text: widget.p,
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
                  controller: controller.vdfNameController.value,
                  onChanged: (value) {
                    print(
                        "controller.vdfNameController.value : ${controller.vdfNameController.value}");

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
          Space.height(15),
          GetBuilder<AddClusterController>(
            id: "add",
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  controller: controller.vdfMobileController.value,
                  onChanged: (value) {
                    print(
                        "controller.vdfMobileController.value : ${controller.vdfMobileController.value}");
                    controller.update(["add"]);
                  },
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              );
            },
          ),
          Space.height(19),
          GestureDetector(
            onTap: () async {
              if (controller.vdfMobileController.value.text.length < 10) {
                setState(() {
                  validationResult = "Mobile number should have 10 digits.";
                });
              }

              String addNewVdf = await addClusterApiService.addVDFToCluster(
                  controller.selectLocationId ?? 0,
                  controller.addedClusterId ?? 0,
                  controller.vdfNameController.value.text!,
                  int.tryParse(controller.vdfMobileController.value.text)!);

              print("addNewVdf : $addNewVdf");

              if (addNewVdf == "VDF Added") {
                showConfirmationDialog(context);
              } else {
                setState(() {
                  validationResult = "Something Went Wrong";
                });
              }
            },
            child: commonButton(title: "Add VDF", color: Color(0xff27528F)),
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
