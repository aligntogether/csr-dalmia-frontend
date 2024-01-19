import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Constants/constants.dart';
import '../../../helper/sharedpref.dart';

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

class Street {
  final String streetid;
  final String street;
  final String villageId;

  Street(this.streetid, this.street, this.villageId);

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      json['streetId'].toString(),
      json['streetName'].toString(),
      json['villageId'].toString(),
    );
  }
}

final String panchayatUrl = '$base/list-Panchayat';
Future<List<Panchayat>> fetchPanchayats(String vdfId) async {
  try {
    final response = await http.get(
      Uri.parse(panchayatUrl),
      headers: <String, String>{
        'vdfId': '$vdfId',
      },
    );
    if (response.statusCode == 200) {
      CommonObject commonObject =
          CommonObject.fromJson(json.decode(response.body));
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

Future<List<Street>> fetchStreets(String villageId) async {
  try {
    final response = await http.get(
      Uri.parse('$base/list-Street?villageId=$villageId'),
    );
    if (response.statusCode == 200) {
      CommonObject commonObject =
          CommonObject.fromJson(json.decode(response.body));
      Iterable list = commonObject.respBody;
      List<Street> fetchedStreets =
          List<Street>.from(list.map((model) => Street.fromJson(model)));
      print('Fetched streets: $fetchedStreets');
      return fetchedStreets;
    } else {
      throw Exception('Failed to load streets: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  List<DraftHousehold> draftHouseholds = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedPanchayat;
  String? _selectedVillage;
  String? _selectedStreet;
  String? vdfid;

  List<Panchayat> panchayats = [];
  List<Village> villages = [];
  List<Street> streets = [];

  Future<void> _addHouseholdAPI(
      String vdfid, String streetid, String ishouseholdint) async {
    final apiUrl = '$base/add-household';
    final Map<String, dynamic> requestData = {
      'street_id': streetid,
      'vdf_id': vdfid,
      'is_household_intervention': ishouseholdint,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {

        final Map<String, dynamic> responseBody = json.decode(response.body);
        print('dikh rha h $responseBody');
        final String id = responseBody['resp_body']['id'].toString();
        print('Household Created Successfully with ID: $id');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddHead(
              vdfid: '$vdfid',
              id: id,
            ),
          ),
        );
        // Return the extracted ID
      } else {
        // Handle error response
        print(
            'Failed to create household. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context, false)
        .then((value) {
      setState(() {
        vdfid = value == '' ? '10001' : value;
        print('vdfid is $vdfid');

        fetchPanchayats('$vdfid').then((value) {
          setState(() {
            panchayats = value;
            print("panchayats length is ${panchayats}");
          });
        });
      });
    });
    print("panchayats length is ${panchayats}");
    fetchDraftHouseholds().then((value) {
      setState(() {
        draftHouseholds = value;
        print('length of draft is ${draftHouseholds.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF181818)),
          centerTitle: true,
          title: const Text(
            'Add Household ',
            style: TextStyle(
                color: Color(0xFF181818),
                fontSize: CustomFontTheme.headingSize,
                fontWeight: CustomFontTheme.headingwt),
          ),
          // backgroundColor: Colors.grey[50],
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Color(0xFF181818),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(child: dropdowns(context)),
      ),
    );
  }

  Padding dropdowns(BuildContext context) {
    return Padding(
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
                      'Select Panchayat, Village & Street',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedPanchayat,
                    items: panchayats.map((Panchayat panchayat) {
                      return DropdownMenuItem<String>(
                        value: panchayat.panchayatId,
                        child: Text(
                          panchayat.panchayatName,
                          style: TextStyle(
                            color: Color(0xFF181818),
                            fontWeight:
                                _selectedPanchayat == panchayat.panchayatId
                                    ? CustomFontTheme
                                        .labelwt // FontWeight for selected item
                                    : CustomFontTheme
                                        .textwt, // FontWeight for other items
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      if (newValue != null) {
                        setState(() {
                          _selectedPanchayat = newValue;
                          _selectedVillage = null;
                          _selectedStreet = null;
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
                      labelStyle: TextStyle(color: CustomColorTheme.labelColor),
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
                        child: Text(village.village,
                            style: TextStyle(
                              fontWeight: _selectedVillage == village.villageid
                                  ? CustomFontTheme
                                      .labelwt // FontWeight for selected item
                                  : CustomFontTheme.textwt,
                              color: Color(0xFF181818),
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      if (newValue != null) {
                        setState(() {
                          _selectedVillage = newValue;
                          _selectedStreet = null;
                          fetchStreets(newValue).then((value) {
                            setState(() {
                              streets = value;
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
                      labelText: 'Select a Village',
                      labelStyle: TextStyle(color: CustomColorTheme.labelColor),
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
                  DropdownButtonFormField<String>(
                    value: _selectedStreet,
                    items: streets
                        // .where((street) =>
                        //     street.villageId == _selectedVillage)
                        .map((Street street) {
                      return DropdownMenuItem<String>(
                        value: street.streetid,
                        child: Text(street.street,
                            style: TextStyle(
                              color: Color(0xFF181818),
                              fontWeight: _selectedStreet == street.streetid
                                  ? CustomFontTheme
                                      .labelwt // FontWeight for selected item
                                  : CustomFontTheme.textwt,
                            )),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStreet = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Select a Street',
                      labelStyle: TextStyle(color: CustomColorTheme.labelColor),
                    ),
                    validator: (value) {
                      if (_selectedVillage == null ||
                          value == null ||
                          value.isEmpty) {
                        return 'Street is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: _selectedPanchayat != null &&
                              _selectedVillage != null &&
                              _selectedStreet != null
                          ? CustomColorTheme.primaryColor
                          : const Color.fromRGBO(39, 82, 143, 0.5),
                    ),
                    onPressed: () {
                      if (_selectedPanchayat != null &&
                          _selectedVillage != null &&
                          _selectedStreet != null) {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (draftHouseholds.length >= 5) {
                            _showConfirmationDialog(context);
                          } else {
                            _addHouseholdAPI('$vdfid', _selectedStreet!, '0');
                          }
                        }
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          alignment: Alignment.topCenter,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titlePadding: EdgeInsets.all(0),
          title: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              width: 200,
              // height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: const Text(
                        'Households already in Drafts',
                        style: TextStyle(
                          fontSize: 16,
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: SizedBox(
            width: 290,
            height: 120,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 10),
                  child: const Text(
                    'You already have 5 or more HH in the drafts section. Please edit or delete them to proceed.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 157,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // side: const BorderSide(),
                          backgroundColor: CustomColorTheme.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Draft(),
                            ),
                          );
                          // Perform actions when 'Yes' is clicked
                        },
                        child: const Text(
                          'Go to Drafts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.labelwt,
                            letterSpacing: 0.84,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<DraftHousehold>> fetchDraftHouseholds() async {
    try {
      final response = await http.get(
        Uri.parse('$base/get-draft-households'),
        headers: <String, String>{
          'vdfId': '$vdfid',
        },
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));

        List<dynamic> draftHouseholdsData =
            commonObject.respBody as List<dynamic>;
        List<DraftHousehold> draftHouseholds = draftHouseholdsData
            .map((model) =>
                DraftHousehold.fromJson(model as Map<String, dynamic>))
            .toList();

        return draftHouseholds;
      } else {
        throw Exception('Failed to load panchayats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
