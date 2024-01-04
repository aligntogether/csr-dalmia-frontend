import 'dart:convert';

import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:http/http.dart' as http;

import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';

import 'package:dalmia/pages/vdf/household/addland.dart';

import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddFamily extends StatefulWidget {
  final String? id;
  const AddFamily({Key? key, this.id}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddFamily> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> forms = [];
  int formCount = 1;

  Map<String, dynamic> jsonData = {};
  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _mobileControllers = [];
  final List<TextEditingController> _dobControllers = [];

  final List<int?> _selectedGenders = [];
  final List<int?> _selectedEducations = [];
  final List<int?> _selectedRelation = [];
  final List<int?> _selectedCastes = [];
  final List<int?> _selectedPrimaryEmployments = [];
  final List<int?> _selectedSecondaryEmployments = [];

  List<dynamic> genderOptions = [];

  List<dynamic> educationOptions = [];
  List<dynamic> primaryEmploymentOptions = [];
  List<dynamic> secondaryEmploymentOptions = [];
  List<dynamic> relationOptions = [];

  List<bool> formExpandStateList = [];
  List<bool> formFilledStateList = [];
  final List<String?> membersId = [];
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

  Future<List<Map<String, dynamic>>> getFamilyMembers(
      String householdId) async {
    final String apiUrl = '$base/get-familymembers?householdId=$householdId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['resp_code'] == 200 &&
            jsonResponse['resp_msg'] == 'Family Found') {
          final List<dynamic> respBody = jsonResponse['resp_body'];
          return List<Map<String, dynamic>>.from(respBody);
        } else {
          throw Exception('API Error: ${jsonResponse['resp_msg']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
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
    fetchExistingData();
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

  Future<void> sendFamilyData(List<Map<String, dynamic>> familyData) async {
    try {
      final response = await http.put(
        Uri.parse('$base/add-member?houseHoldId=${widget.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(familyData),
      );

      if (response.statusCode == 200) {
      
        // Handle the response from the API if needed
        print('Data sent successfully');
      } else {
        throw Exception('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
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
                                DropdownButtonFormField<int>(
                                  value: _selectedGenders[i],
                                  items: genderOptions
                                      .map<DropdownMenuItem<int>>(
                                          (dynamic gender) {
                                    return DropdownMenuItem<int>(
                                      value: gender['dataId'],
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
                                DropdownButtonFormField<int>(
                                  value: _selectedEducations[i],
                                  items: educationOptions
                                      .map<DropdownMenuItem<int>>(
                                          (dynamic education) {
                                    return DropdownMenuItem<int>(
                                      value: education['dataId'],
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
                                      .map<DropdownMenuItem<int>>(
                                          (dynamic relationship) {
                                    return DropdownMenuItem<int>(
                                      value: relationship['dataId'],
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
                                DropdownButtonFormField<int>(
                                  value: _selectedPrimaryEmployments[i],
                                  items: primaryEmploymentOptions
                                      .map<DropdownMenuItem<int>>(
                                          (dynamic primaryemployment) {
                                    return DropdownMenuItem<int>(
                                      value: primaryemployment['dataId'],
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
                                DropdownButtonFormField<int>(
                                  value: _selectedSecondaryEmployments[i],
                                  items: secondaryEmploymentOptions
                                      .map<DropdownMenuItem<int>>(
                                          (dynamic secondaryemployment) {
                                    return DropdownMenuItem<int>(
                                      value: secondaryemployment['dataId'],
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
                          setState(() {
                            membersId.add(null);
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
                        List<Map<String, dynamic>> familyData = [];
                        var inputFormat = DateFormat('dd/MM/yyyy');

                        var outputFormat = DateFormat('yyyy-MM-dd');
                        // Collect data for each family member
                        for (int i = 0; i < formCount; i++) {
                          familyData.add({
                            'memberId': membersId[i],
                            'memberName': _nameControllers[i].text,

                            'gender': _selectedGenders[i],
                            'mobile': _mobileControllers[i].text,
                            'dob': outputFormat.format(inputFormat.parse(
                                _dobControllers[i].text ?? "28/12/2000")),
                            'education': _selectedEducations[
                                i], // You may replace this with the actual value
                            // You may replace this with the actual value
                            'relationship': _selectedRelation[
                                i], // You may replace this with the actual value
                            'primaryEmployment': _selectedPrimaryEmployments[
                                i], // You may replace this with the actual value
                            'secondaryEmployment': _selectedSecondaryEmployments[
                                i], // You may replace this with the actual value
                            'caste': _selectedCastes[i],
                            'isFamilyHead': 0,
                            // Add other fields as needed
                          });
                        }
                        print(familyData);

                        sendFamilyData(familyData)
                            .then((value) => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddLand(
                                      id: widget.id,
                                    ),
                                  ),
                                ));

                        // Navigate to the next screen or perform other actions
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
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
                        List<Map<String, dynamic>> familyData = [];
                        var inputFormat = DateFormat('dd/MM/yyyy');

                        var outputFormat = DateFormat('yyyy-MM-dd');
                        // Collect data for each family member
                        for (int i = 0; i < formCount; i++) {
                          familyData.add({
                            'memberId': membersId[i],
                            'memberName': _nameControllers[i].text,

                            'gender': _selectedGenders[i],
                            'mobile': _mobileControllers[i].text,
                            'dob': outputFormat.format(inputFormat.parse(
                                _dobControllers[i].text ?? "28/12/2000")),
                            'education': _selectedEducations[
                                i], // You may replace this with the actual value
                            // You may replace this with the actual value
                            'relationship': _selectedRelation[
                                i], // You may replace this with the actual value
                            'primaryEmployment': _selectedPrimaryEmployments[
                                i], // You may replace this with the actual value
                            'secondaryEmployment': _selectedSecondaryEmployments[
                                i], // You may replace this with the actual value
                            'caste': _selectedCastes[i],
                            'isFamilyHead': 0,
                            // Add other fields as needed
                          });
                        }
                        print(familyData);

                        sendFamilyData(familyData)
                            .then((value) => _savedata(context));
                      },
                      child: Text(
                        'Save as Draft',
                        style: TextStyle(
                          color: CustomColorTheme.primaryColor,
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

  void _savedata(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          backgroundColor: Colors.white,
          title: SizedBox(
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
                Text('Saved Data to Draft'),
              ],
            ),
          ),
          content: SizedBox(
            height: 80,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    elevation: 0,
                    backgroundColor: CustomColorTheme.primaryColor,
                    side: const BorderSide(
                      width: 1,
                      color: CustomColorTheme.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int getHeadIndex(List<Map<String, dynamic>> familyMembers) {
    int index = 0;
    for (var element in familyMembers) {
      if (element['isFamilyHead'] == 1) {
        return index;
      }
      index++;
    }
    return 0;
  }

  void fetchExistingData() {
    getFamilyMembers(widget.id ?? '0').then(
      (familyMembers) {
        setState(() {
          formExpandStateList =
              List<bool>.generate(formCount, (index) => false);
          formFilledStateList =
              List<bool>.generate(formCount, (index) => false);
          // count = familyMembers.length;
          // formCount++;
        });
        var headIndex = getHeadIndex(familyMembers);
        print(formCount);
        print('head index is $headIndex');
        int i = -1;
        if (familyMembers.length == 0) {
          return;
        }
        formCount = 0;
        formExpandStateList.clear();
        formFilledStateList.clear();
        _nameControllers.clear();
        _mobileControllers.clear();
        _dobControllers.clear();
        _selectedGenders.clear();
        _selectedEducations.clear();
        _selectedRelation.clear();
        _selectedCastes.clear();
        _selectedPrimaryEmployments.clear();
        _selectedSecondaryEmployments.clear();
        membersId.clear();

        for (int ind = 0; ind < familyMembers.length; ind++) {
          if (ind == headIndex) {
            continue;
          }
          i++;
          print('$i  $ind');
          formExpandStateList.add(false);
          formFilledStateList.add(false);
          _nameControllers.add(TextEditingController());
          _mobileControllers.add(TextEditingController());
          _dobControllers.add(TextEditingController());
          setState(() {
            _selectedGenders.add(1001);
            _selectedEducations.add(familyMembers[ind]['education']);
            _selectedRelation.add(familyMembers[ind]['relationship']);
            _selectedCastes.add(familyMembers[ind]['caste']);
            _selectedPrimaryEmployments
                .add(familyMembers[ind]['primaryEmployment']);
            _selectedSecondaryEmployments
                .add(familyMembers[ind]['secondaryEmployment']);
          });
          membersId.add(familyMembers[ind]['memberId'].toString());
          // print('member id ${membersId[ind]}');
          print('sef');
          _nameControllers[i] =
              TextEditingController(text: familyMembers[ind]['memberName']);
          _mobileControllers[i] = TextEditingController(
              text: familyMembers[ind]['mobile'].toString());
          selectedDate = DateTime.fromMillisecondsSinceEpoch(
              familyMembers[ind]['dob'] ?? 0);
          if (selectedDate != null)
            _dobControllers[i].text =
                DateFormat('dd/MM/yyyy').format(selectedDate!);
          setState(() {
            formCount++;
          });
          print("shreyanshu $formCount");
          // _dobController =
          // _dobController = TextEditingController(
          //     text: familyMembers[headIndex]['dob'].toString());
          // _selectedGenders[i] = familyMembers[i]['gender'].toString();
          // _selectedCaste = familyMembers[headIndex]['caste']?.toString() ?? '0';
          // _selectedEducation = familyMembers[headIndex]['education'];
        }
        // _selectedCaste = familyMembers[0]['education'];

        // _selectedPrimaryEmployment =
        //     familyMembers[0]['primaryEmployment'].toString();
        // _selectedSecondaryEmployment =
        //     familyMembers[0]['secondaryEmployment'].toString();
      },
    );
  }
}
