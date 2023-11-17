import 'dart:convert';

import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addfarm.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddStock extends StatefulWidget {
  final String? id;
  const AddStock({super.key, this.id});

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  List<bool> cropCheckList = List.filled(16, false);

  Future<void> addstockData() async {
    final apiUrl = '$base/add-household';

    // Replace these values with the actual data you want to send
    final Map<String, dynamic> requestData = {
      "id": widget.id,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          // Add any additional headers if needed
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Successful response
        print(" land Data added successfully");
        // Handle success as needed
      } else {
        // Handle error response
        print("Failed to add land data: ${response.statusCode}");
        print(response.body);
        // Handle error as needed
      }
    } catch (e) {
      // Handle network errors
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Add Livestock Numbers',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Rowstock('Cows'),
                  const SizedBox(height: 20),
                  Rowstock('Goats'),
                  const SizedBox(height: 20),
                  Rowstock('Buffalo'),
                  const SizedBox(height: 20),
                  Rowstock('Poultry'),
                  const SizedBox(height: 20),
                  Rowstock('Pigs'),
                  const SizedBox(height: 20),
                  Rowstock('Ducks'),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Others1',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    const Color(0xFF181818).withOpacity(0.80)),
                          ),
                        ),
                        const SizedBox(
                          width: 90,
                          height: 40,
                          child: TextField(
                            maxLength: 15,
                            decoration: InputDecoration(
                              label: Text('Specify'),
                              counterText: '',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType
                                .number, // Allow only numeric keyboard
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')), // Allow only digits
                            ],
                            decoration: const InputDecoration(
                              label: Text('No.'),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Others2',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    const Color(0xFF181818).withOpacity(0.80)),
                          ),
                        ),
                        const SizedBox(
                          width: 90,
                          height: 40,
                          child: TextField(
                            maxLength: 15,
                            decoration: InputDecoration(
                              counterText: '',
                              label: Text('Specify'),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType
                                .number, // Allow only numeric keyboard
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')), // Allow only digits
                            ],
                            decoration: const InputDecoration(
                              label: Text('No.'),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(130, 50),
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddFarm(id: widget.id),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.labelwt),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(130, 50),
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          color: CustomColorTheme.primaryColor, width: 1),
                    ),
                    onPressed: () {
                      // Perform actions with the field values

                      // Save as draft
                    },
                    child: const Text(
                      'Save as Draft',
                      style: TextStyle(
                          color: CustomColorTheme.primaryColor,
                          fontWeight: CustomFontTheme.labelwt,
                          fontSize: CustomFontTheme.textSize),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Rowstock(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181818).withOpacity(0.80)),
          ),
        ),
        SizedBox(
          width: 50,
          height: 30,
          child: TextField(
            keyboardType: TextInputType.number, // Allow only numeric keyboard
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Allow only digits
            ],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        )
      ],
    ),
  );
}
