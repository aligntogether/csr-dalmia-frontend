// import 'dart:convert';
// import 'dart:io';

// void saveFormDataToJson() {
//     final name = _nameController.text;
//     final mobile = _mobileController.text;
//     final dob = _dobController.text;

//     Map<String, dynamic> headData = {
//       'name': name,
//       'mobile': mobile,
//       'dob': dob,
//       'gender': _selectedGender,
//       'education': _selectedEducation,
//       'caste': _selectedCaste,
//       'primaryEmployment': _selectedPrimaryEmployment,
//       'secondaryEmployment': _selectedSecondaryEmployment,
//     };

//     Map<String, dynamic> householdData = {
//       'head': headData,
//     };

//     String jsonData = json.encode({'household': householdData});

//     File('form_data.json').writeAsStringSync(jsonData);
//   }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
