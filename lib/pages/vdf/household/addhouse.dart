import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

// class CommonObject {
//   final String respCode;
//   final String respMsg;
//   final dynamic respBody;

//   CommonObject(this.respCode, this.respMsg, this.respBody);

//   factory CommonObject.fromJson(Map<String, dynamic> json) {
//     return CommonObject(
//       json['resp_code'].toString(),
//       json['resp_msg'].toString(),
//       json['resp_body'],
//     );
//   }
// }

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

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPanchayat;
  String? _selectedVillage;
  String? _selectedStreet;

  List<Panchayat> panchayats = [];
  List<Village> villages = [];
  List<Street> streets = [];

  final String panchayatUrl = 'http://192.168.1.71:8080/list-Panchayat';

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
        // print("asdfasdf" + commonObject.respBody);
        // Iterable list = json.decode(commonObject.respBody)[0];
        // List<Panchayat> panchayats = List<Panchayat>.from(
        //     list.map((model) => Panchayat.fromJson(model)));
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
        Uri.parse(
            'http://192.168.1.71:8080/list-Village?panchayatId=$panchayatId'),
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
        Uri.parse('http://192.168.1.71:8080/list-Street?villageId=$villageId'),
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
                          'Select Panchayat, Village & Street',
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
                      DropdownButtonFormField<String>(
                        value: _selectedStreet,
                        items: streets
                            // .where((street) =>
                            //     street.villageId == _selectedVillage)
                            .map((Street street) {
                          return DropdownMenuItem<String>(
                            value: street.streetid,
                            child: Text(street.street),
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
                              ? Colors.blue[900]
                              : Colors.blue[100],
                        ),
                        onPressed: _selectedPanchayat != null &&
                                _selectedVillage != null &&
                                _selectedStreet != null
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddHead(),
                                    ),
                                  );
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

// import 'package:dalmia/pages/vdf/household/addhead.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// // import 'package:flutter_config/flutter_config.dart';

// // returns 'abcdefgh'
// class Panchayat {
//   final String id;
//   final String name;

//   Panchayat(this.id, this.name);
// }

// class Village {
//   final String id;
//   final String name;
//   final String panchayatId;

//   Village(this.id, this.name, this.panchayatId);
// }

// class Street {
//   final String id;
//   final String name;
//   final String villageId;

//   Street(this.id, this.name, this.villageId);
// }

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedPanchayat;
//   String? _selectedVillage;
//   String? _selectedStreet;

//   List<Panchayat> panchayats = [
//     Panchayat('1', 'Panchayat 1'),
//     Panchayat('2', 'Panchayat 2'),
//     Panchayat('3', 'Panchayat 3')
//   ];
//   List<Village> villages = [
//     Village('1', 'Village 1', '1'),
//     Village('2', 'Village 2', '1'),
//     Village('3', 'Village 3', '1'),
//     Village('4', 'Village 4', '2'),
//     Village('5', 'Village 6', '2'),
//     Village('6', 'Village 5', '2'),
//     Village('7', 'Village 7', '3'),
//     Village('8', 'Village 8', '3'),
//     Village('9', 'Village 9', '3'),
//   ];
//   List<Street> streets = [
//     Street('1', 'Street 1', '1'),
//     Street('2', 'Street 2', '1'),
//     Street('3', 'Street 3', '1'),
//     Street('4', 'Street 4', '2'),
//     Street('5', 'Street 5', '2'),
//     Street('6', 'Street 6', '2'),
//     Street('7', 'Street 7', '3'),
//     Street('8', 'Street 8', '3'),
//     Street('9', 'Street 9', '3'),
//     Street('9', 'Street 9', '3'),
//     Street('10', 'Street 10', '4'),
//     Street('11', 'Street 11', '4'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.black),
//           centerTitle: true,
//           title: const Text(
//             'Add Household',
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.grey[50],
//           actions: <Widget>[
//             IconButton(
//               iconSize: 30,
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Container(
//               padding: const EdgeInsets.only(top: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   Column(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(right: 100.0),
//                         child: Text(
//                           'Select Panchayat, Village & Street',
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       DropdownButtonFormField<String>(
//                         value: _selectedPanchayat,
//                         items: panchayats.map((Panchayat panchayat) {
//                           return DropdownMenuItem<String>(
//                             value: panchayat.id,
//                             child: Text(panchayat.name),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedPanchayat = newValue;
//                             _selectedVillage = null;
//                             _selectedStreet = null;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Select a Panchayat',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Panchayat is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       DropdownButtonFormField<String>(
//                         value: _selectedVillage,
//                         items: villages
//                             .where((village) =>
//                                 village.panchayatId == _selectedPanchayat)
//                             .map((Village village) {
//                           return DropdownMenuItem<String>(
//                             value: village.id,
//                             child: Text(village.name),
//                           );
//                         }).toList(),
//                         onChanged: _selectedPanchayat != null
//                             ? (String? newValue) {
//                                 setState(() {
//                                   _selectedVillage = newValue;
//                                   _selectedStreet = null;
//                                 });
//                               }
//                             : null,
//                         decoration: InputDecoration(
//                           labelText: 'Select a Village',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.black), // Change the color here
//                           ),
//                         ),
//                         validator: (value) {
//                           if (_selectedPanchayat == null ||
//                               value == null ||
//                               value.isEmpty) {
//                             return 'Village is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       DropdownButtonFormField<String>(
//                         value: _selectedStreet,
//                         items: streets
//                             .where((street) =>
//                                 street.villageId == _selectedVillage)
//                             .map((Street street) {
//                           return DropdownMenuItem<String>(
//                             value: street.id,
//                             child: Text(street.name),
//                           );
//                         }).toList(),
//                         onChanged: _selectedVillage != null
//                             ? (String? newValue) {
//                                 setState(() {
//                                   _selectedStreet = newValue;
//                                 });
//                               }
//                             : null,
//                         decoration: InputDecoration(
//                           labelText: 'Select a Street',
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                             // Change the color here
//                           ),
//                         ),
//                         validator: (value) {
//                           if (_selectedVillage == null ||
//                               value == null ||
//                               value.isEmpty) {
//                             return 'Street is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(350, 50),
//                           backgroundColor: _selectedPanchayat != null &&
//                                   _selectedVillage != null &&
//                                   _selectedStreet != null
//                               ? Colors.blue[900]
//                               : Colors.blue[100],
//                         ),
//                         onPressed: _selectedPanchayat != null &&
//                                 _selectedVillage != null &&
//                                 _selectedStreet != null
//                             ? () {
//                                 if (_formKey.currentState?.validate() ??
//                                     false) {
//                                   // All fields are valid, you can process the data
//                                   // Perform actions with the field values

//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (context) => AddHead(),
//                                     ),
//                                   );
//                                 }
//                               }
//                             : null,
//                         child: const Text('Next'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
