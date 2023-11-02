import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key});

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: reportappbar(heading: 'Drafts')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'Select a row to edit or delete draft HH',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt),
              )),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        ' ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label:
                          Text('Date', style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('Head Name',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label:
                          Text('Street', style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('Village',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        DataCell(Text(
                            '2023-10-31')), // Placeholder date, replace with actual data
                        DataCell(Text(
                            'John Doe')), // Placeholder name, replace with actual data
                        DataCell(Text(
                            'Main Street')), // Placeholder street, replace with actual data
                        DataCell(Text('Rural Village')),
                      ],
                    ),
                    DataRow(
                      color: MaterialStateColor.resolveWith(
                          (states) => Colors.lightBlue[50]!),
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        DataCell(Text(
                            '2023-10-31')), // Placeholder date, replace with actual data
                        DataCell(Text(
                            'John Doe')), // Placeholder name, replace with actual data
                        DataCell(Text(
                            'Main Street')), // Placeholder street, replace with actual data
                        DataCell(Text('Rural Village')),
                      ],
                    ),
                    // Add more DataRows as needed
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.primaryColor),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Edit Household',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: CustomColorTheme.primaryColor, width: 1)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.backgroundColor),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Delete Household',
                          style:
                              TextStyle(color: CustomColorTheme.primaryColor),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
