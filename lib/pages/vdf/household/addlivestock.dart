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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../common/size_constant.dart';
class AddStock extends StatefulWidget {
  final String? id;
  const AddStock({super.key, this.id});

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
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

  List<String> items = ["Cows", "Goats", "Buffalo", "Poultry", "Pigs", "Ducks"];
  List<bool> cropCheckList = List.filled(16, false);
  Map<String, int> livestockData = {};
  MapEntry<String, int> other1 = const MapEntry("null", 0);
  MapEntry<String, int> other2 = const MapEntry("null", 0);

  Future<void> addstockData() async {
    final apiUrl = '$base/add-household';
    if (other1.key != null || other1.key != "") {
      livestockData.addEntries([other1]);
    }
    if (other2.key != null || other2.key != "") {
      livestockData.addEntries([other2]);
    }
    // Replace these values with the actual data you want to send
    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "livestock_numbers": json.encode(livestockData),
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
        print("LiveStock Data added successfully");
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

  Future<Map<String, dynamic>> getlivestockData(String householdId) async {
    final String apiUrl = '$base/get-household?householdId=$householdId';

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['resp_code'] == 200 &&
            jsonResponse['resp_msg'] == 'Data Found') {
          final Map<String, dynamic> respBody = jsonResponse['resp_body'];
          return Map<String, dynamic>.from(respBody);
        } else {
          throw Exception('API Error: ${jsonResponse['resp_msg']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      // error.printError();
      throw Exception('Error: $error');
    }
  }

  void addData(text, value) {
    int intVal = 0;
    try {
      intVal = int.parse(value);
    } catch (e) {}
    livestockData[text] = intVal;
    print(livestockData);
  }

  @override
  void initState() {
    super.initState();
    getlivestockData(widget.id ?? '0').then((livestock) {
      print("test $livestock");
      setState(
        () {
          livestockData =
              Map<String, int>.from(jsonDecode(livestock['livestockNumbers']));
        },
      );
      print(livestockData['Cows']);
    });
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
                  Rowstock('Cows', addData, livestockData),
                  const SizedBox(height: 20),
                  Rowstock('Goats', addData, livestockData),
                  const SizedBox(height: 20),
                  Rowstock('Buffalo', addData, livestockData),
                  const SizedBox(height: 20),
                  Rowstock('Poultry', addData, livestockData),
                  const SizedBox(height: 20),
                  Rowstock('Pigs', addData, livestockData),
                  const SizedBox(height: 20),
                  Rowstock('Ducks', addData, livestockData),
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
                        SizedBox(
                          width: MySize.screenWidth*(90/MySize.screenWidth),
                          height: MySize.screenHeight*(40/MySize.screenHeight),
                          child: TextField(
                            maxLength: 15,
                            onChanged: (value) {
                              other1 = MapEntry(value, other1.value);
                            },
                            decoration: const InputDecoration(
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
                            onChanged: (value) {
                              int intVal = 0;
                              try {
                                intVal = int.parse(value);
                              } catch (e) {}
                              other1 = MapEntry(other1.key, intVal);
                            },
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
                        SizedBox(
                          width: MySize.screenWidth*(90/MySize.screenWidth),
                          height: MySize.screenHeight*(40/MySize.screenHeight),
                          child: TextField(
                            maxLength: 15,
                            onChanged: (value) {
                              other2 = MapEntry(value, other2.value);
                            },
                            decoration: const InputDecoration(
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
                            onChanged: (value) {
                              int intVal = 0;
                              try {
                                intVal = int.parse(value);
                              } catch (e) {}
                              other1 = MapEntry(other2.key, intVal);
                            },
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
                      addstockData().then((value) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddFarm(id: widget.id),
                            ),
                          ));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
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
                      addstockData().then((value) => _savedata(context));
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

  Rowstock(String text, void Function(dynamic text, dynamic value) addData,
      Map<String, int>? value) {
    TextEditingController controller = TextEditingController();

    // Set initial value when the widget is created
    if (value != null && value.containsKey(text)) {
      controller.text = value[text]?.toString() ?? '';
    }

    // Use a listener to update the text field when the underlying value changes
    controller.addListener(() {
      addData(text, controller.text);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MySize.screenWidth*(90/MySize.screenWidth),
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
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
}
