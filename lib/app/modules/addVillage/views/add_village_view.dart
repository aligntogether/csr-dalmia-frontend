import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../addPanchayat/Service/apiService.dart';
import '../controllers/add_village_controller.dart';
import '../service/addVillageApiService.dart';


class AddVillageView extends StatefulWidget {
  const AddVillageView({Key? key}) : super(key: key);

  @override
  _AddVillageViewState createState() => _AddVillageViewState();
}

class _AddVillageViewState extends State<AddVillageView> {
  final ApiService apiService = ApiService();
  final AddVillageApiService addVillageApiService = AddVillageApiService();

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
            'Add Village',
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
            GetBuilder<AddVillageController>(
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
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select Location",
                    options: controller.locations != null ? (controller.locations!
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

                            // Update the selected location's name and ID in the controller
                            controller.selectPanchayat =
                            null; // Assuming you initially set it to null
                            controller.selectPanchayatId = null;


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
                              controller.updatePanchayats(panchayats);
                              controller.update(["add"]);
                              
                              
                            } catch (e) {
                              // Handle API error, e.g., show a toast or error message
                              print('Error fetching panchayats: $e');
                            }
                            
                            
                          }
                        }
                      }
                    });
              },
            ),
            Space.height(15),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return CustomDropdownFormField(
                    title: "Select Panchayat",
                    options: controller.panchayats != null ? (controller.panchayats!
                        .map((panchayat) => panchayat['panchayatName'].toString())
                        .toList()) : []
                    ,
                    selectedValue: controller.selectPanchayat,
                    onChanged: (String? newValue) async {




                      // Find the selected location and get its corresponding locationId
                      if (controller.panchayats != null) {
                        // Find the selected location object based on the 'location' property

                        // print('controller.locations: ${controller.locations}');

                        Map<String, dynamic>? selectedPanchayat = controller.panchayats
                            ?.firstWhere((panchayat) => panchayat['panchayatName'] == newValue);

                        if (selectedPanchayat != null) {

                          // Access the locationId property and convert it to int
                          int? selectedPanchayatId =
                          selectedPanchayat['panchayatId'];

                          // print('selectedLocationId: $selectedLocationId');

                          if (selectedPanchayatId != null) {
                            // Assign 'panchayat' to controller.selectPanchayat
                            controller.selectPanchayat =
                            selectedPanchayat['panchayatName'] as String;
                            controller.selectPanchayatId = selectedPanchayatId;
                            controller.update(["add"]);

                          }
                        }
                      }

                      print("controller.selectRegion : ${controller.selectRegion} \n");
                      print("controller.selectLocation : ${controller.selectLocation} \n");
                      print("controller.selectPanchayat : ${controller.selectPanchayat} \n");

                    });
              },
            ),
            Space.height(30),
            GetBuilder<AddVillageController>(
              id: "add",
              builder: (controller) {
                return GestureDetector(
                  onTap: () async {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null &&
                        controller.selectPanchayat != null) {

                      Map<String, dynamic> villagesData = await addVillageApiService.getListOfVillages(controller.selectPanchayatId ?? 0);

                      List<Map<String, dynamic>> villages =
                      villagesData['villages'];

                      controller.villages = villages;

                      print("controller.villages : ${controller.villages}");

                        // villages != null ? (villages!
                        //     .map((panchayat) => panchayat['panchayatName'].toString())
                        //     .toList()) : [];

                      Get.to(AddVillageNew(
                        location: controller.selectLocation,
                        region: controller.selectRegion,
                        panchayat: controller.selectPanchayat,
                      ));
                    }
                  },
                  child: commonButton(
                      title: "Continue",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null &&
                              controller.selectPanchayat != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)),
                );
              },
            )
          ],
        ));
  }
}





class AddVillageNew extends StatelessWidget {
  String? location, region, panchayat;
  AddVillageNew({super.key, this.location, this.region, this.panchayat});
  AddVillageController controller = Get.put(AddVillageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Village',
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space.height(15),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MySize.size95,
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
                            text: region,
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
                            text: panchayat,
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
          Space.height(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Text(
              "Check whether the village is already added?",
              style: AppStyle.textStyleBoldMed(fontSize: 14),
            ),
          ),
          Space.height(11),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 21.5, vertical: 10),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff008CD3).withOpacity(0.15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.villages!.length,
                  itemBuilder: (context, index) {
                    return Text(
                      "${index + 1}.  ${controller.villages![index]['villageName']}  (${controller.villages![index]['villageCode']}) ",
                      style: AppStyle.textStyleInterMed(
                        fontSize: 14,
                        color: Color(0xff181818).withOpacity(0.7),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Space.height(12),
          GestureDetector(onTap: () {
             Get.to(AddPName(panchayat: panchayat,location: location,region: region,));
          },
            child: commonButton(
                title: "Add New",
                color: Color(0xff27528F)),
          )
        ],
      ),
    ));
  }

}


