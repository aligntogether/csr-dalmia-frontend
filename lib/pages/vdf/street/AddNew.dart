import 'dart:convert';

import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Addnew extends StatefulWidget {
  final String? village;
  final String? panchayat;
  final String? villagId;

  const Addnew({
    super.key,
    this.village,
    this.panchayat,
    this.villagId,
  });
  @override
  _AddnewState createState() => _AddnewState();
}

Future<bool> checkStreetCodeExists({
  required String? vdfId,
  required String? villageId,
  required String streetName,
  required String streetCode,
}) async {
  try {
    print('vdfid: $vdfId');
    print('villageId: $villageId');
    print('streetName: $streetName');
    print('streecode: $streetCode');
    final url = Uri.parse(
      '$base/street-code-exists?vdfId=$vdfId&villageId=$villageId&streetName=$streetName&streetCode=$streetCode',
    );

    final response = await http.get(url);
    print(json.decode(response.body));
    if (response.statusCode == 500) {
      return true;
    }
    if (response.statusCode == 200) {
      print('gv');
      final Map<String, dynamic> responseData = json.decode(response.body);

      print('gv');
      final respBody = responseData['resp_body'];
      print('gv' + respBody);

      if (respBody != null) {
        print('gv');
        return true; // If resp_body is not null, return 1
      }
    }

    return false; // If resp_body is null or there is an error, return 0
  } catch (error) {
    print('Error: $error');
    return false; // Return 0 in case of an error
  }
}

class _AddnewState extends State<Addnew> {
  String? streetName;
  String? streetCode;
  int? numberOfHouseholds;
  bool streetpresent = false;
  TextEditingController streetNameController = TextEditingController();
  TextEditingController streetCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            title: const Text(
              'Add a Street',
              style: TextStyle(
                  color: CustomColorTheme.textColor,
                  fontSize: CustomFontTheme.headingSize,
                  fontWeight: CustomFontTheme.headingwt),
            ),
            backgroundColor: Colors.grey[50],
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfHome(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF006838).withOpacity(0.1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  color: Color(0xFF006838)),
                              children: [
                                const TextSpan(
                                  text: 'Panchayat :',
                                  style: TextStyle(
                                    fontWeight: CustomFontTheme.labelwt,
                                  ),
                                ),
                                TextSpan(text: '  ${widget.panchayat} '),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  color: Color(0xFF006838)),
                              children: [
                                const TextSpan(
                                  text: 'Village:',
                                  style: TextStyle(
                                    fontWeight: CustomFontTheme.labelwt,
                                  ),
                                ),
                                TextSpan(text: '  ${widget.village}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: streetNameController,
                        onChanged: (value) {
                          setState(() {
                            streetName = value;
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                          LengthLimitingTextInputFormatter(30),
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Enter Street Name')),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: streetCodeController,
                        onChanged: (value) {
                          setState(() {
                            streetCode = value;
                            streetCode = value.toUpperCase();
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                          LengthLimitingTextInputFormatter(2),
                        ],
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Enter Street Code')),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType:
                            TextInputType.number, // Allow only numeric keyboard
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        //  keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          setState(() {
                            numberOfHouseholds = int.tryParse(value) ?? 0;
                          });
                        },

                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Enter Number of Households')),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor: streetName != null &&
                                  streetCode != null
                              ? CustomColorTheme.primaryColor
                              : CustomColorTheme.primaryColor.withOpacity(0.7)),
                      onPressed: () async {
                        print('rdg');
                        final result = await checkStreetCodeExists(
                          vdfId: '10001',
                          villageId: widget.villagId,
                          streetName: streetName!,
                          streetCode: streetCode!,
                        );
                        print(result);
                        if (result == false) {
                          if (streetName != null && streetCode != null) {
                            _addStreetAPI(
                                streetName!, numberOfHouseholds!, streetCode!);
                            _confirmbox(context, streetName!);
                          }
                        } else {
                          setState(() {
                            streetpresent = true;
                          });
                        }
                      },
                      child: const Text(
                        'Add Street',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: CustomFontTheme.textSize),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (streetpresent) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'This street name and street code are already added to the village.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            color: Color(0xFFEC2828),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Check all streets added to the village here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: CustomFontTheme.textSize,
                              color: Color(0xFFEC2828),
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _addStreetAPI(
      String streetName, int householdCount, String streetCode) async {
    final apiUrl =
        '$base/add-streets?villageId=${widget.villagId}&streetName=$streetName&householdCount=$householdCount&streetCode=$streetCode';
    try {
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Handle successful response
        print('Street added successfully');
      } else {
        // Handle error response
        print('Failed to add street. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}

void _confirmbox(BuildContext context, String streetName) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // backgroundColor: Colors.white,

        title: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  '"$streetName" is added successfully. What do you wish to do next?'),
            ],
          ),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      width: 1, color: CustomColorTheme.primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add another street in same village',
                  style: TextStyle(color: CustomColorTheme.primaryColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      width: 1, color: CustomColorTheme.primaryColor),
                ),
                onPressed: () {
                  // _addHouseholdAPI('10001', , '0');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyForm(),
                    ),
                  );
                },
                child: const Text(
                  'Add household details for this street',
                  style: TextStyle(color: CustomColorTheme.primaryColor),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  minimumSize: const Size(250, 50),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VdfHome(),
                    ),
                  );
                },
                child: const Text(
                  'Save and Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
