import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/intervention/Enterdetail.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'dart:convert';

import '../../../common/size_constant.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);
String interventionname = '';

class Details extends StatefulWidget {
  final String? interventionname;
  final String? hid;
  final String? interId;

  const Details({super.key, this.interventionname, this.hid, this.interId});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map<String, dynamic>? interventionData;

  Future<void> fetchInterventionData() async {
    final apiUrl =
        '$base/get-intervention?interventionName=${widget.interventionname}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final respBody = jsonResponse['resp_body'];

      setState(() {
        interventionData = respBody;
      });
    }
  }

  Future<void> assignIntervention(
      String householdId, String interventionId) async {
    print(householdId + " " + interventionId);
    final String baseUrl = '$base/assign-interventions';
    final String apiUrl =
        '$baseUrl?householdId=$householdId&interventionId=$interventionId';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EnterDetail(hid: widget.hid, interId: widget.interId),
          ),
        );

        // Handle the response from the API as needed
        print('API Response: $jsonResponse');
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EnterDetail(hid: widget.hid, interId: widget.interId),
          ),
        );
        // Handle API error
        print('Failed to call API: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors, such as network issues
      print('Error: $error');
    }
  }

  @override
  void initState() {
    fetchInterventionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (interventionData != null) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            title: const Text(
              'Assign Intervention',
              style: TextStyle(color: Colors.black),
            ),
            // backgroundColor: Colors.grey[50],
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                onPressed: () {

                  _confirmitem(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left:MySize.screenHeight*(30/MySize.screenHeight),right:MySize.screenHeight*(30/MySize.screenHeight),top:MySize.screenHeight*(20/MySize.screenHeight)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Details of Intervention',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   Text(
                      interventionData!['interventionName'].toString(),
                      style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lever',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      Container(
                          width: MySize.screenWidth * (110 / MySize.screenWidth),
                          child: Text(interventionData!['lever'].toString())),
                    ],
                  ),
                  SizedBox(
                    height: MySize.screenHeight*(10/MySize.screenHeight),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MySize.screenWidth * (150 / MySize.screenWidth),
                        child: Text('Expected Additional Income P/A',
                            style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        width: MySize.screenWidth * (110 / MySize.screenWidth),
                        child: Text(
                          'Rs. ${interventionData!['expectedIncomeGeneration']}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MySize.screenHeight*(10/MySize.screenHeight),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MySize.screenWidth * (150 / MySize.screenWidth),
                        child: Text(
                            'No. Of Days Required \nTo Complete The Intervention',
                            style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        width: MySize.screenWidth * (110 / MySize.screenWidth),
                        child: Text(

                          '${interventionData!['requiredDaysCompletion']} Days',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MySize.screenHeight*(40/MySize.screenHeight),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColorTheme.primaryColor,
                          minimumSize: const Size(350, 50),
                        ),
                        onPressed: () {
                          assignIntervention(widget.hid!, widget.interId!);
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Addinter(
                                id: widget.hid,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Change Intervention ',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

void _confirmitem(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Center(
         child:
            Container(

              child: Text(
                'Are you sure you want to cancel assigning intervention?',
                style: TextStyle(
                  fontSize: MySize.screenWidth * (16 /MySize.screenWidth),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )

        ),
        content: SizedBox(
          height: MySize.screenHeight * (180 / MySize.screenHeight),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  fixedSize: Size(MySize.screenWidth*(250/MySize.screenWidth), 60),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfHome(),
                    ),
                  );
                },
                child: Text(
                  'Yes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ), SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  fixedSize: Size(MySize.screenWidth*(250/MySize.screenWidth), 60),
                  backgroundColor:Colors.white,
                  shadowColor: Colors.black,


                ),

                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColorTheme.textColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      );
    },
  );
}