class AddPName extends StatefulWidget {

  String? location, region, panchayat;

  AddPName({super.key,this.panchayat,this.region,this.location});

  @override
  _AddPNameState createState() => _AddPNameState();
}


class _AddPNameState extends State<AddPName> {

  AddVillageController controller = Get.put(AddVillageController());
  AddVillageApiService addVillageApiService = new AddVillageApiService();
  String? validationResult;
  String? villageNameValue;
  String? villageCodeValue;

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
              'Add Village',
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
          body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.height(15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MySize.size95,
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
                                text: widget.region,
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
                          text: 'Panchayat: ',
                          style: AppStyle.textStyleBoldMed(
                              fontSize: 14, color: Color(0xff006838)),
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.panchayat,
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
              Space.height(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  onChanged: (value) {
                    controller.villageNameValue = value;

                    setState(() {
                      villageNameValue = value;
                    });

                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Village Name",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              ),
              Space.height(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: TextFormField(
                  onChanged: (value) {
                    controller.villageCodeValue = value;

                    setState(() {
                      villageCodeValue = value;
                    });

                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Village Code",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                  ),
                ),
              ),
              Space.height(30),
              GestureDetector(onTap: () async {

                String? validationresult = await validateAndShowDialog(context);

                if (villageNameValue!.isEmpty || villageCodeValue!.isEmpty) {
                  validationresult = "Please fill complete name and code";
                }

                if (validationresult == null) {
                  // If validation passes, show the confirmation dialog

                  String addVillageRespMessage = await addVillageApiService.addVillage(controller.selectPanchayatId ?? 0, controller.villageNameValue ?? "", controller.villageCodeValue ?? "");

                  if (addVillageRespMessage == 'Data Added')
                    showConfirmationDialog(context);
                  else
                    validationresult = addVillageRespMessage;
                } else {
                  // Handle validation failure, show an error message or take appropriate action
                  print('Validation failed: $validationresult');
                }
                setState(() {
                  validationResult = validationresult;
                });

              },
                child: commonButton(
                    title: "Add Village",
                    color: villageNameValue != null && villageCodeValue != null
                        ? Color(0xff27528F)
                        : Color(0xff27528F).withOpacity(0.7)),
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

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 91),
          child: AlertDialog(
            backgroundColor: Colors.white,
            alignment: Alignment.topCenter,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 338,
              child: Column(
                children: [
                  Space.height(16),

                  Image.asset(ImageConstant.check_circle,height: 50,width: 50,),
                  Space.height(18),
                  SizedBox(
                    width: MySize.size296,
                    child: Text(
                        '${controller.villageNameValue} is added successfully. What do you wish to do next? Add another Village Save and Close',
                        style: AppStyle.textStyleInterMed(fontSize: 16)),
                  ),
                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                      Get.to(AddVillageView(
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
                          "Add another Village",
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

  Future<String?> validateAndShowDialog(BuildContext context) async {
    // Additional validation logic here

    if (await performValidation() == 'Code Data Found') {
      // If validation passes, show the confirmation dialog
      return "The village code must Be unique For the region";

    }
    else if (await performValidation() == 'Name Data Found') {

      return "The village name must Be unique For the region";

    }
    else {
      // Handle validation failure, show an error message or take appropriate action
      // return Text('No clusters available');
      return null;
    }

  }

  Future<String> performValidation() async {
    // Your validation logic here
    // Example: Check if fields are not empty, perform API validation, etc.
    // Return true if validation passes, false otherwise

    print('performValidation ${controller.selectPanchayatId} , ${controller.villageNameValue} , ${controller.villageCodeValue}');
    Future<String> message = addVillageApiService.validateDuplicateVillage(controller.selectPanchayatId ?? 0, controller.villageNameValue ?? "", controller.villageCodeValue ?? "");

    return message;
  }



}
