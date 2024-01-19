import 'package:dalmia/app/modules/addLocation/views/add_cluster_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addLocation/service/apiService.dart';
import '../controllers/add_location_controller.dart';



class AddLocationView extends StatefulWidget {
  String? region, location;

  AddLocationView({Key? key}) : super(key: key);

  @override
  _AddLocationViewState createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  final ApiService apiService = ApiService();
  AddLocationController controller = Get.put(AddLocationController());
  late Future<Map<String, dynamic>> regionsFuture;
  String? validationResult;

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
                              // Map<String, dynamic> locationsData =
                              // await apiService.getListOfLocations(
                              //     controller.selectRegionId!);

                              // Extract the list of locations from the returned data
                              // List<Map<String, dynamic>> locations =
                              // locationsData['locations'];

                              // Update the controller with the new list of locations
                              // controller.updateLocations(locations);
                              // controller.update(["add"]);

                              // Update the selected location's name and ID in the controller
                              // controller.selectLocation =
                              // null; // Assuming you initially set it to null
                              // controller.selectLocationId = null;
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
            Obx(
                  () =>
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: TextFormField(
                      controller: controller.nameController.value,
                      onChanged: (value) {
                        // controller.locationValue = value;
                        print(controller.nameController.value.text);
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
                  onTap: () async {
                    if (controller.nameController.value.text.isNotEmpty && controller.selectRegion != null) {
                      controller.selectedIndex = -1;

                      String message = await performValidation();

                      if (message == "Data Found"){
                        validationResult = message;
                        print("Error : Already Existing $validationResult");

                        setState(() {
                          validationResult = "Location already exists";
                        });

                      }
                      else {
                        Get.to(AddClusterViewL());
                      }

                    }
                  },
                  child: commonButton(
                      title: "Add Location",
                      color: controller.nameController.value.text.isNotEmpty &&
                          controller.selectRegion != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },

            ),

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


  Future<String> performValidation() async {
    // Your validation logic here
    // Example: Check if fields are not empty, perform API validation, etc.
    // Return true if validation passes, false otherwise

    print('performValidation ${controller.nameController.value.text}');
    
    Future<String> message = apiService.checkDuplicateLocation(controller.nameController.value.text ?? "");

    // print('performValidation message : ${message.toString()}');
    return message;
  }

}