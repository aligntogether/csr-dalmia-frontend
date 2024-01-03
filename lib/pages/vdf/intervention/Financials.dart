import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/intervention/Followup.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Financial extends StatefulWidget {
  final String? hid;
  final String? interId;
  final String? memberId;
  final TextEditingController dateofcompletion;
  final String? remark;
  final TextEditingController follow1;
  final TextEditingController follow2;
  final TextEditingController follow3;
  final TextEditingController follow4;
  final TextEditingController follow5;
  final TextEditingController follow6;

  const Financial(
      {super.key,
      this.hid,
      this.interId,
      this.memberId,
      required this.dateofcompletion,
      this.remark,
      required this.follow1,
      required this.follow2,
      required this.follow3,
      required this.follow4,
      required this.follow5,
      required this.follow6});
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
  Future<void> _updateinterAPI(
      // String benificiaryId
      ) async {
    final apiUrl =
        'https://mobiledevcloud.dalmiabharat.com:443/csr/update-interventions?householdId=${widget.hid}&interventionId=${widget.interId}';
    try {
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Handle successful response
        _successmsg(context);
        print('updated successfully');
      } else {
        // Handle error response
        print('Failed to update. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
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
                  keyboardType:
                      TextInputType.number, // Allow only numeric keyboard
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                  keyboardType:
                      TextInputType.number, // Allow only numeric keyboard
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                  keyboardType:
                      TextInputType.number, // Allow only numeric keyboard
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                  keyboardType:
                      TextInputType.number, // Allow only numeric keyboard
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                            ? CustomColorTheme.primaryColor
                            : Colors.grey.shade300,
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                              _successmsg(context);
                            }
                          : null,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
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

void _successmsg(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        // canPop: false,
        child: SizedBox(
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
            content: SizedBox(
              height: 200,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      
                      elevation: 0,
                      fixedSize: Size(220, 50),
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          width: 1, color: CustomColorTheme.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Addinter(),
                        ),
                      );
                    },
                    child: const Text(
                      'Add another intervention',
                      style: TextStyle(color: CustomColorTheme.primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
        
                      backgroundColor: CustomColorTheme.primaryColor,
                      fixedSize: Size(220, 50),
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
          ),
        ),
      );
    },
  );
}
