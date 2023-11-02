//  import 'package:dalmia/pages/vdf/household/addhouse.dart';
// import 'package:dalmia/theme.dart';
// import 'package:flutter/material.dart';
// // int _selectedIndex = 0; // Track the currently selected tab index

// //   void _onTabTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// Widget buildTabItem(String imagePath, String label, int index, BuildContext context) {
//     final isSelected = index == 0;
//     final color = isSelected ? CustomColorTheme.primaryColor : Colors.black;

//     return InkWell(
//       onTap: () {
//         _onTabTapped(index);
//         if (index == 1) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => MyForm(),
//             ),
//           );
//         }
//         if (index == 2) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => AddStreet(),
//             ),
//           );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             imagePath,
//             color: isSelected ? CustomColorTheme.primaryColor : Colors.black,
//             // width: 24, // Adjust the width as needed
//             // height: 24, // Adjust the height as needed
//           ),
//           Text(
//             label,
//             style: TextStyle(
//                 color: color, fontSize: 15, fontWeight: FontWeight.w400),
//           ),
//         ],
//       ),
//     );
//   }