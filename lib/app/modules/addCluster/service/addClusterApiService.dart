import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddClusterApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<String, dynamic>> getListOfVillages(int panchayatId) async {

    try {
      String url = '$base/list-village-by-panchayat?panchayatId=$panchayatId';


      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> villageData = respBody['resp_body'];

          final List<Map<String, dynamic>> villages = villageData.map<Map<String, dynamic>>((village) => {
            'villageId': village['villageId'],
            'villageName': village['villageName'],
            'villageCode': village['villageCode']
          }).toList();

          return {'villages': villages}; // Returning a map with 'clusters' key containing the list
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


  Future<String> validateDuplicateVillage(int panchayatId, String villageName, String villageCode) async {

    try {
      String url = '$base/validate-duplicate-village?panchayatId=$panchayatId&villageName=$villageName&villageCode=$villageCode';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          final String duplicateVillageResMessage = respBody['resp_msg'];

          return duplicateVillageResMessage; // Returning a map with 'clusters' key containing the list
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


  Future<Map<String, dynamic>> updateAddCluster(int locationId, int clusterCount) async {

    try {
      String url = '$base/update-cluster?locationId=$locationId&clusterCount=$clusterCount';

      final response = await http.put(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final Map<String, dynamic> clusterData = respBody['resp_body'];

          // final Map<String, dynamic> cluster = clusterData.map<Map<String, dynamic>>((village) => {
          //   'clusterId': village['clusterId'],
          //   'clusterName': village['clusterName'],
          //   'locationId': village['locationId']
          // });

          return clusterData; // Returning a map with 'clusters' key containing the list
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


  Future<String> addVDFToCluster(int locationId, int clusterId, String vdfName, int mobileNumber) async {

    try {
      String url = '$base/add-vdf-to-cluster?locationId=$locationId&clusterId=$clusterId&vdfName=$vdfName&mobileNumber=$mobileNumber';

      final response = await http.put(Uri.parse(url)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          final String addVDFMessage = respBody['resp_msg'];

          return addVDFMessage;
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to add VDF. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }



}
