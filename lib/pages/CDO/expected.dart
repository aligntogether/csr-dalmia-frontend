import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class Expectedincome extends StatefulWidget {
  const Expectedincome({Key? key}) : super(key: key);

  @override
  State<Expectedincome> createState() => _ExpectedincomeState();
}

class _ExpectedincomeState extends State<Expectedincome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
            heading: 'Reports',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
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
                Center(
                  child: Text(
                    'Expected and actual additional incomes',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dividerThickness: 00,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Clusters',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Details',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'DPM',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                      ],
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFF008CD3)),
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate a random number
  // int _generateRandomNumber() {
  //   return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
  // }
}
