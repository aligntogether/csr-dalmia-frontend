import 'package:dalmia/pages/vdf/household/addfamily.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHead extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddHead> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  String? _selectedEducation;
  String? _selectedCaste;
  String? _selectedPrimaryEmployment;
  String? _selectedSecondaryEmployment;

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
  List<String> employmentOptions = [
    'Option 1',
    'Option 2',
    'Option 3'
  ]; // Replace with actual options
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dobController.text) {
      setState(() {
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        _dobController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Add Household',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyForm(),
                ),
              );
            },
            child: Row(
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
                    builder: (context) => VdfHome(),
                  ),
                );
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Head of Family',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Head Name *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Head Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Mobile Number *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Mobile Number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Date of Birth *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate(context);
                          // Add your date picker functionality here
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Date of Birth is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedGender,
                    items: genderOptions.map((String gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue as String?;
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Gender *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedEducation,
                    items: educationOptions.map((String education) {
                      return DropdownMenuItem(
                        value: education,
                        child: Text(education),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedEducation = newValue as String?;
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Education *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Education is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedCaste,
                    items: casteOptions.map((String caste) {
                      return DropdownMenuItem(
                        value: caste,
                        child: Text(caste),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCaste = newValue as String?;
                      });
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Caste *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caste is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedPrimaryEmployment,
                    items: employmentOptions.map((String employment) {
                      return DropdownMenuItem(
                        value: employment,
                        child: Text(employment),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPrimaryEmployment = newValue as String?;
                      });
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Primary Employment *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Primary Employment is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedSecondaryEmployment,
                    items: employmentOptions.map((String employment) {
                      return DropdownMenuItem(
                        value: employment,
                        child: Text(employment),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSecondaryEmployment = newValue as String?;
                      });
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Secondary Employment',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddFamily(),
                            ),
                          );
                          if (_formKey.currentState?.validate() ?? false) {
                            // All fields are valid, you can process the data
                            final name = _nameController.text;
                            final mobile = _mobileController.text;
                            final dob = _dobController.text;

                            // Perform actions with the field values
                            print('Head Name: $name');
                            print('Mobile Number: $mobile');
                            print('Date of Birth: $dob');
                            print('Gender: $_selectedGender');
                            print('Education: $_selectedEducation');
                            print('Caste: $_selectedCaste');
                            print(
                                'Primary Employment: $_selectedPrimaryEmployment');
                            print(
                                'Secondary Employment: $_selectedSecondaryEmployment');

                            // Navigate to the next page
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => NextPage(),
                            //   ),
                            // );
                          }
                        },
                        child: Text('Next'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // All fields are valid, you can process the data
                            final name = _nameController.text;
                            final mobile = _mobileController.text;
                            final dob = _dobController.text;

                            // Perform actions with the field values
                            print('Head Name: $name');
                            print('Mobile Number: $mobile');
                            print('Date of Birth: $dob');
                            print('Gender: $_selectedGender');
                            print('Education: $_selectedEducation');
                            print('Caste: $_selectedCaste');
                            print(
                                'Primary Employment: $_selectedPrimaryEmployment');
                            print(
                                'Secondary Employment: $_selectedSecondaryEmployment');

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
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
