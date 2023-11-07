import 'package:dalmia/pages/vdf/intervention/Financials.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Followup extends StatefulWidget {
  @override
  _FollowupState createState() => _FollowupState();
}

class _FollowupState extends State<Followup> {
  final TextEditingController _followController1 = TextEditingController();
  final TextEditingController _followController2 = TextEditingController();
  final TextEditingController _followController3 = TextEditingController();
  final TextEditingController _followController4 = TextEditingController();
  final TextEditingController _followController5 = TextEditingController();
  final TextEditingController _followController6 = TextEditingController();

  DateTime? selectedDate1;
  DateTime? selectedDate2;
  DateTime? selectedDate3;
  DateTime? selectedDate4;
  DateTime? selectedDate5;
  DateTime? selectedDate6;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        if (controller == _followController1) {
          selectedDate1 = picked;
          _followController1.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController2) {
          selectedDate2 = picked;
          _followController2.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController3) {
          selectedDate3 = picked;
          _followController3.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController4) {
          selectedDate4 = picked;
          _followController4.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController5) {
          selectedDate5 = picked;
          _followController5.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController6) {
          selectedDate6 = picked;
          _followController6.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      });
    }
  }

  bool areFollowupDatesFilled() {
    return selectedDate1 != null &&
        selectedDate2 != null &&
        selectedDate3 != null &&
        selectedDate4 != null &&
        selectedDate5 != null &&
        selectedDate6 != null;
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = areFollowupDatesFilled();
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
                const Text('Enter Details'),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 1*', _followController1),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 2*', _followController2),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 3*', _followController3),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 4*', _followController4),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 5*', _followController5),
                const SizedBox(
                  height: 20,
                ),
                followdate(context, 'Followup 6*', _followController6),
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
                            ? Colors.blue.shade900
                            : Colors.lightBlue,
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Financial(),
                                ),
                              );
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

  TextFormField followdate(BuildContext context, final String labeltext,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: labeltext,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
        suffixIcon: IconButton(
          onPressed: () {
            _selectDate(context, controller);
          },
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ),
    );
  }
}
