import 'package:dalmia/pages/vdf/intervention/Financials.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/size_constant.dart';

class Followup extends StatefulWidget {
  final String? hid;
  final String? interId;
  final String? memberId;
  final TextEditingController date;
  final String? remark;

  const Followup({
    Key? key,
    this.hid,
    this.interId,
    this.memberId,
    this.remark,
    required this.date,
  }) : super(key: key);

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
  DateTime selectedDate=DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (controller == _followController1) {
          selectedDate1 = picked;
          selectedDate=picked.add(Duration(days: 1));
          _followController1.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController2) {
          if (selectedDate1 == null || picked.isBefore(selectedDate1!)) {
            showValidationError(
                context, 'Follow-up 2 date should be after Follow-up 1 date.');
            return;
          }
          selectedDate2 = picked;
          selectedDate=picked.add(Duration(days: 1));
          _followController2.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController3) {
          if (selectedDate2 == null || picked.isBefore(selectedDate2!)) {
            showValidationError(
                context, 'Follow-up 3 date should be after Follow-up 2 date.');
            return;
          }
          selectedDate3 = picked;
          selectedDate=picked.add(Duration(days: 1));
          _followController3.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController4) {
          if (selectedDate3 == null || picked.isBefore(selectedDate3!)) {
            showValidationError(
                context, 'Follow-up 4 date should be after Follow-up 3 date.');
            return;
          }
          selectedDate4 = picked;
          selectedDate=picked.add(Duration(days: 1));
          _followController4.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController5) {
          if (selectedDate4 == null || picked.isBefore(selectedDate4!)) {
            showValidationError(
                context, 'Follow-up 5 date should be after Follow-up 4 date.');
            return;
          }
          selectedDate5 = picked;
          selectedDate=picked.add(Duration(days: 1));
          _followController5.text = DateFormat('dd/MM/yyyy').format(picked);
        } else if (controller == _followController6) {
          if (selectedDate5 == null || picked.isBefore(selectedDate5!)) {
            showValidationError(
                context, 'Follow-up 6 date should be after Follow-up 5 date.');
            return;
          }
          selectedDate6 = picked;
          selectedDate=picked.add(Duration(days: 1));
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
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 1*', _followController1),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 2*', _followController2),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 3*', _followController3),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 4*', _followController4),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 5*', _followController5),
                SizedBox(
                  height: MySize.screenHeight * (20 / MySize.screenHeight),
                ),
                followdate(context, 'Followup 6*', _followController6),
                SizedBox(
                  height: MySize.screenHeight * (40 / MySize.screenHeight),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          MySize.screenWidth * 0.8,
                          MySize.screenHeight * (50 / MySize.screenHeight),
                        ),
                        backgroundColor: isButtonEnabled
                            ? Colors.blue.shade900
                            : Colors.lightBlue,
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Financial(
                              hid: widget.hid,
                              interId: widget.interId,
                              dateofcompletion: widget.date,
                              follow1: _followController1,
                              follow2: _followController2,
                              follow3: _followController3,
                              follow4: _followController4,
                              follow5: _followController5,
                              follow6: _followController6,
                            ),
                          ),
                        );
                      }
                          : null,
                      child: const Text(
                        'Continue',
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

  TextFormField followdate(BuildContext context, final String labeltext,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MySize.screenWidth * (16 / MySize.screenWidth),
          vertical: MySize.screenHeight * (20 / MySize.screenHeight),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _selectDate(context, controller);
          },
          icon: const Icon(Icons.calendar_month_outlined),
          color: CustomColorTheme.iconColor,
        ),
      ),
    );
  }

  void showValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
