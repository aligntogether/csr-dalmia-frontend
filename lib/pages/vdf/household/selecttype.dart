import 'dart:convert';

import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/approval.dart';
import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectType extends StatefulWidget {
  final String? id;
  const SelectType({Key? key, this.id}) : super(key: key);

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  void _savedata(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          backgroundColor: Colors.white,
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
                Text('Saved Data to Draft'),
              ],
            ),
          ),
          content: SizedBox(
            height: 80,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    elevation: 0,
                    backgroundColor: CustomColorTheme.primaryColor,
                    side: const BorderSide(
                      width: 1,
                      color: CustomColorTheme.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int? pakka = null;
  int? kuccha = null;
  int? tiled = null;

  @override
  void initState() {
    super.initState();
    fetchExistingData();
  }

  Future<void> addhouse(int value) async {
    final apiUrl = '$base/add-household';

    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "is_household_intervention": value,
      "is_draft": 0
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
        print("successfull");
        // Handle success as needed
      } else {
        // Handle error response
        print("Failed to add data: ${response.statusCode}");
        print(response.body);
        // Handle error as needed
      }
    } catch (e) {
      // Handle network errors
      print("Error: $e");
    }
  }

  List<bool> cropCheckList = List.filled(16, false);
  bool ownChecked = false;
  bool rentedChecked = false;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
              const Text(
                  'Would you like to enroll this household for intervention?'),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    elevation: 0,
                    backgroundColor: CustomColorTheme.primaryColor),
                onPressed: () {
                  addhouse(1);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Addinter(
                        id: widget.id,
                      ),
                    ),
                  );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.labelwt),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      width: 1, color: CustomColorTheme.primaryColor),
                ),
                onPressed: () {
                  addhouse(0);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Approval(
                        id: widget.id,
                      ),
                    ),
                  );
                  // Perform actions when 'No' is clicked
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.labelwt,
                    color: CustomColorTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select House Type',
                  style: TextStyle(
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.headingwt),
                ),
                const SizedBox(height: 20),
                RadioListTile(
                  value: true,
                  groupValue: ownChecked,
                  onChanged: (value) {
                    setState(() {
                      ownChecked = value as bool;
                      if (value) rentedChecked = false;
                    });
                  },
                  title: Text(
                    'Own',
                    style: TextStyle(
                        fontWeight: CustomFontTheme.labelwt,
                        color: ownChecked
                            ? CustomColorTheme.iconColor
                            : CustomColorTheme.labelColor),
                  ),
                  activeColor: CustomColorTheme.iconColor,
                  // Define the active color for the radio button
                  selectedTileColor: CustomColorTheme.iconColor,
                ),
                Divider(
                  color: CustomColorTheme
                      .labelColor, // Add your desired color for the line
                  thickness: 1, // Add the desired thickness for the line
                ),
                if (ownChecked) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Fill at least one choice(',
                    style: TextStyle(
                        color: Color(0xFF181818).withOpacity(0.70),
                        fontSize: 14,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Rowst(
                          'Pakka',
                          (value) => setState(() {
                                print(value);
                                if (value == "")
                                  pakka = null;
                                else
                                  pakka = int.tryParse(value!);
                              }),
                          pakka.toString()),
                      const SizedBox(height: 20),
                      Rowst(
                          'Titled',
                          (value) => setState(() {
                                if (value == "")
                                  tiled = null;
                                else
                                  tiled = int.tryParse(value!);
                              }),
                          tiled.toString()),
                      const SizedBox(height: 20),
                      Rowst(
                          'Kutcha',
                          (value) => setState(() {
                                if (value == "")
                                  kuccha = null;
                                else
                                  kuccha = int.tryParse(value!);
                              }),
                          kuccha.toString()),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                RadioListTile(
                  value: true,
                  groupValue: rentedChecked,
                  onChanged: (value) {
                    setState(() {
                      rentedChecked = value as bool;
                      if (value) ownChecked = false;
                    });
                  },
                  title: Text(
                    'Rented',
                    style: TextStyle(
                        fontWeight: CustomFontTheme.labelwt,
                        color: rentedChecked
                            ? CustomColorTheme.iconColor
                            : CustomColorTheme.labelColor),
                  ),
                  activeColor: CustomColorTheme
                      .iconColor, // Define the active color for the radio button
                  selectedTileColor: CustomColorTheme.iconColor,
                ),
                Divider(
                  color: CustomColorTheme
                      .labelColor, // Add your desired color for the line
                  thickness: 1, // Add the desired thickness for the line
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Any remarks about this household?',
                      labelStyle: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        color: CustomColorTheme.labelColor,
                      ),
                      alignLabelWithHint: true),
                  maxLines:
                      3, // Adjust the number of lines as per your requirement
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(130, 50),
                        backgroundColor: Colors.blue[900],
                      ),
                      onPressed: () {
                        saveData()
                            .then((value) => _showConfirmationDialog(context));
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: CustomFontTheme.labelwt,
                            fontSize: CustomFontTheme.textSize),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(130, 50),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: CustomColorTheme.primaryColor,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        saveData().then((value) => _savedata(context));
                      },
                      child: Text(
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
      ),
    );
  }

  void fetchExistingData() {
    getFamilyMembers(widget.id ?? '0').then((house) {
      if (house['houseType'] != null) {
        if (house['houseType'] == 1023) {
          setState(() {
            ownChecked = true;
          });
        } else {
          setState(() {
            rentedChecked = true;
          });
        }
      }
      if (house['houseConstruction'] != null) {
        try {
          final Map<String, dynamic> hosueConstruction =
              json.decode(house['houseConstruction']);
          setState(() {
            pakka = hosueConstruction['pakka'];
            tiled = hosueConstruction['tiled'];
            kuccha = hosueConstruction['kutcha'];
          });
        } catch (e) {}
      }
    });
  }

  Future<Map<String, dynamic>> getFamilyMembers(String householdId) async {
    final String apiUrl = '$base/get-household?householdId=$householdId';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['resp_code'] == 200 &&
            jsonResponse['resp_msg'] == 'Data Found') {
          final dynamic respBody = jsonResponse['resp_body'];
          return Map<String, dynamic>.from(respBody);
        } else {
          throw Exception('API Error: ${jsonResponse['resp_msg']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> saveData() async {
    final apiUrl = '$base/add-household';

    // Replace these values with the actual data you want to send
    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "house_type": ownChecked
          ? 1023
          : 1024, // correct this theseids should be fetched from backend
      "house_construction": ownChecked
          ? json.encode({"pakka": pakka, "tiled": tiled, "kutcha": kuccha})
          : "",
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
        print("selected type successfully");
        // Handle success as needed
      } else {
        // Handle error response
        print("Failed to add  data: ${response.statusCode}");
        print(response.body);
        // Handle error as needed
      }
    } catch (e) {
      // Handle network errors
      print("Error: $e");
    }
  }
}

Widget Rowst(String text, void Function(String?) callback, String? value) {
  if (value.toString() == "null") value = "";
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF181818).withOpacity(0.70),
        ),
      ),
      SizedBox(
        width: 45,
        height: 30,
        child: TextFormField(
          initialValue: value.toString(),
          keyboardType: TextInputType.number,

          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
              ),
            ),
          ),
        ),
      )
    ],
  );
}
