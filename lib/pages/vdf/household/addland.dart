import 'dart:convert';

import 'package:dalmia/pages/vdf/household/addcrops.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddLand extends StatefulWidget {
  final String? id;

  const AddLand({Key? key, this.id}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddLand> {
  String selectedRainfed = "-1";
  String selectedIrrigated = "-1";
  List<DropdownOption>? rainfedOptions;
  List<DropdownOption>? irrigatedOptions;

  @override
  void initState() {
    super.initState();
    fetchRainfedOptions().then((options) {
      setState(() {
        rainfedOptions = options;
      });
    });
    fetchIrrigatedOptions().then((options) {
      setState(() {
        irrigatedOptions = options;
      });
    });
  }

  void updateRainfedSelection(String dataId) {
    setState(() {
      selectedRainfed = dataId;
    });
  }

  void updateIrrigatedSelection(String dataId) {
    setState(() {
      selectedIrrigated = dataId;
    });
  }

  Future<void> addlandData() async {
    final apiUrl = '$base/add-household';

    // Replace these values with the actual data you want to send
    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "irrigated_land": selectedIrrigated,
      "rainfed_land": selectedRainfed,
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
        print("Land Data added successfully");
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

  Future<List<DropdownOption>> fetchRainfedOptions() async {
    final apiUrl = '$base/dropdown?titleId=112';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body)['resp_body']['options'] as List<dynamic>;
        return responseData
            .map((option) => DropdownOption.fromJson(option))
            .toList();
      } else {
        throw Exception(
            'Failed to load rainfed options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<DropdownOption>> fetchIrrigatedOptions() async {
    final apiUrl = '$base/dropdown?titleId=113';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body)['resp_body']['options'] as List<dynamic>;
        return responseData
            .map((option) => DropdownOption.fromJson(option))
            .toList();
      } else {
        throw Exception(
            'Failed to load irrigated options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Land Ownership Details',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Rainfed',
                      style: TextStyle(
                        color: Color(0xFF181818).withOpacity(0.80),
                        fontSize: CustomFontTheme.textSize,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          if (rainfedOptions != null)
                            for (var option in rainfedOptions!)
                              InputDetail(
                                option,
                                selectedRainfed,
                                updateRainfedSelection,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Irrigated',
                      style: TextStyle(
                        color: Color(0xFF181818).withOpacity(0.80),
                        fontSize: CustomFontTheme.textSize,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          if (irrigatedOptions != null)
                            for (var option in irrigatedOptions!)
                              InputDetail(
                                option,
                                selectedIrrigated,
                                updateIrrigatedSelection,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
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
                        // Call the function to add household data
                        addlandData();

                        // Navigate to the next screen if needed
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddCrop(
                              id: widget.id,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.labelwt,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(130, 50),
                        side: BorderSide(
                          color: CustomColorTheme.primaryColor,
                          width: 1,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Perform actions with the field values

                        // Save as draft
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
      ),
    );
  }
}

class DropdownOption {
  final String dataId;
  final String titleId;
  final String titleData;
  final String toShow;

  DropdownOption(this.dataId, this.titleId, this.titleData, this.toShow);

  factory DropdownOption.fromJson(Map<String, dynamic> json) {
    return DropdownOption(
      json['dataId'].toString(),
      json['titleId'].toString(),
      json['titleData'].toString(),
      json['toShow'].toString(),
    );
  }
}

class InputDetail extends StatelessWidget {
  final DropdownOption acre;
  final String selectedOptionDataId;
  final Function(String) updateSelection;

  const InputDetail(
    this.acre,
    this.selectedOptionDataId,
    this.updateSelection, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        updateSelection(acre.dataId);
        // Call the function to fetch the titleId based on the selected acre
        // fetchTitleId(acre).then((dataId) {
        //   print("hellllo $dataId");
        //   updateSelection(acre, dataId.toString());
        // });
      },
      style: ElevatedButton.styleFrom(
        side: selectedOptionDataId == acre.dataId
            ? BorderSide(width: 1, color: CustomColorTheme.iconColor)
            : BorderSide(width: 1, color: Color(0x99181818)),
        elevation: 0,
        minimumSize: const Size(85, 38),
        backgroundColor: selectedOptionDataId == acre.dataId
            ? const Color(0xFFF15A22)
            : Colors.white,
      ),
      child: Text(
        acre.titleData,
        style: TextStyle(
          color: selectedOptionDataId == acre.dataId
              ? Colors.white
              : Color(0xFF181818),
        ),
      ),
    );
  }

  Future<int> fetchTitleId(String acre) async {
    // Fetch the dataId based on the selected acre
    final apiUrl = '$base/dropdown?titleId=${acre == 'Rainfed' ? 112 : 113}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body)['resp_body'] as Map<int, dynamic>;

        // Check if the dataId is present and not null
        final dataId = responseData['dataId'];
        if (dataId != null && dataId is int) {
          print('DataId: $dataId');
          return dataId;
        } else {
          print('DataId is null or not a String in the response');
          return 0;
        }
      } else {
        print('Failed to load dataId: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 0;
      }
    } catch (e) {
      print('Error fetching dataId: $e');
      return 0;
    }
  }
}
