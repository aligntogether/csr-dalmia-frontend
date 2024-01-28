import 'dart:convert';

import 'package:dalmia/app/modules/accounts/controllers/accountsController.dart';
import 'package:dalmia/app/modules/accounts/service/accountsService.dart';

import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/Accounts/accounthome.dart';
import 'package:dalmia/pages/Accounts/updateexpenditure.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

import '../../common/app_style.dart';

class UpdateBudget extends StatefulWidget {
  const UpdateBudget({Key? key}) : super(key: key);

  @override
  _UpdateBudgetState createState() => new _UpdateBudgetState();
}

class _UpdateBudgetState extends State<UpdateBudget> {
  // Map<String, dynamic>? clustersData;
  final AccountsService accountsService = new AccountsService();
  late Future<Map<String, dynamic>> regionsFuture;
  AccountsController controller = Get.put(AccountsController());
  // List<TextEditingController> _budgetControllers = [];
  List<TextEditingController> _budgetControllers = [];

  @override
  void initState() {
    super.initState();
    regionsFuture = accountsService.getListOfRegions(controller);
    // _budgetControllers.clear();
    controller.clustersList = null;
    controller.locationsList = null;
    controller.selectClusterId = null;
    controller.selectLocationId = null;
    controller.selectcluster = null;
    controller.selectLocation = null;
    controller.selectRegion = null;
    controller.selectRegionId = null;
    regionsFuture = accountsService.getListOfRegions(controller);
  }

  @override
  void dispose() {
    for (var controller in _budgetControllers) {
      controller.dispose();
    }

    // setState(() {
    //   controller.clustersList = null;
    //   controller.locationsList = null;
    //   controller.selectClusterId = null;
    //   controller.selectLocationId = null;
    //   controller.selectcluster = null;
    //   controller.selectLocation = null;
    //   controller.selectRegion = null;
    //   controller.selectRegionId = null;
    // });
    super.dispose();
  }

