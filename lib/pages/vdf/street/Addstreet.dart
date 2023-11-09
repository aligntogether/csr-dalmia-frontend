import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/street/CheckStreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String selectedPanchayat = "";
String selectedVillage = "";
String selectedVillageId = "";

class Panchayat {
  final String panchayatId;
  final String clusterId;
  final String panchayatName;

  Panchayat(this.panchayatId, this.clusterId, this.panchayatName);

  factory Panchayat.fromJson(Map<String, dynamic> json) {
    return Panchayat(
      json['panchayatId'].toString(),
      json['clusterId'].toString(),
      json['panchayatName'].toString(),
    );
  }
}

String? base = dotenv.env['BASE_URL'];

class Village {
  final String villageid;
  final String village;
  final String panchayatId;

  Village(this.villageid, this.village, this.panchayatId);

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      json['villageId'].toString(),
      json['villageName'].toString(),
      json['panchayatId'].toString(),
    );
  }
}

class AddStreet extends StatefulWidget {
  @override
  _AddStreetState createState() => _AddStreetState();
}

class _AddStreetState extends State<AddStreet> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPanchayat;
  String? _selectedVillage;

  List<Panchayat> panchayats = [];
  List<Village> villages = [];

  final String panchayatUrl = '$base/list-Panchayat';

  Future<List<Panchayat>> fetchPanchayats() async {
    try {
      final response = await http.get(
        Uri.parse(panchayatUrl),
        headers: <String, String>{
          'vdfId': '10001',
        },
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        print(commonObject.respBody);
        List<dynamic> panchayatsData = commonObject.respBody as List<dynamic>;
        List<Panchayat> panchayats = panchayatsData
            .map((model) => Panchayat.fromJson(model as Map<String, dynamic>))
            .toList();

        return panchayats;
      } else {
        throw Exception('Failed to load panchayats: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }

  Future<List<Village>> fetchVillages(String panchayatId) async {
    try {
      final response = await http.get(
        Uri.parse('$base/list-Village?panchayatId=$panchayatId'),
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));

        Iterable list = commonObject.respBody;
        List<Village> villages =
            List<Village>.from(list.map((model) => Village.fromJson(model)));
        return villages;
      } else {
        throw Exception('Failed to load villages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPanchayats().then((value) {
      setState(() {
        panchayats = value;
      });
    });
  }

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
            'Add Household',
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
                          'Select Panchayat & Village',
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
                            value: panchayat.panchayatId,
                            child: Text(panchayat.panchayatName),
                          );
                        }).toList(),
                        onChanged: (String? newValue) async {
                          if (newValue != null) {
                            setState(() {
                              _selectedPanchayat = newValue;
                              _selectedVillage = null;

                              fetchVillages(newValue).then((value) {
                                setState(() {
                                  villages = value;
                                });
                              });
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: CustomColorTheme.iconColor,
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
                            // .where((village) =>
                            //     village.panchayatId == _selectedPanchayat)
                            .map((Village village) {
                          return DropdownMenuItem<String>(
                            value: village.villageid,
                            child: Text(village.village),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedVillage = newValue;
                          });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: CustomColorTheme.iconColor,
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
                            borderSide: BorderSide(color: Colors.black),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(350, 50),
                          backgroundColor: _selectedPanchayat != null &&
                                  _selectedVillage != null
                              ? CustomColorTheme.primaryColor
                              : const Color.fromRGBO(39, 82, 143, 0.5),
                        ),
                        onPressed: _selectedPanchayat != null &&
                                _selectedVillage != null
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // All fields are valid, you can process the data
                                  // Perform actions with the field values

                                  // Retrieve the selected panchayat and village
                                  String selectedPanchayatName = panchayats
                                      .firstWhere((element) =>
                                          element.panchayatId ==
                                          _selectedPanchayat)
                                      .panchayatName;
                                  String selectedVillageName = villages
                                      .firstWhere((element) =>
                                          element.villageid == _selectedVillage)
                                      .village;
                                  String selectedVillagId = villages
                                      .firstWhere((element) =>
                                          element.villageid == _selectedVillage)
                                      .villageid;

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckStreet(
                                          selectedPanchayat:
                                              selectedPanchayatName,
                                          selectedVillage: selectedVillageName,
                                          selectedVillagId: selectedVillagId),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: const Text('Next'),
                      )
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
