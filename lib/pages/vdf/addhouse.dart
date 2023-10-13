import 'package:dalmia/pages/vdf/addfamily.dart';
import 'package:flutter/material.dart';

class Panchayat {
  final String id;
  final String name;

  Panchayat(this.id, this.name);
}

class Village {
  final String id;
  final String name;

  Village(this.id, this.name);
}

class Street {
  final String id;
  final String name;

  Street(this.id, this.name);
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPanchayat;
  String? _selectedVillage;
  String? _selectedStreet;

  List<Panchayat> panchayats = [
    Panchayat('1', 'Panchayat 1'),
    Panchayat('2', 'Panchayat 2'),
    Panchayat('3', 'Panchayat 3')
  ];
  List<Village> villages = [
    Village('1', 'Village 1'),
    Village('2', 'Village 2'),
    Village('3', 'Village 3')
  ];
  List<Street> streets = [
    Street('1', 'Street 1'),
    Street('2', 'Street 2'),
    Street('3', 'Street 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Add Household',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90),
                        child: Icon(Icons.close),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100.0),
                        child: Text(
                          'Select Panchayat, Village & Street',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedPanchayat,
                        items: panchayats.map((Panchayat panchayat) {
                          return DropdownMenuItem<String>(
                            value: panchayat.id,
                            child: Text(panchayat.name),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPanchayat = newValue;
                            _selectedVillage = null;
                            _selectedStreet = null;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select a Panchayat',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field 1 is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedVillage,
                        items: villages.map((Village village) {
                          return DropdownMenuItem<String>(
                            value: village.id,
                            child: Text(village.name),
                          );
                        }).toList(),
                        onChanged: _selectedPanchayat != null
                            ? (String? newValue) {
                                setState(() {
                                  _selectedVillage = newValue;
                                  _selectedStreet = null;
                                });
                              }
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Select a Village',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (_selectedPanchayat == null ||
                              value == null ||
                              value.isEmpty) {
                            return 'Field 2 is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedStreet,
                        items: streets.map((Street street) {
                          return DropdownMenuItem<String>(
                            value: street.id,
                            child: Text(street.name),
                          );
                        }).toList(),
                        onChanged: _selectedVillage != null
                            ? (String? newValue) {
                                setState(() {
                                  _selectedStreet = newValue;
                                });
                              }
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Select a Street',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (_selectedVillage == null ||
                              value == null ||
                              value.isEmpty) {
                            return 'Field 3 is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                          backgroundColor: _selectedPanchayat != null &&
                                  _selectedVillage != null &&
                                  _selectedStreet != null
                              ? Colors.blue[900]
                              : Colors.blue[100],
                        ),
                        onPressed: _selectedPanchayat != null &&
                                _selectedVillage != null &&
                                _selectedStreet != null
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // All fields are valid, you can process the data
                                  // Perform actions with the field values

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddFamily(),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