  Future<void> _updateBudget(int index, String newValue) async {
    try {
      print(
          "\n hjebf controller.clustersList![index]['clusterId'] : ${controller.clustersList![index]['clusterId']}");

      Map<String, dynamic> updateMap = controller.clustersList![index];

      if (updateMap['allocatedAmount'] != null) {
        // Handle the case where newValue is not a valid integer string
        updateMap['allocatedAmount'] = newValue;
        print("new ksdf : $newValue");
      } else {
        return;
      }
      // disable here
      // int clusterId =
      //     int.tryParse(controller.clustersList![index]['clusterId']) ?? 0;
      print("\n Idddddddddddddd : $updateMap");
      final response = await http.put(
          Uri.parse(
              'https://mobiledevcloud.dalmiabharat.com:443/csr/update-cluster-budget'),
          body: json.encode([updateMap]),
          headers: <String, String>{'Content-Type': 'application/json'});
      print("asasdf");
      if (response.statusCode == 200) {
        // Parse and handle the API response if needed
        // For example, you can check if the response contains updated data
        // and update the state accordingly

        // Assuming the API response is in JSON format
        // You might need to adjust this based on the actual response structure

        print('jsr1, $response');

        Map<String, dynamic> jsonResponse = json.decode(response.body);

        print('jsr2 : $jsonResponse');

        // Check if the response contains an error message
        if (jsonResponse.containsKey('error')) {
          // Handle API error
          print('API Error: ${jsonResponse['error']}');
          // You can display an error message or perform other error handling actions
        } else {
          // Update the state based on the API response
          setState(() {
            // Update state here, for example:
            controller.clustersList![index]['allocatedAmount'] =
                jsonResponse['updatedAmount'];
          });

          // Display success message or perform any other actions
        }
      } else {
        // Handle HTTP error
        print('HTTP Error: ${response.statusCode}');
        // You can display an error message or perform other error handling actions
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      // You can display an error message or perform other error handling actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:appBarCommon(controller, context,"",
            centerAlignText: true, title: "Reports"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AccountsHome(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_sharp,
                          ),
                          Text(
                            'Main Menu',
                            style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: CustomFontTheme.headingwt),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MySize.screenWidth*(169/MySize.screenWidth),
                      height: MySize.screenHeight*(40/MySize.screenHeight),
                      decoration: ShapeDecoration(
                        color: Color(0xFF008CD3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const UpdateExpenditure(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              'images/sendmoney.svg',
                              width: 30,
                              height: 14,
                              colorFilter: ColorFilter.mode(Colors.white,
                                  BlendMode.srcIn), // Change color to blue
                            ),
                            Text(
                              'Update Expenditure',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<AccountsController>(
                  id: "add",
                  builder: (controller) {
                    return FutureBuilder<Map<String, dynamic>>(
                      // Assuming that getListOfRegions returns a Future<Map<String, dynamic>>
                      future: regionsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          Map<String, dynamic> responseData =
                              snapshot.data ?? {};

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
                                    regionOptions.firstWhereOrNull((region) =>
                                        region['region'] == newValue);

                                // print('controller.selectedRegions: ${selectedRegion}');

                                if (selectedRegion != null &&
                                    selectedRegion['regionId'] != null) {
                                  controller.selectRegionId =
                                      selectedRegion['regionId'];
                                  controller.selectRegion = newValue;
                                  controller.update(["add"]);

                                  // Get locations based on the selected regionId
                                  Map<String, dynamic> locationsData =
                                      await accountsService.getListOfLocations(
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
                GetBuilder<AccountsController>(
                  id: "add",
                  builder: (controller) {
                    return CustomDropdownFormField(
                      title: "Select Location",
                      options: controller.locationsList != null
                          ? (controller.locationsList!
                              .map(
                                  (location) => location['location'].toString())
                              .toList())
                          : [],
                      selectedValue: controller.selectLocation,
                      onChanged: (String? newValue) async {
                        // Find the selected location and get its corresponding locationId
                        if (controller.locationsList != null) {
                          // Find the selected location object based on the 'location' property

                          // print('controller.locations: ${controller.locations}');

                          Map<String, dynamic>? selectedLocation =
                              controller.locationsList?.firstWhere((location) =>
                                  location['location'] == newValue);

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

                              print("begknv : ${controller.selectClusterId}");

                              Map<String, dynamic> clustersData =
                                  await accountsService.getListOfClusters(
                                      controller.selectLocationId!);

                              // Extract the list of locations from the returned data
                              List<Map<String, dynamic>> clusters =
                                  clustersData['clusters'];

                              print("begknv : $clusters");

                              // Update the controller with the new list of locations
                              setState(() {
                                controller.updatecluster(clusters);
                                _budgetControllers = List.generate(
                                  controller.clustersList?.length ?? 0,
                                  (index) => TextEditingController(
                                      text: controller.clustersList![index]
                                                  ['allocatedAmount'] !=
                                              null
                                          ? controller.clustersList![index]
                                                  ['allocatedAmount']
                                              .toString()
                                          : '0'),
                                );
                              });

                              controller.update(["add"]);
                            }
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text('Location',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt)),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        dividerThickness: 0,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFF008CD3),
                        ),
                        rows: List<DataRow>.generate(
                          controller.clustersList?.length ??
                              0, // clusterList Length

                          (index) => DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) {
                                return index.isOdd
                                    ? Colors.blue.shade50
                                    : Colors.white;
                              },
                            ),
                            cells: [
                              DataCell(
                                Text(
                                  controller.clustersList![index]
                                      ['clusterName'],
                                  style: const TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100, // Adjust the width as needed
                                      child: TextField(
                                        // controller: _budgetControllers[index],
                                        controller: _budgetControllers[index],
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        onChanged: (newValue) {
                                          // Call the API when the text changes
                                          _updateBudget(index, newValue);
                                        },
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .grey, // Default underline color
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .blue, // Underline color when focused
                                            ),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .grey, // Underline color when not focused
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: ()
                                    //       //  async
                                    //       {
                                    //     // await _updateBudget(index);
                                    //   },
                                    //   icon: Icon(Icons.update),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate a random number
  // int _generateRandomNumber() {
  //   return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
  // }
}
