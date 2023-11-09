import 'dart:convert';

import 'package:dalmia/pages/vdf/street/Addnew.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String selectedPanchayat = "";
String selectedVillage = "";

class StreetData {
  final String streetName;
  final int streetId;
  final int villageId;
  final String streetCode;
  final int householdCount;
  final int familyCount;

  StreetData({
    required this.streetName,
    required this.streetId,
    required this.villageId,
    required this.streetCode,
    required this.householdCount,
    required this.familyCount,
  });

  factory StreetData.fromJson(Map<String, dynamic> json) {
    return StreetData(
      streetName: json['streetName'],
      streetId: json['streetId'],
      villageId: json['villageId'],
      streetCode: json['streetCode'],
      householdCount: json['householdCount'],
      familyCount: json['familyCount'],
    );
  }
}

class CheckStreet extends StatefulWidget {
  final String? selectedPanchayat;
  final String? selectedVillage;
  final String? selectedVillagId;

  const CheckStreet(
      {super.key,
      this.selectedPanchayat,
      this.selectedVillage,
      this.selectedVillagId});

  @override
  _CheckStreetState createState() => _CheckStreetState();
}

class _CheckStreetState extends State<CheckStreet> {
  List<StreetData> streetData = [];

  Future<void> fetchData() async {
    String url = '$base/view-streets?villageId=${widget.selectedVillagId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> respBody = jsonResponse['resp_body'];

        List<StreetData> data =
            respBody.map((e) => StreetData.fromJson(e)).toList();

        setState(() {
          streetData = data;
        });
      } else {
        throw Exception('Failed to load street data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
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
              'Add Street',
              style: TextStyle(color: Colors.black),
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
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 232, 253, 233)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Panchayat : ${widget.selectedPanchayat} '),
                        Text('Village:  ${widget.selectedVillage}')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Check whether the street is already added?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 221, 236, 248)),
                    child: DataTable(
                      dividerThickness: 0.0,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Street Name',
                            style: TextStyle(),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'No. of Family/ \n No. of Household',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                      rows: streetData
                          .map(
                            (data) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                    '${data.streetName}(${data.streetCode})')),
                                DataCell(Text(
                                    '${data.familyCount}/${data.householdCount}')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: Colors.blue[900],
                    ),
                    onPressed: () {
                      String selectedPanchayatName = selectedPanchayat;

                      String selectedVillageName = selectedVillage;
                      // String selectedVillagId = villages
                      //     .firstWhere((element) =>
                      //         element.villageid == _selectedVillage)
                      //     .villageid;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Addnew(),
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
