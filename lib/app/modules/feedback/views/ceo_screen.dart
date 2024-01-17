import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/app/modules/feedback/views/feedback_chat_view.dart';
import 'package:dalmia/app/modules/feedback/views/feedback_send_msg_view.dart';

import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/color_constant.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CEOview extends GetView<FeedbackController> {
  const CEOview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Send New Feedback',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Space.height(40),
              listData("Gram Parivartan Lead", () {
                Get.to(FeedBackSendMsgView());
              }),
              listData("Regional Head / Location Lead", () {
                Get.to(FeedBackChatView());
              }),
            ],
          ),
        ));
  }

  Widget listData(String title, Function onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Row(
            children: [
              SizedBox(
                  width: MySize.size278,
                  child: Text(
                    title,
                    style: AppStyle.textStyleInterMed(fontSize: 14),
                  )),
              Spacer(),
              Image.asset(
                ImageConstant.arrowB,
                height: 18,
              ),
            ],
          ),
        ),
        Space.height(20),
        Divider(
          height: 1,
          color: dividerColor.withOpacity(0.3),
        ),
        Space.height(20),
      ],
    );
  }
}
