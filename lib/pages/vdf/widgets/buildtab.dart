// import 'package:flutter/material.dart';

// void _onTabTapped(int index) {
//   int _selectedIndex = 0;
//   setState(() {
//     _selectedIndex = index;
//   });
// }

// Widget buildTabItem(IconData icon, String label, int index) {
//   // Track the currently selected tab index

//   final isSelected = index == 0;
//   final color = isSelected ? Colors.blue : Colors.black;

//   return InkWell(
//     onTap: () {
//       _onTabTapped(index);
//       if (index == 1) {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => MyForm(),
//           ),
//         );
//       }
//       if (index == 2) {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => AddStreet(),
//           ),
//         );
//       }
//     },
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           color: color,
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: color,
//           ),
//         ),
//       ],
//     ),
//   );
// }
