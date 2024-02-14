import 'dart:convert';

import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/household/addlivestock.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

class AddCrop extends StatefulWidget {
  final String? id;
  const AddCrop({super.key, this.id});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
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

  List<DropdownOption> cropOptions = [];
  Set<String> selectedDataIds = {};

  @override
  void initState() {
    super.initState();
    fetchCropOptions();
    print("id ${widget.id}");
    getcropData(widget.id ?? '0').then(
      (crop) {
        print("tessst $crop");

        setState(() {
          print("hi");
          selectedDataIds = crop['crops'].toString().split(",").toSet();
          print(selectedDataIds);
        });
      },
    );
  }

  Future<Map<String, dynamic>> getcropData(String householdId) async {
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

  Future<void> addcropData() async {
    String a=selectedDataIds.toList().toString().removeAllWhitespace.replaceAll("[","").replaceAll("]","");
    final apiUrl = '$base/add-household';
    print("hii2${widget.id}");
    print("hii3${selectedDataIds.toList().toString().removeAllWhitespace.replaceAll("[","\"").replaceAll("]","\"")}");
    // Replace these values with the actual data you want to send
    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "crops": a
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
        print("Crop Data added successfully");
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

  Future<void> fetchCropOptions() async {
    final apiUrl = '$base/dropdown?titleId=114';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body)['resp_body']['options'] as List<dynamic>;

        setState(() {
          cropOptions = responseData
              .map((option) => DropdownOption.fromJson(option))
              .toList();
        });
      } else {
        throw Exception('Failed to load crop options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Color(0xFF181818)),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Color(0xFF181818),
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF181818)),
                )
              ],
            ),
          ),
          // backgroundColor: Colors.grey[50],
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
                color: Color(0xFF181818),
              ),
            ),
          ],
        ),
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
                  'Add Crops Details',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  'What are the crops you have cultivated in the past three years? ',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    color: Color(0xFF181818),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < cropOptions.length / 2; i++)
                        cropRow(cropOptions[i], i),
                      const SizedBox(height: 16),
                      // SizedBox(
                      //   width: 120,
                      //   height: 35,
                      //   child: TextField(
                      //     decoration: const InputDecoration(
                      //       labelText: 'Other Crop 1',
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           width: 2,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = cropOptions.length ~/ 2;
                          i < cropOptions.length;
                          i++)
                        cropRow(cropOptions[i], i),
                      const SizedBox(height: 16),
                      // const SizedBox(
                      //   width: 120,
                      //   height: 35,
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       labelText: 'Other crop 2',
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           width: 2,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(130, 50),
                      backgroundColor: CustomColorTheme.primaryColor,
                    ),
                    onPressed: () {
                      // Extract selected dataIds
                      // for (int i = 0; i < cropCheckList.length; i++) {
                      //   selectedDataIds.clear();
                      //   if (cropCheckList[i]) {
                      //     selectedDataIds.add(int.parse(cropOptions[i].dataId));
                      //   }
                      // }
                      print("getllo$selectedDataIds");
                      addcropData().then((value) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddStock(id: widget.id),
                            ),
                          ));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(130, 50),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: CustomColorTheme.primaryColor,
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      addcropData().then((value) => _savedata(context));
                    },
                    child: Text(
                      'Save as Draft',
                      style: TextStyle(
                        color: CustomColorTheme.primaryColor,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt,
                      ),
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

  Widget cropRow(DropdownOption option, int index) {
    return Row(
      children: [
        Checkbox(
          value: selectedDataIds.contains(option.dataId),
          onChanged: (value) {
            setState(() {
              print("dd$selectedDataIds");
              selectedDataIds.add(option.dataId);
            });
          },
          activeColor: CustomColorTheme.iconColor,
        ),
        Text(
          option.titleData,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedDataIds.contains(option.dataId)
                ? CustomColorTheme.iconColor
                : CustomColorTheme.labelColor,
          ),
        ),
      ],
    );
  }
}
