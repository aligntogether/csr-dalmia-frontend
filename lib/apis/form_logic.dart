// import 'package:flutter/material.dart';

// Future<void> fetchGenderOptions() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.1.71:8080/dropdown?titleId=101'),
//       );
//       if (response.statusCode == 200) {
//         CommonObject commonObject =
//             CommonObject.fromJson(json.decode(response.body));
//         List<dynamic> options = commonObject.respBody['options'];

//         setState(() {
//           genderOptions = options;
//         });
//       } else {
//         throw Exception(
//             'Failed to load gender options: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<void> fetchCasteOptions() async {
//     const String url = 'http://192.168.1.71:8080/dropdown?titleId=105';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         CommonObject commonObject =
//             CommonObject.fromJson(json.decode(response.body));
//         List<dynamic> options = commonObject.respBody['options'];
//         setState(() {
//           casteOptions = options;
//         });
//       } else {
//         throw Exception('Failed to load caste options: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<void> fetchEducationOptions() async {
//     const String url = 'http://192.168.1.71:8080/dropdown?titleId=102';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         CommonObject commonObject =
//             CommonObject.fromJson(json.decode(response.body));
//         List<dynamic> options = commonObject.respBody['options'];
//         setState(() {
//           educationOptions = options;
//         });
//       } else {
//         throw Exception('Failed to load caste options: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<void> fetchPrimaryOptions() async {
//     const String url = 'http://192.168.1.71:8080/dropdown?titleId=103';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         CommonObject commonObject =
//             CommonObject.fromJson(json.decode(response.body));
//         List<dynamic> options = commonObject.respBody['options'];
//         setState(() {
//           primaryEmploymentOptions = options;
//         });
//       } else {
//         throw Exception('Failed to load caste options: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<void> fetchSecondaryOptions() async {
//     const String url = 'http://192.168.1.71:8080/dropdown?titleId=104';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         CommonObject commonObject =
//             CommonObject.fromJson(json.decode(response.body));
//         List<dynamic> options = commonObject.respBody['options'];
//         setState(() {
//           secondaryEmploymentOptions = options;
//         });
//       } else {
//         throw Exception('Failed to load caste options: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// // }
