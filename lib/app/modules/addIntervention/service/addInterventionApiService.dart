import 'dart:convert';
import 'package:dalmia/app/modules/addIntervention/controllers/add_intervention_controller.dart';
import 'package:dalmia/helper/sharedpref.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);
class AddInterventionApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.68:8080/csr';


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


  Future<Map<String, dynamic>> getPanchayatsByLocations(int locationId) async {
    try {

      print("Object1gp, $locationId, locationId");

      final response = await http.get(Uri.parse('$base/list-panchayat-by-location?locationId=$locationId'));

      if (response.statusCode == 200) {


        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> panchayatsData = respBody['resp_body'];


          final List<Map<String, dynamic>> panchayats = panchayatsData.map<Map<String, dynamic>>((panchayat) => {
            'panchayatId': panchayat['panchayatId'],
            'panchayatName': panchayat['panchayatName'],
            'panchayatCode': panchayat['panchayatCode'],
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

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> clustersData = respBody['resp_body'];

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


  Future<String> validateDuplicateIntervention(String interventionName) async {

    try {
      String url = '$base/validate-duplicate-intervention?interventionName=$interventionName';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);
        if (respBody.containsKey('resp_msg')) {
          final String duplicateInterventionResMessage = respBody['resp_msg'];

          return duplicateInterventionResMessage; // Returning a map with 'clusters' key containing the list
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


  Future<String> addIntervention(String interventionName, String lever, int expectedIncomeGeneration, int requiredDaysCompletion) async {

    try {
      String url = '$base/add-intervention';

      Map<String, dynamic> requestBody = {
        "interventionName": interventionName,
        "lever": lever,
        "expectedIncomeGeneration": expectedIncomeGeneration,
        "requiredDaysCompletion": requiredDaysCompletion
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


  Future<List<Map<String, dynamic>>?> fetchInterventionsData(AddInterventionController controller, int? skipRecordsCount, int? recordsCount) async {
    try {
      final response = await http.get(
        Uri.parse('$base/list-interventions?skipRecordsCount=${controller.skipRecordsCount}&recordCount=${controller.recordsCount}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData.containsKey('resp_body')) {
          final Map<String, dynamic> respBody = jsonData['resp_body'];

          if (respBody.containsKey('interventions')) {
            final List<dynamic> interventionsData = respBody['interventions'];

            List<Map<String, dynamic>> interventions = interventionsData.map<Map<String, dynamic>>((intervention) => {
              'interventionName': intervention['interventionName'],
              'lever': intervention['lever'],
              'activity': intervention['activity'],
              'expectedIncomeGeneration': intervention['expectedIncomeGeneration'],
              'requiredDaysCompletion': intervention['requiredDaysCompletion'],
            }).toList();

            print("interventionsData : $interventions");

            // You can update the controller or do whatever you need with leverData.
            controller.updateInterventionsData(interventions);

            // print("out............. \n \n  .........");
            if (respBody.containsKey('totalInterventionsRecords')) {

              controller.totalInterventionsCount = respBody['totalInterventionsRecords'];

            }

            return interventions;

          }

        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



}
