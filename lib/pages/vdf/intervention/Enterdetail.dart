import 'package:dalmia/pages/vdf/intervention/Followup.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Add Intervention',
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
                Text('Enter Details'),
                SizedBox(
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
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
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Any remarks about this household?',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Followup(),
                          ),
                        );
                      },
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
