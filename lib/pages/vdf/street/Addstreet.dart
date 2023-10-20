// import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';

// returns 'abcdefgh'
class Panchayat {
  final String id;
  final String name;

  Panchayat(this.id, this.name);
}

class Village {
  final String id;
  final String name;
  final String panchayatId;

  Village(this.id, this.name, this.panchayatId);
}

class Street {
  final String id;
  final String name;
  final String villageId;

  Street(this.id, this.name, this.villageId);
}

class AddStreet extends StatefulWidget {
  @override
  _AddStreetState createState() => _AddStreetState();
}

class _AddStreetState extends State<AddStreet> {
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
    Village('1', 'Village 1', '1'),
    Village('2', 'Village 2', '1'),
    Village('3', 'Village 3', '1'),
    Village('4', 'Village 4', '2'),
    Village('5', 'Village 6', '2'),
    Village('6', 'Village 5', '2'),
    Village('7', 'Village 7', '3'),
    Village('8', 'Village 8', '3'),
    Village('9', 'Village 9', '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Add Street',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 100.0),
                        child: Text(
                          'Select Panchayat & Village ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Select a Panchayat',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Panchayat is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedVillage,
                        items: villages
                            .where((village) =>
                                village.panchayatId == _selectedPanchayat)
                            .map((Village village) {
                          return DropdownMenuItem<String>(
                            value: village.id,
                            child: Text(village.name),
                          );
                        }).toList(),
                        onChanged: _selectedPanchayat != null
                            ? (String? newValue) {
                                setState(() {
                                  _selectedVillage = newValue;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Select a Village',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black), // Change the color here
                          ),
                        ),
                        validator: (value) {
                          if (_selectedPanchayat == null ||
                              value == null ||
                              value.isEmpty) {
                            return 'Village is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          backgroundColor: _selectedPanchayat != null &&
                                  _selectedVillage != null
                              ? Colors.blue[900]
                              : Colors.blue[100],
                        ),
                        onPressed: _selectedPanchayat != null &&
                                _selectedVillage != null
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // All fields are valid, you can process the data
                                  // Perform actions with the field values

                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => AddHead(),
                                  //   ),
                                  // );
                                }
                              }
                            : null,
                        child: const Text('Next'),
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
