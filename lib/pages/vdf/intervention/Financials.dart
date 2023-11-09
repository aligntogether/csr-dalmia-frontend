import 'package:dalmia/pages/vdf/intervention/Followup.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Financial extends StatefulWidget {
  @override
  _FinancialState createState() => _FinancialState();
}

class _FinancialState extends State<Financial> {
  final TextEditingController _beneficiaryController = TextEditingController();
  final TextEditingController _subsidyController = TextEditingController();
  final TextEditingController _loanController = TextEditingController();
  final TextEditingController _dbfController = TextEditingController();

  bool areFieldsFilled() {
    return _beneficiaryController.text.isNotEmpty &&
        _subsidyController.text.isNotEmpty &&
        _loanController.text.isNotEmpty &&
        _dbfController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = areFieldsFilled();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Assign Interventionn',
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
                const Text('Enter Intervention 1 Financials'),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _beneficiaryController,
                  decoration: const InputDecoration(
                    labelText: 'Beneficiary contribution (Rs.) *',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _subsidyController,
                  decoration: const InputDecoration(
                    labelText: 'Subsidy (Rs.) *',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _loanController,
                  decoration: const InputDecoration(
                    labelText: 'Loan (Rs.) *',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _dbfController,
                  decoration: const InputDecoration(
                    labelText: 'DBF contribution (Rs.) *',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
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
                            ? Colors.blue[900]
                            : Colors.grey.shade300,
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                              _successmsg(context);
                            }
                          : null,
                      child: const Text('Confirm'),
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
      return SizedBox(
        child: AlertDialog(
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
                onPressed: () {},
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
                  backgroundColor: CustomColorTheme.primaryColor,
                  maximumSize: const Size(250, 50),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Save and Close'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
