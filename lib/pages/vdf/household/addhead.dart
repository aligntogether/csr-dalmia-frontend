import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addfamily.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';

import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AddHead extends StatefulWidget {
  const AddHead({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddHead> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  List<dynamic> genderOptions = [];
  String? _selectedEducation;
  List<dynamic> educationOptions = [];
  List<dynamic> primaryEmploymentOptions = [];
  List<dynamic> secondaryEmploymentOptions = [];

  String? _selectedCaste;
  List<dynamic> casteOptions = [];
  String? _selectedPrimaryEmployment;
  String? _selectedSecondaryEmployment;
  bool _validateFields = false;
  // List<String> genderOptions = ['Male', 'Female'];
  // List<String> educationOptions = [
  //   'Option 1',
  //   'Option 2',
  //   'Option 3'
  // ]; // Replace with actual options
  // List<String> casteOptions = [
  //   'Option 1',
  //   'Option 2',
  //   'Option 3'
  // ]; // Replace with actual options
  // List<String> employmentOptions = ['Option 1', 'Option 2', 'Option 3'];
  // Replace with actual options

  Future<void> fetchGenderOptions() async {
    try {
      final response = await http.get(
        Uri.parse('$base/dropdown?titleId=101'),
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];

        setState(() {
          genderOptions = options;
        });
      } else {
        throw Exception(
            'Failed to load gender options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> fetchCasteOptions() async {
    String url = '$base/dropdown?titleId=105';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];
        setState(() {
          casteOptions = options;
        });
      } else {
        throw Exception('Failed to load caste options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> fetchEducationOptions() async {
    String url = '$base/dropdown?titleId=102';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];
        setState(() {
          educationOptions = options;
        });
      } else {
        throw Exception('Failed to load caste options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> fetchPrimaryOptions() async {
    String url = '$base/dropdown?titleId=103';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];
        setState(() {
          primaryEmploymentOptions = options;
        });
      } else {
        throw Exception('Failed to load caste options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> fetchSecondaryOptions() async {
    String url = '$base/dropdown?titleId=104';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];
        setState(() {
          secondaryEmploymentOptions = options;
        });
      } else {
        throw Exception('Failed to load caste options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGenderOptions();
    fetchCasteOptions();
    fetchEducationOptions();
    fetchPrimaryOptions();
    fetchSecondaryOptions();
  }

  void saveFormDataToJson() async {
    final name = _nameController.text;
    final mobile = _mobileController.text;
    final dob = _dobController.text;

    Map<String, dynamic> headData = {
      'name': name,
      'mobile': mobile,
      'dob': dob,
      'gender': {'value': _selectedGender},
      'education': {'value': _selectedEducation},
      'caste': {'value': _selectedCaste},
      'primaryEmployment': {'value': _selectedPrimaryEmployment},
      'secondaryEmployment': {'value': _selectedSecondaryEmployment},
    };

    Map<String, dynamic> householdData = {
      'head': headData,
    };

    String jsonData = json.encode({'household': householdData});

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/form_data.json');
      await file.writeAsString(jsonData);
      print('Data saved to file successfully at: ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Head of Family',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Head Name *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Head Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Mobile Number is required';
                      } else if (value!.length != 10) {
                        return 'Mobile Number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _dobController,
                            readOnly: true, // Set the field to be read-only
                            decoration: InputDecoration(
                              labelText: 'Date of Birth *',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20.0),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: CustomColorTheme.iconColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Date of Birth is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Adjust the width here
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: selectedDate != null
                                ? '${calculateAge(selectedDate)} yrs'
                                : 'Age(yrs)',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: genderOptions
                        .map<DropdownMenuItem<String>>((dynamic gender) {
                      return DropdownMenuItem<String>(
                        value: gender['titleData'].toString(),
                        child: Text(gender['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Gender *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCaste,
                    items: casteOptions
                        .map<DropdownMenuItem<String>>((dynamic caste) {
                      return DropdownMenuItem<String>(
                        value: caste['titleData'].toString(),
                        child: Text(caste['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCaste = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Caste *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caste is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedEducation,
                    items: educationOptions
                        .map<DropdownMenuItem<String>>((dynamic education) {
                      return DropdownMenuItem<String>(
                        value: education['titleData'].toString(),
                        child: Text(education['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedEducation = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Education *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Education is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedPrimaryEmployment,
                    items: primaryEmploymentOptions
                        .map<DropdownMenuItem<String>>(
                            (dynamic primaryemployment) {
                      return DropdownMenuItem<String>(
                        value: primaryemployment['titleData'].toString(),
                        child: Text(primaryemployment['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPrimaryEmployment = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Primary Employment *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Primary Employment is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSecondaryEmployment,
                    items: secondaryEmploymentOptions
                        .map<DropdownMenuItem<String>>(
                            (dynamic secondaryemployment) {
                      return DropdownMenuItem<String>(
                        value: secondaryemployment['titleData'].toString(),
                        child:
                            Text(secondaryemployment['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSecondaryEmployment = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Secondary Employment *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Secondary Employment is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_validateFields &&
                      !(_formKey.currentState?.validate() ?? false))
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Please fill all the mandatory fields',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: CustomColorTheme.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddFamily(),
                            ),
                          );
                          setState(() {
                            _validateFields = true;
                          });
                          if (_formKey.currentState?.validate() ?? false) {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const AddFamily(),
                            //   ),
                            // );
                            // final name = _nameController.text;
                            // final mobile = _mobileController.text;
                            // final dob = _dobController.text;
                            saveFormDataToJson();
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: CustomFontTheme.textSize),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(
                              color: CustomColorTheme.primaryColor, width: 1),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // All fields are valid, you can process the data
                            final name = _nameController.text;
                            final mobile = _mobileController.text;
                            final dob = _dobController.text;

                            // Perform actions with the field values

                            // Save as draft
                          }
                        },
                        child: Text(
                          'Save as Draft',
                          style: TextStyle(
                              color: CustomColorTheme.primaryColor,
                              fontSize: CustomFontTheme.textSize),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AppBar houseappbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: const Text(
      'Add Household',
      style: TextStyle(
          color: Color(0xFF181818),
          fontSize: CustomFontTheme.headingSize,
          fontWeight: CustomFontTheme.headingwt),
    ),
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Row(
        children: [
          Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Color(0xFF181818),
          ),
          Text(
            'Back',
            style: TextStyle(
                color: Color(0xFF181818), fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
    backgroundColor: Colors.grey[50],
    actions: <Widget>[
      IconButton(
        iconSize: 30,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VdfHome(),
            ),
          );
        },
        icon: const Icon(
          Icons.close,
          color: Color(0xFF181818),
        ),
      ),
    ],
  );
}
