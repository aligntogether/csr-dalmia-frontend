import 'dart:convert';
import 'dart:io';

import 'package:dalmia/Controllers/family.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
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

  List<String> genderOptions = ['Male', 'Female'];
  List<String> educationOptions = ['Option 1', 'Option 2', 'Option 3'];
  List<String> relationOptions = ['Wife', 'Son', 'Daughter'];
  List<String> casteOptions = ['Option 1', 'Option 2', 'Option 3'];
  List<String> employmentOptions = ['Option 1', 'Option 2', 'Option 3'];

  List<bool> formExpandStateList = [];
  List<bool> formFilledStateList = [];

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
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.black,
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.black),
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
                color: Colors.black,
              ),
            ),
          ],
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
                        iconColor: CustomColorTheme.iconColor,
                        initiallyExpanded: formExpandStateList[i],
                        onExpansionChanged: (newState) {
                          setState(() {
                            formExpandStateList[i] = newState;
                          });
                        },
                        title: Text(
                          'Member ${i + 1}',
                          style: TextStyle(color: Colors.black),
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
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Member Name *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Member Name is required';
                                    }
                                    return null;
                                  },
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
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Mobile Number *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 240,
                                        child: TextFormField(
                                          controller: _dobControllers[i],
                                          readOnly:
                                              true, // Set the field to be read-only
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            labelText: 'Date of Birth *',
                                            border: const OutlineInputBorder(),
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
                                          validator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Date of Birth is required';
                                            }
                                            return null;
                                          },
                                        )),
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
                                          border: OutlineInputBorder(),
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
                                DropdownButtonFormField(
                                  value: _selectedGenders[i],
                                  items: genderOptions.map((String gender) {
                                    return DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedGenders[i] = newValue as String?;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Gender *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
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
                                DropdownButtonFormField(
                                  value: _selectedEducations[i],
                                  items:
                                      educationOptions.map((String education) {
                                    return DropdownMenuItem(
                                      value: education,
                                      child: Text(education),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedEducations[i] =
                                          newValue as String?;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Education *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Education is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField(
                                  value: _selectedEducations[i],
                                  items:
                                      educationOptions.map((String education) {
                                    return DropdownMenuItem(
                                      value: education,
                                      child: Text(education),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedEducations[i] =
                                          newValue as String?;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Education *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Education is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField(
                                  value: _selectedRelation[i],
                                  items: relationOptions.map((String relation) {
                                    return DropdownMenuItem(
                                      value: relation,
                                      child: Text(relation),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedRelation[i] =
                                          newValue as String?;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Add Relationship',
                                    border: OutlineInputBorder(),
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
                                  value: _selectedCastes[i],
                                  items: casteOptions.map((String caste) {
                                    return DropdownMenuItem(
                                      value: caste,
                                      child: Text(caste),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCastes[i] = newValue as String?;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Caste *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Caste is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField(
                                  value: _selectedPrimaryEmployments[i],
                                  items: employmentOptions
                                      .map((String employment) {
                                    return DropdownMenuItem(
                                      value: employment,
                                      child: Text(employment),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedPrimaryEmployments[i] =
                                          newValue as String?;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Primary Employment *',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Primary Employment is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField(
                                  value: _selectedSecondaryEmployments[i],
                                  items: employmentOptions
                                      .map((String employment) {
                                    return DropdownMenuItem(
                                      value: employment,
                                      child: Text(employment),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSecondaryEmployments[i] =
                                          newValue as String?;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Secondary Employment',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20.0),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors
                                .grey, // Add your desired color for the line
                            thickness:
                                1, // Add the desired thickness for the line
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
                        if (_formKey.currentState?.validate() ?? false) {
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
                        backgroundColor: Colors.blue[900],
                      ),
                      onPressed: () {
                        addMemberData();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddLand(),
                          ),
                        );
                      },
                      child: const Text('Next'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
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
                        style: TextStyle(color: Colors.blue[900]),
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
