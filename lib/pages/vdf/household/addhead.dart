import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/vdf/household/addfamily.dart';
import 'dart:convert';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddHead extends StatefulWidget {
  final String? vdfid;

  final String? id;
  const AddHead({super.key, this.vdfid, this.id});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddHead> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  List<dynamic> genderOptions = [];
  int? _selectedEducation;
  List<dynamic> educationOptions = [];
  List<dynamic> primaryEmploymentOptions = [];
  List<dynamic> secondaryEmploymentOptions = [];

  int? _selectedCaste;
  List<dynamic> casteOptions = [];
  int? _selectedPrimaryEmployment;
  int? _selectedSecondaryEmployment;
  bool _validateFields = false;
  String? memberId;
  double height = MySize.screenHeight;
  double width = MySize.screenWidth;

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



  List<Map<String, dynamic>> familyMembers = [];
  @override
  void initState() {
    super.initState();
    fetchGenderOptions();
    fetchCasteOptions();
    fetchEducationOptions();
    fetchPrimaryOptions();


    getFamilyMembers(widget.id ?? '0').then(
      (familyMembers) {
        var headIndex = getHeadIndex(familyMembers);
        setState(() {
          if(familyMembers.length>0){
            memberId = familyMembers[headIndex]['memberId'].toString();
          }
        });
        print('head index is ${widget.id}');
        if (familyMembers.length > headIndex) {
          _nameController = TextEditingController(
              text: familyMembers[headIndex]['memberName']);
          _mobileController = TextEditingController(
              text: familyMembers[headIndex]['mobile'].toString());
          if (familyMembers[headIndex]['gender'] != null)
            _selectedGender = familyMembers[headIndex]['gender'].toString();
          // _selectedCaste = familyMembers[headIndex]['caste']?.toString() ?? '0';
          _selectedEducation = familyMembers[headIndex]['education'];
          if (familyMembers[headIndex]['primaryEmployment'] != null)
            _selectedPrimaryEmployment =
                familyMembers[headIndex]['primaryEmployment'];
          if (familyMembers[headIndex]['secondaryEmployment'] != null)
            _selectedSecondaryEmployment =
                familyMembers[headIndex]['secondaryEmployment'];
          if (familyMembers[headIndex]['caste'] != null)
            _selectedCaste = familyMembers[headIndex]['caste'];
          if (familyMembers[headIndex]['dob'] != null)
            _dobController.text = DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    familyMembers[headIndex]['dob']));
          if (familyMembers[headIndex]['dob'] != null)
            setState(() {
              selectedDate = DateTime.fromMillisecondsSinceEpoch(
                  familyMembers[headIndex]['dob']);
            });


          setState(() {

            print('member id $memberId');
          });
        }
        // _selectedCaste = familyMembers[0]['education'];


      },
    );
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

  Future<void> addMember() async {
    print("i am here");
    try {

      print('dsb ${widget.id}, memberid $memberId');
      final response = await http.put(
        Uri.parse('$base/add-member?houseHoldId=${widget.id}'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode([
          {
            'memberName': _nameController.text,
            'mobile': int.parse(_mobileController.text==''?'0':_mobileController.text)  ,
           'dob': selectedDate?.toIso8601String(),
            'gender': _selectedGender,
            'education':
                _selectedEducation, // You may replace this with the actual value
            'isFamilyHead': 1, // You may replace this with the actual value
            // You may replace this with the actual value
            'memberId': memberId,
            'primaryEducation': 0, // You may replace this with the actual value
            'relationship': 0, // You may replace this with the actual value
            'secondaryEducation':
                0, // You may replace this with the actual value
            'primaryEmployment':
                _selectedPrimaryEmployment, // You may replace this with the actual value, // You may replace this with the actual value
            'secondaryEmployment':
                _selectedSecondaryEmployment, // You may replace this with the actual value
            'caste': _selectedCaste,
            // 'relationship': 0, // You may replace this with the actual value
            // 'secondaryEmployment':
            //     _selectedSecondaryEmployment,
          }
        ]),
      );
      if (response.statusCode == 200) {
        // Handle the success response
        print('Member added successfully!');
      } else {
        throw Exception('Failed to add member: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: houseappbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MySize.screenWidth*(16/MySize.screenWidth)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MySize.screenHeight * 0.02),
                  Text(
                    'Head of Family',
                    style: TextStyle(
                      fontSize: height * 0.021,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Head Name *',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal:  MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
                    ),
                    onChanged: (value) {

                      setState(() {

                      });
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
                    ),
                    validator: (value) {
                      if (value!.length != 10) {
                        return 'Mobile Number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
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
                              contentPadding:  EdgeInsets.symmetric(
                                  horizontal: MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
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
                          ),
                        ),
                      ),
                       SizedBox(width: MySize.screenWidth*(10/MySize.screenWidth)), // Adjust the width here
                      Container(
                        width: MySize.screenWidth*(100/MySize.screenWidth),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return '';
                          //   }
                          //   return null;
                          // },
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
                  SizedBox(height: height * 0.02),
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
                    decoration: InputDecoration(
                      labelText: 'Gender *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  DropdownButtonFormField<int>(
                    value: _selectedCaste,
                    items: casteOptions
                        .map<DropdownMenuItem<int>>((dynamic caste) {
                      return DropdownMenuItem<int>(
                        value: caste['dataId'],
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
                    decoration: InputDecoration(
                      labelText: 'Caste *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<int>(
                    value: _selectedEducation,
                    items: educationOptions
                        .map<DropdownMenuItem<int>>((dynamic education) {
                      return DropdownMenuItem<int>(
                        value: education['dataId'],
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
                    decoration: InputDecoration(
                      labelText: 'Education *',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: MySize.screenWidth*(16/MySize.screenWidth), vertical: MySize.screenHeight*(20/MySize.screenHeight)),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  DropdownButtonFormField<int>(
                    value: _selectedPrimaryEmployment,
                    items: primaryEmploymentOptions.map<DropdownMenuItem<int>>(
                          (dynamic primaryemployment) {
                        return DropdownMenuItem<int>(
                          value: primaryemployment['dataId'],
                          child: Container(
                            width: width * 0.6,
                            child: Text(
                              primaryemployment['titleData'].toString(),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPrimaryEmployment = newValue;

                        // Clear secondary employment if it matches the primary employment value
                        if (_selectedSecondaryEmployment == newValue) {
                          _selectedSecondaryEmployment = null;
                        }

                        secondaryEmploymentOptions.clear();
                        secondaryEmploymentOptions.addAll(
                          primaryEmploymentOptions.where((e) => e["dataId"] != newValue),
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Primary Employment *',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MySize.screenWidth * (16 / MySize.screenWidth),
                        vertical: MySize.screenHeight * (20 / MySize.screenHeight),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  DropdownButtonFormField<int>(
                    value: _selectedSecondaryEmployment,
                    items: secondaryEmploymentOptions
                        .where((e) => e["dataId"] != _selectedPrimaryEmployment)
                        .map<DropdownMenuItem<int>>(
                          (dynamic secondaryemployment) {
                        return DropdownMenuItem<int>(
                          value: secondaryemployment['dataId'],
                          child: Container(
                            width: width * 0.6,
                            child: Text(
                              secondaryemployment['titleData'].toString(),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSecondaryEmployment = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Secondary Employment',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MySize.screenWidth * (16 / MySize.screenWidth),
                        vertical: MySize.screenHeight * (20 / MySize.screenHeight),
                      ),
                    ),
                  ),


                  SizedBox(height: height * 0.02),
                  if (_validateFields &&
                      !(_formKey.currentState?.validate() ?? false))
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Please fill all the mandatory fields',
                          style: TextStyle(
                            color: Color(0xFFEC2828),

                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize:  Size(MySize.screenWidth*(130/MySize.screenWidth), MySize.screenHeight*(50/MySize.screenHeight)),
                          backgroundColor: CustomColorTheme.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _validateFields = true;
                          });
                          if (_formKey.currentState?.validate() ?? false) {
                            addMember().then((value) =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddFamily(
                                    id: widget.id,
                                  ),
                                )));

                            // addstockData()
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: CustomFontTheme.labelwt),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
    minimumSize:  Size(MySize.screenWidth*(130/MySize.screenWidth), MySize.screenHeight*(50/MySize.screenHeight)),
                          side: BorderSide(
                              color: CustomColorTheme.primaryColor, width: 1),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          addMember().then((value) => _savedata(context));
                        },
                        child: Text(
                          'Save as Draft',
                          style: TextStyle(
                              color: CustomColorTheme.primaryColor,
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: CustomFontTheme.labelwt),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
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
                  size: MySize.screenHeight*(40/MySize.screenHeight),
                ),
                SizedBox(
                  height:  MySize.screenHeight*(20/MySize.screenHeight),
                ),
                Text('Saved Data to Draft'),
              ],
            ),
          ),
          content: SizedBox(
            height: MySize.screenHeight*(80/MySize.screenHeight),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:  Size(MySize.screenWidth*(100/MySize.screenWidth), MySize.screenHeight*(40/MySize.screenHeight)),
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
}

AppBar houseappbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
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
    // backgroundColor: Colors.grey[50],
    actions: <Widget>[
      IconButton(
        iconSize: MySize.screenHeight*(30/MySize.screenHeight),
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
