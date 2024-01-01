import 'dart:convert';

import 'package:dalmia/pages/vdf/street/Addnew.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// String selectedPanchayat = "";
// String selectedVillage = "";

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
              'Add a Street',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: CustomFontTheme.headingSize,
                  fontWeight: CustomFontTheme.headingwt),
            ),
            backgroundColor: Colors.grey[50],
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF006838).withOpacity(0.1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                color: Color(0xFF006838)),
                            children: [
                              const TextSpan(
                                text: 'Panchayat :',
                                style: TextStyle(
                                  fontWeight: CustomFontTheme.labelwt,
                                ),
                              ),
                              TextSpan(text: '  ${widget.selectedPanchayat} '),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                color: Color(0xFF006838)),
                            children: [
                              const TextSpan(
                                text: 'Village:',
                                style: TextStyle(
                                  fontWeight: CustomFontTheme.labelwt,
                                ),
                              ),
                              TextSpan(text: '  ${widget.selectedVillage}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Check whether the street is already added?',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 400,
                      decoration: const BoxDecoration(
                        color: Color(0x19008CD3),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showBottomBorder: false,
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
                                textAlign: TextAlign.left,
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: CustomColorTheme.primaryColor,
                    ),
                    onPressed: () {
                      print(widget.selectedVillagId);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Addnew(
                            panchayat: widget.selectedPanchayat,
                            village: widget.selectedVillage,
                            villagId: widget.selectedVillagId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add New Street',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CustomFontTheme.textSize),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
