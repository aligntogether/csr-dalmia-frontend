import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class VdfReport extends StatefulWidget {
  const VdfReport({Key? key}) : super(key: key);

  @override
  State<VdfReport> createState() => _VdfReportState();
}

class _VdfReportState extends State<VdfReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
            heading: 'VDF Reports',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CDOHome(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_sharp,
                      ),
                      Text(
                        'Main Menu',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    child: DataTable(
                      // border:
                      //     TableBorder(borderRadius: BorderRadius.circular(10)),
                      dividerThickness: 0,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VDF 1',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VDF 2',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VDF 3',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VDF 4',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'VDF 5',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF008CD3),
                      ),
                      rows: [
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Household',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Alloted',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Mapped',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Selected',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Selection %',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Intervention',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'HH covered',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Planned',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'F/u overdue',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'HH with Annual Addl. Income',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'No. of HH',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '>25k',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '25k-50k',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '50k-75L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '75L-1L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '>1L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                'N/A',
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate a random number
  int _generateRandomNumber() {
    return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
  }
}
