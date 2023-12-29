import 'dart:convert';

import 'package:dalmia/pages/vdf/intervention/Followup.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EnterDetail extends StatefulWidget {
  @override
  _EnterDetailState createState() => _EnterDetailState();
}

class _EnterDetailState extends State<EnterDetail> {
  final TextEditingController _completeController = TextEditingController();
  String? selectedName;
  List<String> memberNames = [];
  String? selectedMemberId;
  Map<String, String> memberIdNameMap = {};

  Future<void> fetchFamilyMembers() async {
    final apiUrl = '$base/get-familymembers?householdId=1';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // print('object');
      final jsonResponse = json.decode(response.body);
      final respBody = jsonResponse['resp_body'];

      setState(() {
        memberIdNameMap = {
          for (var member in respBody)
            member['memberId'].toString(): member['memberName'].toString()
        };
      });
    }
  }

  @override
  void initState() {
    fetchFamilyMembers();
    super.initState();
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != _completeController.text) {
      setState(() {
        selectedDate = picked;
        _completeController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = selectedMemberId != null;
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
                const Text(
                  'Enter Details',
                  style: TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: selectedMemberId,
                  items: memberIdNameMap.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(memberIdNameMap[key]!),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMemberId = newValue;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select the Beneficiary *',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _completeController,
                  decoration: InputDecoration(
                    labelText: 'Date of Completion',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20.0),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                      color: CustomColorTheme.iconColor,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Date of Birth is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Any remarks about this household?',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 40,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          backgroundColor: isButtonEnabled
                              ? CustomColorTheme.primaryColor
                              : CustomColorTheme.primaryColor.withOpacity(0.5)),
                      onPressed: isButtonEnabled
                          ? () {
                              if (_completeController.text.isNotEmpty) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Followup(),
                                  ),
                                );
                              } else {
                                _successmsg(context);
                              }
                            }
                          : null,
                      child: const Text('Continue'),
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

void _successmsg(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const SizedBox(
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
                  'Intervention 1 is added successfully. What do you wish to do next?'),
            ],
          ),
        ),
        content: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: Colors.blue),
              ),
              onPressed: () {
                // Perform actions with the field values

                // Save as draft
              },
              child: const Text(
                'Add another intervention',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save and Close'),
            ),
          ],
        ),
      );
    },
  );
}
