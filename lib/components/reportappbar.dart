// import 'package:dalmia/common/navmenu.dart';
// import 'package:dalmia/theme.dart';
// import 'package:flutter/material.dart';

// class ReportAppBar extends StatefulWidget {
//   final String heading;

//   ReportAppBar({
//     required this.heading,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ReportAppBar> createState() => _ReportAppBarState();
// }

// class _ReportAppBarState extends State<ReportAppBar> {
//   bool isreportMenuOpen = false;

//   void _toggleMenu() {
//     setState(() {
//       isreportMenuOpen = !isreportMenuOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AppBar(
//           titleSpacing: 20,
//           backgroundColor: Colors.white,
//           title: const Image(image: AssetImage('images/icon.jpg')),
//           automaticallyImplyLeading: false,
//           actions: <Widget>[
//             CircleAvatar(
//               backgroundColor: CustomColorTheme.primaryColor,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.notifications_none_outlined,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 20),
//             IconButton(
//               iconSize: 30,
//               onPressed: () {
//                 _toggleMenu();
//               },
//               icon: const Icon(Icons.menu,
//                   color: CustomColorTheme.primaryColor // Update with your color
//                   ),
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(50),
//             child: Container(
//               padding: const EdgeInsets.only(left: 30, bottom: 10),
//               alignment: Alignment.topCenter,
//               color: Colors.white,
//               child: Text(
//                 widget.heading,
//                 style: const TextStyle(
//                   fontSize: CustomFontTheme.headingSize,

//                   // Adjust the font size
//                   fontWeight:
//                       CustomFontTheme.headingwt, // Adjust the font weight
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (isreportMenuOpen) navmenu(context, _toggleMenu),
    
//       ],
//     );
//   }
// }
