import 'dart:convert';
import 'dart:io';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:http/http.dart' as http;
import 'package:dalmia/Controllers/family.dart';
import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddFamily> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> forms = [];
  int formCount = 1;

  void addMemberData() {
    Map<String, dynamic> familyData = {
      'name': _nameControllers[formCount - 1].text,
      'mobile': _mobileControllers[formCount - 1].text,
      'dob': _dobControllers[formCount - 1].text,
      'gender': _selectedGenders[formCount - 1],
      'education': _selectedEducations[formCount - 1],
      'relation': _selectedRelation[formCount - 1],
      'caste': _selectedCastes[formCount - 1],
      'primaryEmployment': _selectedPrimaryEmployments[formCount - 1],
      'secondaryEmployment': _selectedSecondaryEmployments[formCount - 1],
    };
    appendFamilyDataToJsonFile(familyData, formCount);
  }

  Map<String, dynamic> jsonData = {};
  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _mobileControllers = [];
  final List<TextEditingController> _dobControllers = [];

  final List<String?> _selectedGenders = [];
  final List<String?> _selectedEducations = [];
  final List<String?> _selectedRelation = [];
  final List<String?> _selectedCastes = [];
  final List<String?> _selectedPrimaryEmployments = [];
  final List<String?> _selectedSecondaryEmployments = [];

  List<dynamic> genderOptions = [];

  List<dynamic> educationOptions = [];
  List<dynamic> primaryEmploymentOptions = [];
  List<dynamic> secondaryEmploymentOptions = [];
  List<dynamic> relationOptions = [];

  // List<String> genderOptions = ['Male', 'Female'];
  // List<String> educationOptions = ['Option 1', 'Option 2', 'Option 3'];
  // List<String> relationOptions = ['Wife', 'Son', 'Daughter'];
  // List<String> casteOptions = ['Option 1', 'Option 2', 'Option 3'];
  // List<String> employmentOptions = ['Option 1', 'Option 2', 'Option 3'];

  List<bool> formExpandStateList = [];
  List<bool> formFilledStateList = [];

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

  Future<void> fetchRelationOptions() async {
    String url = '$base/dropdown?titleId=111';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];
        setState(() {
          relationOptions = options;
        });
      } else {
        throw Exception(
            'Failed to load relation options: ${response.statusCode}');
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
        throw Exception(
            'Failed to load Education options: ${response.statusCode}');
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
        throw Exception(
            'Failed to load Primary Education options: ${response.statusCode}');
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
        throw Exception(
            'Failed to load Secondary Education options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    formExpandStateList = List<bool>.generate(formCount, (index) => false);
    formFilledStateList = List<bool>.generate(formCount, (index) => false);
    for (int i = 0; i < formCount; i++) {
      _nameControllers.add(TextEditingController());
      _mobileControllers.add(TextEditingController());
      _dobControllers.add(TextEditingController());
      _selectedGenders.add(null);
      _selectedEducations.add(null);
      _selectedRelation.add(null);
      _selectedCastes.add(null);
      _selectedPrimaryEmployments.add(null);
      _selectedSecondaryEmployments.add(null);
    }
    fetchGenderOptions();

    fetchEducationOptions();
    fetchGenderOptions();
    fetchPrimaryOptions();
    fetchSecondaryOptions();
    fetchRelationOptions();
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dobControllers[formCount - 1].text =
            DateFormat('dd/MM/yyyy').format(picked);
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
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(
          context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Family Member',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                for (int i = 0; i < formCount; i++)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      ExpansionTile(
                        iconColor: CustomColorTheme.labelColor,
                        initiallyExpanded:
                            i == 0 ? true : formExpandStateList[i],
                        onExpansionChanged: (newState) {
                          setState(() {
                            formExpandStateList[i] = newState;
                          });
                        },
                        title: Text(
                          'Member ${i + 1}',
                          style: TextStyle(color: Color(0xFF181818)),
                        ),
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: _nameControllers[i],
                                  decoration: const InputDecoration(
                                    labelText: 'Member Name *',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  controller: _mobileControllers[i],
                                  decoration: const InputDecoration(
                                    labelText: 'Mobile Number *',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  validator: (value) {
                                    if (value!.length != 10) {
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
                                          controller: _dobControllers[i],
                                          readOnly:
                                              true, // Set the field to be read-only
                                          decoration: InputDecoration(
                                            labelText: 'Date of Birth *',
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 20.0),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                _selectDate(context);
                                              },
                                              icon: const Icon(
                                                Icons.calendar_month_outlined,
                                                color:
                                                    CustomColorTheme.iconColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 10), // Adjust the width here
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: selectedDate != null
                                              ? '${calculateAge(selectedDate)} yrs'
                                              : 'Age(yrs)',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 20.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: _selectedGenders[i],
                                  items: genderOptions
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender['titleData'].toString(),
                                      child:
                                          Text(gender['titleData'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGenders[i] = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Gender *',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: _selectedEducations[i],
                                  items: educationOptions
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic education) {
                                    return DropdownMenuItem<String>(
                                      value: education['titleData'].toString(),
                                      child: Text(
                                          education['titleData'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedEducations[i] = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Education *',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField(
                                  value: _selectedRelation[i],
                                  items: relationOptions
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic relationship) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          relationship['titleData'].toString(),
                                      child: Text(
                                          relationship['titleData'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedRelation[i] = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Add Relationship',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: _selectedPrimaryEmployments[i],
                                  items: primaryEmploymentOptions
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic primaryemployment) {
                                    return DropdownMenuItem<String>(
                                      value: primaryemployment['titleData']
                                          .toString(),
                                      child: Text(primaryemployment['titleData']
                                          .toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedPrimaryEmployments[i] = newValue;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Primary Employment *',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: _selectedSecondaryEmployments[i],
                                  items: secondaryEmploymentOptions
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic secondaryemployment) {
                                    return DropdownMenuItem<String>(
                                      value: secondaryemployment['titleData']
                                          .toString(),
                                      child: Text(
                                          secondaryemployment['titleData']
                                              .toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSecondaryEmployments[i] =
                                          newValue;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Secondary Employment',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        {
                          addMemberData();
                          setState(() {
                            formCount++;
                            formExpandStateList.add(false);
                            formFilledStateList.add(false);
                            _nameControllers.add(TextEditingController());
                            _mobileControllers.add(TextEditingController());
                            _dobControllers.add(TextEditingController());
                            _selectedGenders.add(null);
                            _selectedEducations.add(null);
                            _selectedRelation.add(null);
                            _selectedCastes.add(null);
                            _selectedPrimaryEmployments.add(null);
                            _selectedSecondaryEmployments.add(null);
                          });
                        }
                      },
                    ),
                    const Text('Add another member'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(130, 50),
                        backgroundColor: CustomColorTheme.primaryColor,
                      ),
                      onPressed: () {
                        addMemberData();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddLand(),
                          ),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          letterSpacing: 0.84,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(130, 50),
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: CustomColorTheme.primaryColor, width: 1)),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // All fields are valid, you can process the data
                          // final name = _nameController.text;
                          // final mobile = _mobileController.text;
                          // final dob = _dobController.text;

                          // Perform actions with the field values

                          // Save as draft
                        }
                      },
                      child: Text(
                        'Save as Draft',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: CustomFontTheme.textSize,
                          letterSpacing: 0.84,
                        ),
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
