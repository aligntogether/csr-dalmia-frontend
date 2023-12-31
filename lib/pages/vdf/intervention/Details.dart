import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/intervention/Enterdetail.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
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
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      interventionData!['interventionName'].toString(),
                      style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Lever',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      Text(interventionData!['lever'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Expected additional income p/a',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      Text(
                        'Rs. ${interventionData!['expectedIncomeGeneration']}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          'No. of days required \n to complete the intervention',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: FontWeight.w600)),
                      Text(
                        '${interventionData!['requiredDaysCompletion']} Days',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
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
                              builder: (context) => Addinter(),
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('What do you wish to do next?'),
          ],
        ),
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfHome(),
                    ),
                  );
                },
                child: Text(
                  'Save HH as draft and add intervention later ',
                  style: TextStyle(color: CustomColorTheme.primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColorTheme.primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Continue adding Intervention'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
