import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/app/modules/feedback/views/feedback_send_msg_view.dart';
import 'package:dalmia/common/app_bar.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/dropdown_filed.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBackChatView extends StatelessWidget {
  const FeedBackChatView({super.key});

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
            id: "feed",
            builder: (controller) {
              return CustomDropdownFormField(
                  title: "Select Region",
                  options: [
                    "South & Chandrapur",
                    "Sugar",
                    "East",
                    "North East",
                    "All Regions"
                  ],
                  selectedValue: controller.selectRegion,
                  onChanged: (String? newValue) async {
                    controller.selectRegion = newValue;
                    controller.update(["feed"]);
                  });
            },
          ),
          Space.height(15),
          GetBuilder<FeedbackController>(
            id: "feed",
            builder: (controller) {
              return CustomDropdownFormField(
                  title: "Select Location",
                  options: [
                    "South & Chandrapur",
                    "Sugar",
                    "East",
                    "North East",
                  ],
                  selectedValue: controller.selectLocation,
                  onChanged: (String? newValue) async {
                    controller.selectLocation = newValue;
                    controller.update(["feed"]);
                  });
            },
          ),
          Space.height(36),
          GetBuilder<FeedbackController>(
            id: "feed",
            builder: (controller) {
              return GestureDetector(
                  onTap: () {
                    if (controller.selectLocation != null &&
                        controller.selectRegion != null) {
                      Get.to(FeedBackSendMsgView(
                        location: controller.selectLocation,
                        regions: controller.selectRegion,
                      ));
                    }
                  },
                  child: commonButton(
                      title: "Send Feedback",
                      color: controller.selectLocation != null &&
                              controller.selectRegion != null
                          ? Color(0xff27528F)
                          : Color(0xff27528F).withOpacity(0.7)));
            },
          )
        ],
      ),
    ));
  }
}
