import 'package:dalmia/pages/vdf/intervention/Followup.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterDetail extends StatefulWidget {
  @override
  _EnterDetailState createState() => _EnterDetailState();
}

class _EnterDetailState extends State<EnterDetail> {
  final TextEditingController _completeController = TextEditingController();
  String? selectedName;

  List<String> dummyNames = [
    'John Doe',
    'Jane Doe',
    'Michael Smith',
    'Jennifer Johnson',
    'William Davis',
    'Jessica Wilson'
  ];

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
    bool isButtonEnabled = selectedName != null;
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
                const Text('Enter Details'),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: selectedName,
                  items: dummyNames.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedName = newValue;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select the Beneficiary *',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _completeController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Date of Completion',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20.0),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
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
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: isButtonEnabled
                            ? CustomColorTheme.primaryColor
                            : Colors.lightBlue,
                      ),
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
