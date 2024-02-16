import 'package:dalmia/app/modules/addPanchayat/controllers/add_panchayat_controller.dart';
import 'package:dalmia/app/modules/addPanchayat/views/add_panchayat_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/gpl/gpl_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/apiService.dart';





// final AddPanchayatController controller = Get.put(AddPanchayatController());
// clustersFuture = apiService.getListOfClusters(controller.selectLocationId!);

class AddNewPView extends StatefulWidget {
  String? region, location;

  AddNewPView({super.key, this.location, this.region});

  @override
  _AddNewPViewState createState() => _AddNewPViewState();
}

class _AddNewPViewState extends State<AddNewPView> {
  final ApiService apiService = ApiService();
  late Future<Map<String, dynamic>> regionsFuture;

  @override
  void initState() {
    super.initState();
    regionsFuture = apiService.getListOfRegions();
  }

  @override
  Widget build(BuildContext context) {
    AddPanchayatController controller = Get.put(AddPanchayatController());
    return SafeArea(
        child: Scaffold(
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
          Space.height(28),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MySize.size74,
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
                  Spacer(),
                ],
              ),
            ),
          ),
          Space.height(16),
          SizedBox(
              width: MySize.size287,
              child: Text(
                "Check whether the panchayat is already added?",
                style: AppStyle.textStyleBoldMed(fontSize: 14),
              )),
          Space.height(10),
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
                  itemCount: controller.panchayats!.length,
                  itemBuilder: (context, index) {
                    return Text(
                      "${index + 1}.  ${controller.panchayats![index]['panchayatName']}  (${controller.panchayats![index]['panchayatCode']}) ",
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
          Space.height(17),
          GestureDetector(
              onTap: () {
                Get.to(AddNewPCluster(
                  region: widget.region,
                  location: widget.location,
                ));
              },
              child: commonButton(title: "Add New", color: Color(0xff27528F))),
        ],
      ),
    ));
  }
}


class AddNewPCluster extends StatefulWidget {

  String? region, location;

  AddNewPCluster({super.key, this.location, this.region});

  @override
  _AddNewPClusterState createState() => _AddNewPClusterState();
}


class _AddNewPClusterState extends State<AddNewPCluster> {

  final ApiService apiService = ApiService();
  late Future<Map<String, dynamic>> clustersFuture;
  final AddPanchayatController controller = Get.put(AddPanchayatController());
  String? validationResult;

  @override
  void initState() {
    super.initState();
    final AddPanchayatController controller = Get.put(AddPanchayatController());
    clustersFuture = apiService.getListOfClusters(controller.selectLocationId!);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          Space.height(28),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: MySize.size74,
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
                  Spacer(),
                ],
              ),
            ),
          ),

          Space.height(15),
          GetBuilder<AddPanchayatController>(
            id: "add",
            builder: (controller) {

              return FutureBuilder<Map<String, dynamic>>(
                // Assuming that getListOfRegions returns a Future<Map<String, dynamic>>
                future: clustersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('There is no cluster in this location',style: TextStyle(
                      color: Colors.red,
                    ));

                  } else {
                    Map<String, dynamic> responseData = snapshot.data ?? {};

                    if (responseData.containsKey('clusters')) {
                      List<Map<String, dynamic>> clusterOptions =
                      responseData['clusters'];

                      return CustomDropdownFormField(
                        title: "Select Cluster",
                        options: clusterOptions
                            .map((cluster) => cluster['clusterName'].toString())
                            .toList(),
                        selectedValue: controller.selectCluster,
                        onChanged: (String? newValue) async {
                          // Find the selected region and get its corresponding regionId
                          Map<String, dynamic>? selectedCluster =
                          clusterOptions.firstWhereOrNull(
                                  (cluster) => cluster['clusterName'] == newValue);

                          print('controller.selectedCluster: ${selectedCluster}');


                          if (selectedCluster != null &&
                              selectedCluster['clusterId'] != null) {
                            controller.selectClusterId =
                            selectedCluster['clusterId'];
                            controller.selectCluster = newValue;
                            controller.update(["add"]);

                            print('controller.selectedCluster: ${controller.selectClusterId}');



                          }
                        },
                      );
                    } else {
                      return Text('No clusters available');
                    }
                  }
                },
              );

            },
          ),
          Space.height(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: TextFormField(

              onChanged: (value) {
                controller.panchayatNameValue = value;
              },
              decoration: const InputDecoration(
                labelText: "Enter Panchayat Name",
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
                controller.panchayatCodeValue = value;
              },
              decoration: const InputDecoration(
                labelText: "Enter Panchayat Code",
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
              ),
            ),
          ),
          Space.height(30),
          GestureDetector(onTap: ()  async {

            String? validationresult = await validateAndShowDialog(context);

            if (validationresult == null) {
              // If validation passes, show the confirmation dialog

              String addPanchayatRespMessage = await apiService.addPanchayat(controller.selectClusterId ?? 0, controller.panchayatNameValue ?? "", controller.panchayatCodeValue ?? "");

              print("addPanchayatRespMessage : $addPanchayatRespMessage");
              print("addPanchayatRespMessage1 : ${addPanchayatRespMessage.toString()}");

              if (addPanchayatRespMessage == 'Data Added')
                showConfirmationDialog(context);
              else
                validationresult = addPanchayatRespMessage;
            } else {
              // Handle validation failure, show an error message or take appropriate action
              print('Validation failed: $validationresult');
            }
            setState(() {
              validationResult = validationresult;
            });

          },
            child: commonButton(
                title: "Add Panchayat",
                color:  (controller.panchayatNameValue != null && controller.panchayatCodeValue != null)
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


  Future<String?> validateAndShowDialog(BuildContext context) async {
    // Additional validation logic here

    if (await performValidation() == 'Code Data Found') {
      // If validation passes, show the confirmation dialog
      return "The panchayat code must Be unique For the region";

    }
    else if (await performValidation() == 'Name Data Found') {

      return "The panchayat name must Be unique For the region";

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

    print('performValidation ${controller.selectClusterId} , ${controller.panchayatNameValue} , ${controller.panchayatCodeValue}');
    Future<String> message = apiService.validateDuplicatePanchayat(controller.selectClusterId ?? 0, controller.panchayatNameValue ?? "", controller.panchayatCodeValue ?? "");

    return message;
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
                        '${controller.panchayatNameValue ?? ""} is added successfully. What do you wish to do next? Add another Panchayat Save and Close',
                        style: AppStyle.textStyleInterMed(fontSize: 16)),
                  ),
                  Space.height(30),
                  GestureDetector(
                    onTap: () {
                   Get.to(AddNewPView());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff27528F)),
                          borderRadius: BorderRadius.circular(5),
                          ),
                      child: Center(
                        child: Text(
                          "Add another Panchayat",
                          style: AppStyle.textStyleInterMed(
                              fontSize: 14, color: Color(0xff27528F)),
                        ),
                      ),
                    ),
                  ),
                  Space.height(16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GPLHomeScreen(),
                        ),
                      );
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
