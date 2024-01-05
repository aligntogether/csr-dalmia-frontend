import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/app/modules/feedback/service/feedbackApiService.dart';
import 'package:dalmia/app/modules/feedback/views/feedback_send_msg_view.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Constants/constants.dart';
import '../../../../helper/sharedpref.dart';



class FeedBackChatView extends StatefulWidget {

  FeedBackChatView({super.key});

  @override
  _FeedBackChatViewState createState() => _FeedBackChatViewState();
}

class _FeedBackChatViewState extends State<FeedBackChatView> {
  final FeedbackApiService feedbackApiService = FeedbackApiService();
  FeedbackController controller = Get.put(FeedbackController());
  late Future<Map<String, dynamic>> regionsFuture;
  bool sendButtonEnabled = false;
  int? recipientId;


  @override
  void initState() {
    super.initState();
    regionsFuture = feedbackApiService.getListOfRegions();
    getSharedPreference();
  }

  void getSharedPreference() async {

    FeedbackController controller = Get.put(FeedbackController());

    String userIdSharedPref = await SharedPrefHelper.getSharedPref(
        USER_ID_SHAREDPREF_KEY, context, true);

    String userTypeSharedPref = await SharedPrefHelper.getSharedPref(
        USER_TYPE_SHAREDPREF_KEY, context, true);

    setState(() {
      controller.userId = userIdSharedPref;
      controller.userType = userTypeSharedPref;
    });

    print("userIdSharedPref: " + userIdSharedPref);

  }

  void changeColourSendButton() {

    if (controller.userType == 'GPL' || controller.userType == 'CEO') {

      if (controller.selectRegion != null || controller.selectLocation != null) {
        sendButtonEnabled = true;
      }

    }

    if (controller.userType == 'RH') {

      if (controller.selectRegion != null && controller.selectLocation != null) {
        sendButtonEnabled = true;
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    FeedbackController feed = Get.put(FeedbackController());
    return SafeArea(
        child: Scaffold(
      appBar: commonAppBarWidget(title: "Send New Feedback"),
      body: Column(
        children: [
          Space.height(20),
          GetBuilder<FeedbackController>(
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
                            await feedbackApiService.getListOfLocations(
                                controller.selectRegionId!);

                            // Extract the list of locations from the returned data
                            List<Map<String, dynamic>> locations =
                            locationsData['locations'];


                            print("locations : $locations");

                            // Update the controller with the new list of locations
                            setState(() {
                              recipientId = selectedRegion['rhId'];
                              print("rhId  : $recipientId");
                              controller.updateLocations(locations);
                            });

                            controller.update(["add"]);

                            changeColourSendButton();

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

          GetBuilder<FeedbackController>(
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

                      String? selectedLocationLead =
                      selectedLocation['locationLead'];

                      // print('selectedLocationId: $selectedLocationId');

                      if (selectedLocationId != null) {
                        // Assign 'location' to controller.selectLocation
                        setState(() {
                          controller.selectLocation =
                          selectedLocation['location'] as String;
                          controller.selectLocationId = selectedLocationId;
                          controller.selectLocationLead = int.tryParse(selectedLocationLead!);
                          recipientId = int.tryParse(selectedLocationLead!);
                          print("rhId  : $recipientId");
                          });

                        changeColourSendButton();

                        controller.update(["add"]);
                      }
                    }
                  }
                },
              );
            },
          ),


          Space.height(36),
          GetBuilder<FeedbackController>(
            id: "feed",
            builder: (controller) {
              return GestureDetector(
                  onTap: () async {
                    if (sendButtonEnabled) {

                      print("controller.userId : ${controller.userId}");
                      print("controller.userId : ${recipientId}");

                      Map<String, String>? addFeedbackRes = await feedbackApiService.addFeedback(int.tryParse(controller.userId!)! , recipientId ?? 0);

                      if (addFeedbackRes != null) {

                        setState(() {
                          recipientId = 0;
                          controller.feedbackId = addFeedbackRes['feedbackId'];
                          controller.senderId = addFeedbackRes['senderId'];
                          controller.recipientId = addFeedbackRes['recipientId'];
                        });

                      }
                      String? name = null;

                      if (controller.selectRegion != null) {
                        if (controller.selectLocation != null) {
                            name = 'Location Lead';
                        }
                        else {
                          name = 'Regional Head';
                        }

                      }


                      if (addFeedbackRes != null) {
                        Get.to(FeedBackSendMsgView(
                          location: controller.selectLocation,
                          regions: controller.selectRegion,
                          feedbackid : controller.feedbackId,
                          name : name,
                          userid : controller.userId,
                          recipentid : controller.recipientId,
                        ));
                      }
                      else {
                        print("Something went wrong !");
                      }

                    }
                  },
                  child: commonButton(
                      title: "Send Feedback",
                      color: sendButtonEnabled
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)));
            },
          )
        ],
      ),
    ));
  }
}
