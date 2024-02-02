import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<String, dynamic>> getListOfRegions() async {
    try {
      String url = '$base/list-regions';

      print("Object0");


      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      print("Object1");


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2");

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> regionsData = respBody['resp_body'];

          print("Object3");

          final List<Map<String, dynamic>> regions = regionsData.map<Map<String, dynamic>>((region) => {
            'regionId': region['regionId'],
            'region': region['region'],
            'rhId': region['rhId'],
          }).toList();


          return {'regions': regions}; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }




  Future<Map<String, dynamic>> getListOfLocations(int regionId) async {
    try {

      print("Object1");

      final response = await http.get(Uri.parse('$base/list-locations?regionId=$regionId'));

      if (response.statusCode == 200) {

        print("Object1");

        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2");

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> locationsData = respBody['resp_body'];

          print("Object3");

          final List<Map<String, dynamic>> locations = locationsData.map<Map<String, dynamic>>((location) => {
            'locationId': location['locationId'],
            'location': location['location']
          }).toList();

          // print("sgncy $locations");

          return {'locations': locations}; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }

      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }

  Future<String> checkDuplicateLocation(String locationName) async {

    try {
      String url = '$base/validate-duplicate-location?locationName=$locationName';

      print("Object0");

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      print("Object1");

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2");
        if (respBody.containsKey('resp_msg')) {
          final String duplicateLocationResMessage = respBody['resp_msg'];

          print("Object3");

          return duplicateLocationResMessage; // Returning a map with 'clusters' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }

  Future<String> addLocation(int regionId, String locationName, int clusterCount) async {

    try {
      String url = '$base/add-location';

      print("Object0");

      Map<String, dynamic> requestBody = {
        "clusterCount": clusterCount,
        "location": locationName,
        "regionId": regionId
      };

      final response = await http.post(Uri.parse(url),

          headers: <String, String> {
            'Content-Type' : 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody)
      ).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          final String addPanchayatResMessage = respBody['resp_msg'];

          return addPanchayatResMessage; // Returning a map with 'clusters' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to add panchayat. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }





}
