import 'dart:convert';

import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/html.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

import '../../../../Constants/constants.dart';



class FeedBackSendMsgView extends StatefulWidget {

  String? regions, location;

  FeedBackSendMsgView({super.key, this.regions, this.location});

  @override
  _FeedBackSendMsgViewState createState() => _FeedBackSendMsgViewState();
}

class _FeedBackSendMsgViewState extends State<FeedBackSendMsgView> {
  FeedbackController controller = Get.put(FeedbackController());
  String? validationResult;
  String? userid;

  late StompClient client;
  List<types.Message> _messages = [];
  // final _user = types.User(
  // id: userid,
  // );


  @override
  void initState() {
    super.initState();
    userid = '14001';
          // SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context);

    client = StompClient(
        config: StompConfig(
            onWebSocketError: (dynamic error) => print (error.toString()),
            url: 'wss://mobiledevcloud.dalmiabharat.com/csr/ws',
              onConnect: onConnect)); // StompConfig // StompClient

      client.activate();
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }


  void onConnect (StompFrame frame) {
    client. subscribe(
        destination: '/user/${userid}/private',
        callback: (StompFrame frame) {
          final body = json.decode(frame.body!);

          print("body : ${body}");
          print("body1 : ${body['message']}");

          if (frame.body != null) {
            final textMessage = types.TextMessage(
              author: types.User(
                firstName: body['message'],
                id: body['recipientId'].toString(),
              ), // types. User
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: 'const Uuid().v4()',
              text: body['message'],
            ); // types. TextMessage
            _addMessage(textMessage);
            print('message recived :${frame.body}');
          }

        });
  }


  void _addMessage(types.Message message) {
    setState (() {
      print('nurgncguy : $message');
      _messages.insert(0, message);
    });
  }


  @override
  Widget build(BuildContext context) {
    FeedbackController feed = Get.put(FeedbackController());

    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffF2F2F2),
            appBar: PreferredSize(
                preferredSize:
                    //  isMenuOpen ? Size.fromHeight(150) :
                    Size.fromHeight(100),
                child: Container(
                  height: 75,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.1),
                          offset: Offset(0.0, 4.0), // (x, y)
                          blurRadius: 4.0,
                          spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Location Lead",
                        style: AppStyle.textStyleBoldMed(fontSize: 16),
                      ),
                      Space.height(4),
                      Text(
                        "${widget.regions}, ${widget.location}",
                        style: AppStyle.textStyleInterMed(fontSize: 16),
                      ),
                    ],
                  ),
                )),
            body: Obx(
              () => feed.sendMsg.isTrue
                  ? msgViewScreen(feed)
                  : Column(
                      children: [
                        Spacer(),
                        Container(
                          height: MySize.size56,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 4.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Space.height(18),
                        GestureDetector(
                            onTap: () {
                              feed.sendMsg.value = true;



                            },
                            child: commonButton(title: "Send", margin: 16)),
                        Space.height(40),
                      ],
                    ),
            )));
  }


  Widget msgViewScreen(FeedbackController feed) {
    return Column(
      children: [
        Space.height(20),
        Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(   boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
              borderRadius: BorderRadius.circular(9),
              color: Color(0xff008CD3).withOpacity(0.18)),
          child: Column(
            children: [
              Text(
                "Lorem ipsum dolor sit amet consectetur. Ut ultricies ac viverra interdum amet. Tellus vel viverra maecenas viverra tortor. Mauris dictumst amet arcu arcu.",
                style: AppStyle.textStyleInterMed(
                    fontSize: 14, color: Color(0xff181818).withOpacity(0.8)),
              ),
              Space.height(13),
              Row(
                children: [
                  Text(
                    "You",
                    style: AppStyle.textStyleInterMed(
                        fontSize: 12,
                        color: Color(0xff181818).withOpacity(0.6)),
                  ),
                  Spacer(),
                  Text(
                    "18 Oct | 11.00 pm",
                    style: AppStyle.textStyleInterMed(
                        fontSize: 12,
                        color: Color(0xff181818).withOpacity(0.6)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Space.height(20),
        Obx(() => feed.accept.isTrue
            ? Container(
                height: 36,width: 207,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color(0xff129148))),
                child: Center(
                  child: Text("You have accepted the reply",style: AppStyle.textStyleBoldMed(color: Color(0xff0EA301)),),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      feed.accept.value = true;
                    },
                    child: Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 27, vertical: 16),
                      decoration: BoxDecoration(
                          color: Color(0xff27528F),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Accept",
                          style: AppStyle.textStyleInterMed(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Space.width(13),
                  GestureDetector(
                    onTap: () {
                      feed.sendMsg.value = false;
                    },
                    child: Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 27, vertical: 14),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff27528F)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Reply",
                          style: AppStyle.textStyleInterMed(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        Spacer(),
        commonButton(title: "Delete Chat"),
        Space.height(40)
      ],
    );
  }
}
