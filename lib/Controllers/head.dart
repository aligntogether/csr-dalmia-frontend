import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _mobileController = TextEditingController();
final TextEditingController _dobController = TextEditingController();
String? _selectedGender;
String? _selectedEducation;
String? _selectedCaste;
String? _selectedPrimaryEmployment;
String? _selectedSecondaryEmployment;
bool _validateFields = false;

List<String> genderOptions = ['Male', 'Female'];
List<String> educationOptions = [
  'Option 1',
  'Option 2',
  'Option 3'
]; // Replace with actual options
List<String> casteOptions = [
  'Option 1',
  'Option 2',
  'Option 3'
]; // Replace with actual options
List<String> employmentOptions = ['Option 1', 'Option 2', 'Option 3'];
// Replace with actual options
void saveFormDataToJson() {
  final name = _nameController.text;
  final mobile = _mobileController.text;
  final dob = _dobController.text;

  Map<String, dynamic> headData = {
    'name': name,
    'mobile': mobile,
    'dob': dob,
    'gender': _selectedGender,
    'education': _selectedEducation,
    'caste': _selectedCaste,
    'primaryEmployment': _selectedPrimaryEmployment,
    'secondaryEmployment': _selectedSecondaryEmployment,
  };

  Map<String, dynamic> householdData = {
    'head': headData,
  };

  String jsonData = json.encode({'household': householdData});

  File('form_data.json').writeAsStringSync(jsonData);
}

DateTime? selectedDate;

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != _dobController.text) {
    setState(() {
      selectedDate = picked;
      _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    });
  }
}

void setState(Null Function() param0) {}

int calculateAge(DateTime? selectedDate) {
  if (selectedDate == null) return 0;
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - selectedDate.year;
  if (currentDate.month < selectedDate.month ||
      (currentDate.month == selectedDate.month &&
          currentDate.day < selectedDate.day)) {
    age--;
  }
  return age;
}
