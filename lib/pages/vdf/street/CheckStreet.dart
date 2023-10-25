import 'package:dalmia/pages/vdf/street/Addnew.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class CheckStreet extends StatefulWidget {
  final String? selectedPanchayat;
  final String? selectedVillage;

  const CheckStreet({Key? key, this.selectedPanchayat, this.selectedVillage})
      : super(key: key);

  @override
  _CheckStreetState createState() => _CheckStreetState();
}

class _CheckStreetState extends State<CheckStreet> {
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 162, 255, 165)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Panchayat : ${widget.selectedPanchayat} '),
                        Text('Village:  ${widget.selectedVillage}')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Check whether the street is already added?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 236, 248)),
                    child: DataTable(
                      dividerThickness: 0.0,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'First Heading',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Second Heading',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Data 1')),
                            DataCell(Text('Data 2')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Data 3')),
                            DataCell(Text('Data 4')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Data 5')),
                            DataCell(Text('Data 6')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Data 7')),
                            DataCell(Text('Data 8')),
                          ],
                        ),
                        // Add more rows as needed
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: Colors.blue[900],
                    ),
                    onPressed: () {
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
