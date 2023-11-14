import 'package:dalmia/pages/vdf/intervention/Enterdetail.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String interventionname = '';

class Details extends StatefulWidget {
  final String? interventionname;

  const Details({
    super.key,
    this.interventionname,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map<String, dynamic>? interventionData;

  Future<void> fetchInterventionData() async {
    final apiUrl =
        '$base/get-intervention?interventionName=Mushroom%20a%202x2%20level%20roof';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final respBody = jsonResponse['resp_body'];

      setState(() {
        interventionData = respBody;
      });
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
            backgroundColor: Colors.grey[50],
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).pop();
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details of Intervention -  1',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Lever',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 100,
                      ),
                      Text(interventionData!['lever'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Expected additional income p/a',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Rs. ${interventionData!['expectedIncomeGeneration']}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('No. of days required to complete the intervention',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        '${interventionData!['requiredDaysCompletion']} Days',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColorTheme.primaryColor,
                          minimumSize: const Size(350, 50),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EnterDetail(),
                            ),
                          );
                        },
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // Your onPressed action
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
