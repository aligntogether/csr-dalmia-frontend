import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
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


    Future<Map<String, dynamic>> getPanchayatsByLocations(int locationId) async {
    try {

      print("Object1gp, $locationId, locationId");

      final response = await http.get(Uri.parse('$base/list-panchayat-by-location?locationId=$locationId'));

      if (response.statusCode == 200) {

        print("Object1gp");

        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2gp");

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> panchayatsData = respBody['resp_body'];

          print("Object3gp");

          final List<Map<String, dynamic>> panchayats = panchayatsData.map<Map<String, dynamic>>((panchayat) => {
            'panchayatId': panchayat['panchayatId'],
            'panchayatName': panchayat['panchayatName']
          }).toList();


          return {'panchayats': panchayats}; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }

      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making API request: $e');
      throw Exception('Error making API request: $e');
    }
  }


  Future<Map<String, dynamic>> getListOfClusters(int locationId) async {

    try {
      String url = '$base/list-cluster-by-location?locationId=$locationId';

      print("Object0");

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      print("Object1");


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2");

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> clustersData = respBody['resp_body'];

          print("Object3");

          final List<Map<String, dynamic>> clusters = clustersData.map<Map<String, dynamic>>((cluster) => {
            'clusterId': cluster['clusterId'],
            'clusterName': cluster['clusterName']
          }).toList();

          print("sgncy $clusters");

          return {'clusters': clusters}; // Returning a map with 'clusters' key containing the list
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


  Future<String> validateDuplicatePanchayat(int clusterId, String panchayatName, String panchayatCode) async {

    try {
      String url = '$base/validate-duplicate-panchayat?clusterId=$clusterId&panchayatName=$panchayatName&panchayatCode=$panchayatCode';

      print("Object0");

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      print("Object1");

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        print("Object2");
        if (respBody.containsKey('resp_msg')) {
          final String duplicatePanchayatResMessage = respBody['resp_msg'];

          print("Object3");

          return duplicatePanchayatResMessage; // Returning a map with 'clusters' key containing the list
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


  Future<String> addPanchayat(int clusterId, String panchayatName, String panchayatCode) async {

    try {
      String url = '$base/add-panchayat';

      print("Object0");

      Map<String, dynamic> requestBody = {
          "clusterId": clusterId,
          "panchayatName": panchayatName,
          "panchayatCode": panchayatCode,
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
