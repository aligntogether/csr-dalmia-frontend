import 'dart:convert';

import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/app/modules/feedback/service/feedbackApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class FeedBackSendMsgView extends StatefulWidget {
  String? regions, location, feedbackid, name, userid, recipentid;

  FeedBackSendMsgView({
    Key? key,
    this.regions,
    this.location,
    this.feedbackid,
    this.name,
    this.userid,
    this.recipentid,
  }) : super(key: key);

  @override
  State<FeedBackSendMsgView> createState() => _FeedBackSendMsgViewState();
}

class _FeedBackSendMsgViewState extends State<FeedBackSendMsgView> {
  var messages = [];
  late StompClient client;
  String? feedbackInitiator;
  FeedbackApiService feedbackApiService = new FeedbackApiService();
  FeedbackController controller = Get.put(FeedbackController());
  String? latestMessage;


  @override
  void initState() {
    super.initState();

    client = StompClient(
        config: StompConfig(
            onWebSocketError: (dynamic error) => print(error.toString()),
            url: 'wss://mobiledevcloud.dalmiabharat.com/csr/ws',
            onConnect: onConnect)); // StompConfig // StompClient

    print("client : $client");
    print("client userId : ${widget.userid}");
    client.activate();
  }

  @override
  void dispose() {
    client.deactivate();
    super.dispose();
  }

  void onConnect(StompFrame frame) {
    client.subscribe(
        destination: '/user/${widget.userid}/private',
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
            _addMessage(body);
            print('message recived :${frame.body}');
          }

        });
  }


  void _addMessage(message) {
    setState(() {
      print('nurgncguy : $message');
      messages.insert(messages.length, message);
    });
  }

  Future<bool> sendMessage(String message) async {

    if (client == null && !client.connected) return false;

    bool sent =
        await feedbackApiService.sendFeedback(client, message, controller);

    print('sent : nsjcnufy $sent');

    if (sent) {
      setState(() {
        messages.insert(messages.length, 'message sent ......');
      });
      print('\n \n message sent ...... \n \n ');
      return sent;
    } else {
      print("\n \n Lag gaye ...... \n \n");
      return sent;
    }

  }





  Future<List<Map<String, dynamic>>> fetchFeedbackMessages() async {
    // int useid = userid as int;
    // int feedid = feedbackid as int;
    final response = await http.get(
      Uri.parse(
        'https://mobiledevcloud.dalmiabharat.com:443/csr/get-feedback?userId=${widget.userid}&feedbackId=${widget.feedbackid}',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['resp_body'];
      return responseData.map((data) {
        return {
          'id': data['id'],
          'feedbackId': data['feedbackId'],
          'message': data['message'],
          'accepted': data['accepted'],
          'senderId': data['senderId'],
          'recipientId': data['recipientId'],
          'feedbackInitiator': data['feedbackInitiator'],
          'createdAt': DateTime(
            data['createdAt'][0],
            data['createdAt'][1],
            data['createdAt'][2],
            data['createdAt'][3],
            data['createdAt'][4],
            data['createdAt'][5],
          ),
        };
      }).toList();
    } else {
      throw Exception('Failed to load feedback messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    getMessage();
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
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back)),
                      Text(
                        widget.name ?? '',
                        style: AppStyle.textStyleBoldMed(fontSize: 16),
                      ),
                      Space.height(4),
                      Text(
                        "${widget.regions ?? ''} ${widget.regions != null && widget.location != null ? ',' : ''} ${widget.location ?? ''}",
                        style: AppStyle.textStyleInterMed(fontSize: 16),
                      ),
                    ],
                  ),
                )),
            body: Obx(
              () => feed.sendMsg.isTrue
                  ? msgViewScreen(feed)
                  : ListView(
                      children: [
                        msgViewScreen(feed),
                        Spacer(),
                        feed.sendMsg.value == false
                            ? Container(
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
                                  onChanged: (value) {
                                    setState(() {
                                      latestMessage = value;
                                    });
                                  },
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
                              )
                            : Container(),
                        Space.height(18),
                        feed.sendMsg.isTrue == false
                            ? GestureDetector(
                                onTap: () async {

                                  setState(() {
                                    controller.senderId = widget.userid;
                                    controller.recipientId = widget.recipentid;
                                    controller.feedbackId = widget.feedbackid;
                                  });

                                  bool sent = await sendMessage(latestMessage!);

                                  print(
                                      "\n \n bndsauyhcgv yger send kiya \n \n");
                                  // feed.sendMsg.value = true;
                                },
                                child: commonButton(title: "Send", margin: 16))
                            : Container(),
                        Space.height(40),
                      ],
                    ),
            )));
  }

  getMessage() async {
    try {
      List<Map<String, dynamic>> msg = await fetchFeedbackMessages();
      setState(() {
        messages = msg;
        if (msg != null && msg.isNotEmpty) {
          feedbackInitiator = msg[0]['feedbackInitiator'].toString() ?? '0';
          print("feedbackInitiator :  $feedbackInitiator");
        }

      });
      // print('msg : $msg');
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching feedback messages: $e');
    }
  }

  Widget msgViewScreen(FeedbackController feed) {
    return Column(children: loadElements(feed));
  }

  loadElements(FeedbackController feed) {
    List<Widget> list = [];
    messages.forEach((e) {
      list.add(Space.height(20));
      list.add(Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(4, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(9),
              color: e['senderId'].toString() == widget.userid
                  ? Color(0xff008CD3).withOpacity(0.18)
                  : Color.fromARGB(255, 245, 246, 246).withOpacity(0.18)),
          child: Column(
            children: [
              Text(
                e['message'],
                style: AppStyle.textStyleInterMed(
                    fontSize: 14, color: Color(0xff181818).withOpacity(0.8)),
              ),
              Space.height(13),
              Row(
                children: [
                  Text(
                    e['senderId'].toString() == widget.userid
                        ? "You"
                        : "${widget.name}",
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
          )));
    });
    list.add(Obx(() => feed.accept.isTrue
        ? Container(
            height: 36,
            width: 207,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xff129148))),
            child: Center(
              child: Text(
                "You have accepted the reply",
                style: AppStyle.textStyleBoldMed(color: Color(0xff0EA301)),
              ),
            ),
          )
            :
            // (widget.userid! == feedbackInitiator) ?
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  feed.sendMsg.isTrue
                      ? GestureDetector(
                          onTap: () async {

                            String? updateResponse =
                                await feedbackApiService.updateFeedback(
                                    widget.userid!,
                                    controller.feedbackId ?? '0',
                                    '1');

                            if (updateResponse != null) {
                              setState(() {
                                feed.accept.value = true;
                              });
                            }

                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 27, vertical: 16),
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
                        )
                      : Container(),
                  Space.width(13),
                  feed.sendMsg.isTrue
                      ? GestureDetector(
                          onTap: () {
                            feed.sendMsg.value = false;
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 27, vertical: 14),
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
                        )
                      : Container()
                ],
              )
        // : Row()
        ));
    return list;
  }
}
