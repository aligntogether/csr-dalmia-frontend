import 'package:dalmia/pages/ACCOUNTS/accounts_home_screen.dart';
import 'package:dalmia/pages/ACCOUNTS/updateexpenditure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../CDO/cdoappbar.dart';

class updateBudgetReport {
  static List<String> cluster = [
    'Cluster 1',
    'Cluster 2',
    'Cluster 3',
    'Cluster 4'
  ];
  static List<int> amount = [500000, 500000, 500000, 500000];
}

class UpdateBudget extends StatefulWidget {
  const UpdateBudget({super.key});

  @override
  State<UpdateBudget> createState() => _UpdateBudgetState();
}

class _UpdateBudgetState extends State<UpdateBudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        //  isMenuOpen ? Size.fromHeight(150) :
        Size.fromHeight(100),
        child: CdoAppBar(
          heading: 'Update Budget',
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AccountsHome(),
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
                    ),
                    Spacer(), //
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => const UpdateExpenditure(),
                              ),
                          );
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/updateExpenditure.svg',
                              width: 30,
                              height: 14,
                            ),
                            SizedBox(width: 4), // Add spacing between icon and text
                            Text('Update Expenditure',style: TextStyle(fontSize: 12),),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Column(

                crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                children: [
                  Text(
                    'Select a Region',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          items: ['Option 1', 'Option 2', 'Option 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Handle dropdown selection
                          },
                          hint: Text('Select Region'),
                        ),
                      ),
                      SizedBox(width: 16),

                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select a Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          items: ['Location 1', 'Location 2', 'Location 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Handle dropdown selection
                          },
                          hint: Text('Select Location'),
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: 00,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Amount',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ],
                    headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF008CD3)),
                    rows: List<DataRow>.generate(
                      updateBudgetReport.cluster.length,
                          (index) => DataRow(
                        color: MaterialStateColor.resolveWith(
                              (states) {
                            return index.isOdd
                                ? Colors.blue.shade50
                                : Colors.white;
                          },
                        ),
                        cells: [
                          DataCell(
                            Text(
                              updateBudgetReport.cluster[index],
                              style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                fontWeight: CustomFontTheme.headingwt,
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                Text(
                                  'Rs',
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                                SizedBox(width: 5), // Add some spacing between "Rs" and the input field
                                Expanded(
                                  child: TextFormField(
                                    initialValue: updateBudgetReport.amount[index].toString(),
                                    keyboardType: TextInputType.number, // You can adjust the keyboard type
                                    onChanged: (newValue) {
                                      // Update the corresponding amount in your data source
                                      setState(() {
                                        updateBudgetReport.amount[index] = int.tryParse(newValue) ?? 0;
                                      });
                                    },
                                    style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      isDense: false,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Additional row for total
                        ],
                      ),
                    )
                  ))
            ],
          ),
        ),
      ),
    );
  }
}




//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Location and Region Selection'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center, // Center the content
//             children: [
//               Text(
//                 'Select or Enter Location:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center, // Center the row
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey[200],
//                     ),
//                     child: DropdownButton<String>(
//                       items: ['Option 1', 'Option 2', 'Option 3']
//                           .map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         // Handle dropdown selection
//                       },
//                       hint: Text('Select Location'),
//                     ),
//                   ),
//                   SizedBox(width: 16),
//
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Select or Enter Region:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center, // Center the row
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey[200],
//                     ),
//                     child: DropdownButton<String>(
//                       items: ['Region 1', 'Region 2', 'Region 3']
//                           .map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         // Handle dropdown selection
//                       },
//                       hint: Text('Select Region'),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

