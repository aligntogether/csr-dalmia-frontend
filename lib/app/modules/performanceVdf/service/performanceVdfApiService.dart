import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class PerformanceVdfApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<String, dynamic>> getListOfRegions() async {
    try {
      String url = '$base/list-regions';


      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> regionsData = respBody['resp_body'];

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

      final response = await http.get(Uri.parse('$base/list-locations?regionId=$regionId'));

      if (response.statusCode == 200) {

        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> locationsData = respBody['resp_body'];

          print("Object3");

          final List<Map<String, dynamic>> locations = locationsData.map<Map<String, dynamic>>((location) => {
            'locationId': location['locationId'],
            'location': location['location']
          }).toList();

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


  Future<Map<String, dynamic>?> getListOfClusters(int locationId) async {

    try {
      String url = '$base/list-cluster-by-location?locationId=$locationId';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
           if (respBody['resp_msg'] == "No Data Found") {
             return null;
           }
        }

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> clustersData = respBody['resp_body'];

          final List<Map<String, dynamic>> clusters = clustersData.map<Map<String, dynamic>>((cluster) => {
            'clusterId': cluster['clusterId'],
            'clusterName': cluster['clusterName'],
            'vdfName': cluster['vdfName'],
            'vdfId': cluster['vdfId'],
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

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        if (respBody.containsKey('resp_msg')) {
          final String duplicatePanchayatResMessage = respBody['resp_msg'];

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


  Future<String> replaceVdf(int clusterId, String vdfName) async {

    try {
      String url = '$base/replace-vdf-for-cluster?clusterId=$clusterId&vdfName=$vdfName';



      final response = await http.put(Uri.parse(url)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          final String replaceVdfResMessage = respBody['resp_msg'];

          return replaceVdfResMessage; // Returning a map with 'clusters' key containing the list
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

  Future<Map<String, dynamic>> getPerformanceReport(int vdfId) async {

    try {
      String url = '$base/gpl-vdf-performance?vdfId=$vdfId';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
       // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final Map<String, dynamic> performanceReportData = respBody['resp_body'];

          return performanceReportData;
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        throw Exception('Failed to add panchayat. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }

  }




}
