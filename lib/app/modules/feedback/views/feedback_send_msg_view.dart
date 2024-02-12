import 'dart:convert';

import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/app/modules/feedback/service/feedbackApiService.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'feedback_view.dart';

class FeedBackSendMsgView extends StatefulWidget {
  String? regions, location, feedbackid, name, userid, recipentid, isAccepted;
  FeedBackSendMsgView({
    Key? key,
    this.regions,
    this.location,
    this.feedbackid,
    this.name,
    this.userid,
    this.recipentid,
    this.isAccepted,
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
  TextEditingController messageController = TextEditingController();

  FeedbackController feed = Get.put(FeedbackController());

  @override
  void initState() {
    super.initState();

    print("recipentid ${widget.recipentid}");
    client = StompClient(
        config: StompConfig(
            onWebSocketError: (dynamic error) => print(error.toString()),
            url: 'wss://mobileqacloud.dalmiabharat.com/csr/ws',
            onConnect: onConnect)); // StompConfig // StompClient

    print("client : $client");
    print("client userId : ${widget.userid}");
    client.activate();
    getMessage();
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

          print("bodyd : ${body}");
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
            print("feedbackInitiator : $feedbackInitiator");
            if (jsonDecode(frame.body!)['recipientId'].toString() == feedbackInitiator) {
              feed.sendMsg.value = true;
            }

            print('message received :${frame.body}');
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

    print('sent : nsjcnufy $message');
    print("messages : $messages");

    if (sent) {
      setState(() {
        messages.insert(messages.length, {
          'message': message,
          'senderId': widget.userid,
          'recipientId': widget.recipentid,
          'createdAt': DateTime.now(),
        });
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
        'https://mobileqacloud.dalmiabharat.com:443/csr/get-feedback?userId=${widget.userid}&feedbackId=${widget.feedbackid}',
      ),
    );

    print("Dsd${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['resp_body'];
      print("responseData : ${responseData}");

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
          ),
        };
      }).toList();
    } else {
      throw Exception('Failed to load feedback messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("accepted : ${feed.sendMsg.isTrue}");
    print("name : ${widget.name}");
    print(
        "widget.userid : ${widget.userid}  feedbackInitiator : $feedbackInitiator ${widget.userid == feedbackInitiator}");
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
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {

                          Get.back();
                        },
                        child: Icon(Icons.arrow_back)),
                    Container(
                        width: MySize.screenWidth*(50/MySize.screenWidth),
                      child: Text(
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          widget.name ?? '',
                          style: AppStyle.textStyleBoldMed(fontSize: 16),
                        ),
                    ),

                    Space.height(4),

                    Container(
                      width: MySize.screenWidth*(200/MySize.screenWidth),
                      child: Text(
                        "${widget.regions ?? ''} ${widget.regions != null && widget.location != null ? ',' : ''} ${widget.location ?? ''}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.textStyleInterMed(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Obx(
          () => (feed.sendMsg.isTrue && feedbackInitiator==widget.userid) || widget.isAccepted == '1'
              ? SingleChildScrollView(child: msgViewScreen(feed))
              : ListView(
                  children: [
                    msgViewScreen(feed),
                    Column(
                      children: [
                        Space.height(20),
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
                        ),
                        Space.height(18),
                        GestureDetector(
                            onTap: () async {
                              print("istrue: ${feed.sendMsg.isTrue} isFalse: ${feed.sendMsg.isFalse}  value: ${feed.sendMsg.value}");
                              setState(() {
                                controller.senderId = widget.userid;
                                controller.recipientId = widget.recipentid;
                                controller.feedbackId = widget.feedbackid;

                              });

                              bool sent = await sendMessage(latestMessage!);

                              print("\n \n bndsauyhcgv yger send kiya \n \n");

                              // feed.sendMsg.value = true;
                            },
                            child: commonButton(title: "Send", margin: 16)),
                        Space.height(40),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  getMessage() async {
    try {
      print("pop ");
      List<Map<String, dynamic>> msg = await fetchFeedbackMessages();
      print(msg);
      setState(() {
        messages = msg;

        if (msg != null && msg.isNotEmpty) {

          print("fedfsdfsd${msg[msg.length-1]['recipientId']}");
          print("ffsdf : ${widget.userid}");
          feedbackInitiator = msg[0]['feedbackInitiator'].toString() ?? '0';
          print("feedbackInitiator : $feedbackInitiator");
          print("feedbackInitiatfdfor : ${msg[msg.length-1]['recipientId'] == widget.userid}");
          if(feedbackInitiator==widget.userid && widget.isAccepted=='1')
          {
            feed.sendMsg.value = true;
          }
          else if (msg[msg.length-1]['recipientId'].toString() == widget.userid) {
            feed.sendMsg.value = true;
          }
          print("feedbackInitiatordd :  $feedbackInitiator");
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
    print("messages11 : $messages");
    messages.forEach((e) {
      list.add(Space.height(20));
      list.add(
          Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),

                ),
              ],
              borderRadius: BorderRadius.circular(9),
              color: e['senderId'].toString() == widget.userid
                  ? Color(0xffc2deec)
                  : Color.fromARGB(255, 245, 246, 246)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e['message'],
                style: AppStyle.textStyleInterMed(
                    fontSize: Get.height*(14/Get.height), color: Color(0xff181818).withOpacity(0.8)),
              ),
              Space.height(13),
              Row(
                children: [
                  Container(
                    width: MySize.screenWidth * 0.5,

                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      e['senderId'].toString() == widget.userid
                          ? "You"
                          : "${widget.name}",
                      style: AppStyle.textStyleInterMed(
                          fontSize: Get.height*(12/Get.height),
                          color: Color(0xff181818).withOpacity(0.6)),
                    ),
                  ),
                  Spacer(),
                  // date formatted as dd MMM | hh:mm a
                  Text(
                    e['createdAt'] is String
                        ? DateFormat('dd MMM | hh:mm a')
                            .format(DateTime.parse(e['createdAt']))
                        : DateFormat('dd MMM | hh:mm a').format(e['createdAt']),
                    style: AppStyle.textStyleInterMed(
                        fontSize: 12,
                        color: Color(0xff181818).withOpacity(0.6)),
                  ),
                ],
              ),
            ],
          )));
    });
    SizedBox(
      height: 20,
    );
    list.add(Obx(
      () =>feed.accept.isTrue || widget.isAccepted == '1'
          ? feedbackInitiator == widget.userid
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 36,
                      width: 207,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff129148))),
                      child: Center(
                        child: Text(
                          "You have accepted the reply",
                          style: AppStyle.textStyleBoldMed(
                              color: Color(0xff0EA301)),
                        ),
                      ),
                    ),
                    Space.height(20),
                    GestureDetector(
                      onTap: () async {
                        bool? deleteResponse =
                        await feedbackApiService.deleteFeedback(
                            int.parse(widget.userid!),
                            int.parse(widget.feedbackid!));
                        if (deleteResponse == true) {
                          feed.sendMsg.value = false;
                          feed.accept.value = false;

                          Get.back();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MySize.screenWidth * 0.7,
                        padding: EdgeInsets.symmetric(
                            horizontal: 27, vertical: 16),
                        decoration: BoxDecoration(
                            color: Color(0xff27528F),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Delete",
                            style: AppStyle.textStyleInterMed(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Space.height(20),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 36,
                      width: 207,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff129148))),
                      child: Center(
                        child: Text(
                          "Your reply has been accepted",
                          style: AppStyle.textStyleBoldMed(
                              color: Color(0xff0EA301)),
                        ),
                      ),
                    ),
                    Space.height(20),
                    // GestureDetector(
                    //   onTap: () async {
                    //     bool? deleteResponse =
                    //     await feedbackApiService.deleteFeedback(
                    //         int.parse(widget.userid!),
                    //         int.parse(widget.feedbackid!));
                    //     if (deleteResponse == true) {
                    //
                    //       Get.back();
                    //
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: MySize.screenWidth * 0.7,
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 27, vertical: 16),
                    //     decoration: BoxDecoration(
                    //         color: Color(0xff27528F),
                    //         borderRadius: BorderRadius.circular(5)),
                    //     child: Center(
                    //       child: Text(
                    //         "Delete",
                    //         style: AppStyle.textStyleInterMed(
                    //             fontSize: 14, color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Space.height(20),
                  ],
                )
          : feed.sendMsg.isTrue && feedbackInitiator==widget.userid
              ?
              Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                                onTap: () async {
                                  String? updateResponse =
                                      await feedbackApiService.updateFeedback(
                                          widget.userid!,
                                          widget.feedbackid ?? '0',
                                          1);
                                  setState(() {
                                    feed.accept.value = true;
                                  });

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
                              ),
                        Space.width(20),
                        GestureDetector(
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
                                      style:
                                          AppStyle.textStyleInterMed(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
      SizedBox(
        height: 20,
      ),
                ],
              )
              : Container(),
    ));



    return list;
  }
}
