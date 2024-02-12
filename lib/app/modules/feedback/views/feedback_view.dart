import 'dart:convert';

import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/app/modules/feedback/views/ceo_screen.dart';

import 'package:dalmia/app/modules/feedback/views/feedback_chat_view.dart';
import 'package:dalmia/app/modules/feedback/views/feedback_send_msg_view.dart';
import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/image_constant.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dalmia/helper/sharedpref.dart';
import 'package:intl/intl.dart';

import '../controllers/feedback_controller.dart';
import '../service/feedbackApiService.dart';

class FeedbackView extends StatefulWidget {
  FeedbackView({Key? key}) : super(key: key);

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final FeedbackApiService feedbackApiService = FeedbackApiService();
  String userId = "";

  @override
  void initState() {
    super.initState();

    getSharedPreference();
    fetchData(context);
  }

  void getSharedPreference() async {
    FeedbackController controller = Get.put(FeedbackController());

    String userIdSharedPref = await SharedPrefHelper.getSharedPref(
        USER_ID_SHAREDPREF_KEY, context, true);
    userId = userIdSharedPref;
    String userTypeSharedPref = await SharedPrefHelper.getSharedPref(
        USER_TYPE_SHAREDPREF_KEY, context, true);

    setState(() {
      controller.userId = userIdSharedPref;
      controller.userType = userTypeSharedPref;
    });

    print("userIdSharedPref: " + userIdSharedPref);
  }

  Future<List<Map<String, dynamic>>> fetchData(BuildContext context) async {
    String userIdSharedPref = await SharedPrefHelper.getSharedPref(
        USER_ID_SHAREDPREF_KEY, context, true);

    print("userIdSharedPref: " + userIdSharedPref);

    final response = await http.get(
      Uri.parse(
          'https://mobileqacloud.dalmiabharat.com:443/csr/list-feedback?userId=${userIdSharedPref}'),
      // SharedPrefHelper.storeSharedPref(
      // USER_ID_SHAREDPREF_KEY, authResponse.referenceId)
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> respBody = responseData['resp_body'];
      print('oooo body $respBody');
      // Convert the response body into a List of maps

      return respBody.entries.map((entry) {
        return {
          'name': entry.key,
          'sender_name': entry.value['sender_name'],
          'feedback_id': entry.value['feedback_id'],
          'created_at': entry.value['created_at'],
          'sender_id': entry.value['sender_id'],
          'recipient_id': entry.value['recipient_id'],
          'is_accepted': entry.value['is_accepted'],

        };
      }).toList();
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    FeedbackController controller = Get.put(FeedbackController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Feedback',
          style: AppStyle.textStyleInterMed(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.close),
          ),
          Space.width(20)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            fetchData(context);
          });
        },
        child: Column(
          children: [
            Space.height(20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final feedback = snapshot.data![index];
                        print("feedback112 $feedback");
                        return Column(
                          children: [
                            Divider(
                              height: 1,
                              color: Color(0xff181818).withOpacity(0.3),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 13),
                              child: GestureDetector(
                                onTap: () {
                                  print("dfd ${userId == feedback['recipient_id'].toString()} ${userId == feedback['recipient_id'].toString()?
                                  feedback['sender_id'].toString():
                                  feedback['recipient_id'].toString()} ${feedback['recipient_id']} $userId ${feedback['sender_id']} ");
                                  Get.to(FeedBackSendMsgView(
                                    userid: userId,
                                    recipentid: userId == feedback['recipient_id'].toString()?
                                        feedback['sender_id'].toString():
                                        feedback['recipient_id'].toString(),
                                    feedbackid:
                                        feedback['feedback_id'].toString(),
                                    name: feedback['name'],
                                    isAccepted: feedback['is_accepted'],

                                  ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      ImageConstant.feed,
                                      height: 24,
                                      width: 24,
                                    ),
                                    Space.width(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          feedback['sender_id']==userId?feedback['recipient_id']==userId?feedback['sender_name']:feedback['name']:(feedback['name'] ?? "").split("_")[0],

                                          style: AppStyle.textStyleBoldMed(
                                              fontSize: 14),
                                        ),
                                        Space.height(2),
                                        //change the date format to 18 oct or 17 jun etc
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('dd MMM').format(DateTime.parse(feedback['created_at']))
                                            ),
                                            Space.width(5),
                                            Text(
                                              "|"
                                            ),
                                            Space.width(5),

                                            Text(
                                              DateFormat('hh:mm a').format(DateTime.parse(feedback['created_at']))
                                            ),
                                            Space.width(5),
                                            Text(
                                                "|"
                                            ),
                                            Space.width(5),

                                            feedback['is_accepted']=="1"?Text(
                                              "Accepted",
                                              style: TextStyle(
                                                color: Colors.green
                                              ),
                                            ):Text(
                                              "Pending",
                                              style: TextStyle(
                                                color: Colors.red
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 22, top: 10),
                                      child: Image.asset(
                                        ImageConstant.arrowB,
                                        height: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Space.height(20),
            controller.userType != 'LL'
                ? GestureDetector(
                    onTap: () {

                      controller.userType == 'CEO'
                          ? Get.to(CEOview(
      userId: userId,
                      ))
                          : Get.to(FeedBackChatView());
                    },
                    child: commonButton(
                      title: "Send New Feedback",
                    ),
                  )
                : Container(),
            Space.height(40),
          ],
        ),
      ),
    );
  }
}
