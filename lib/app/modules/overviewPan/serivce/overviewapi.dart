// import 'dart:convert';

// import 'package:dalmia/app/modules/overviewPan/controllers/overview_pan_controller.dart';
// import 'package:dalmia/pages/vdf/street/Addstreet.dart';
// import 'package:http/http.dart' as http;

// class OverViewApi {
//   Future<Map<String, dynamic>> getListOfRegions(
//       OverviewPanController controller) async {
//     try {
//       String url = '$base/list-regions';

//       final response =
//           await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

//       if (response.statusCode == 200) {
//         print("API Response: ${response.body}");

//         // Parse the response and extract regionId and region
//         final Map<String, dynamic> respBody = json.decode(response.body);

//         if (respBody.containsKey('resp_body')) {
//           final List<dynamic> regionsData = respBody['resp_body'];

//           final List<Map<String, dynamic>> regions = regionsData
//               .map<Map<String, dynamic>>((region) => {
//                     'regionId': region['regionId'],
//                     'region': region['region'],
//                     'rhId': region['rhId'],
//                   })
//               .toList();

//           controller.selectRegion = regions.elementAt(0)['region'];
//           controller.selectRegionId = regions.elementAt(0)['regionId'];

//           print("controller.selectRegion : ${controller.selectRegion}");
//           print("controller.selectRegionId : ${controller.selectRegionId}");

//           return {
//             'regions': regions
//           }; // Returning a map with 'regions' key containing the list
//         } else {
//           throw Exception('Response format does not contain expected data');
//         }
//       } else {
//         print("API Error Response: ${response.body}");
//         throw Exception(
//             'Failed to load data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Error making API request: $e");
//       throw Exception('Error making API request: $e');
//     }
//   }
// }
