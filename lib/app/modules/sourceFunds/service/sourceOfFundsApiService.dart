import 'dart:convert';
import 'package:dalmia/app/modules/sourceFunds/controllers/source_funds_controller.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class SourceOfFundsApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.68:8080/csr';


  Future<Map<String, dynamic>> getListOfRegions(SourceFundsController controller) async {
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


          controller.selectRegion = regions.elementAt(0)['region'];
          controller.selectRegionId = regions.elementAt(0)['regionId'];


          print("controller.selectRegion : ${controller.selectRegion}");
          print("controller.selectRegionId : ${controller.selectRegionId}");

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
        print("\n\n API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> clustersData = respBody['resp_body'];

          final List<Map<String, dynamic>> clusters = clustersData.map<Map<String, dynamic>>((cluster) => {
            'clusterId': cluster['clusterId'],
            'clusterName': cluster['clusterName'],
            'vdfName': cluster['vdfName'],

          }).toList();

          print("\nsgncy $clusters");

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


  Future<Map<String, Map<String, dynamic>>?> fetchSourceOfFundsData(SourceFundsController controller) async {
    try {
      final response = await http.get(
        Uri.parse('$base/gpl-source-of-funds'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData.containsKey('resp_body')) {
          final Map<String, dynamic> respBody = jsonData['resp_body'];

          // Ensure 'resp_body' contains the expected data structure
          if (respBody is Map<String, dynamic>) {
            // Create the desired map structure directly
            Map<String, Map<String, dynamic>> sourceOfFundsData = {};
            respBody.forEach((key, data) {
              sourceOfFundsData[key] = {
                'noOfHouseholds': data['noOfHouseholds'],
                'beneficiary': data['beneficiary'],
                'subsidy': data['subsidy'],
                'credits': data['credits'],
                'dbf': data['dbf'],
              };
            });

            // Update the controller or perform any necessary actions
            controller.updateSourceOfFundsData(sourceOfFundsData);

            print("controller.sourceOfFundsData : ${controller.sourceOfFundsData}");

            return sourceOfFundsData;

          } else {
            throw Exception('Unexpected data structure in "resp_body"');
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
    return null; // Return null if there's an error or no data
  }


  Future<Map<String, Map<String, dynamic>>?> fetchRegionWiseSourceOfFundsData(SourceFundsController controller) async {
    try {
      final response = await http.get(
        Uri.parse('$base/gpl-location-wise-source-of-funds?regionId=${controller.selectRegionId!}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData.containsKey('resp_body')) {
          final Map<String, dynamic> respBody = jsonData['resp_body'];

          // Ensure 'resp_body' contains the expected data structure
          if (respBody is Map<String, dynamic>) {
            // Create the desired map structure directly
            Map<String, Map<String, dynamic>> regionWiseSourceOfFundsData = {};
            respBody.forEach((key, data) {
              regionWiseSourceOfFundsData[key] = {
                'noOfHouseholds': data['noOfHouseholds'],
                'beneficiary': data['beneficiary'],
                'subsidy': data['subsidy'],
                'credits': data['credits'],
                'dbf': data['dbf'],
              };
            });

            // Update the controller or perform any necessary actions
            controller.updateRegionWiseSourceOfFundsData(regionWiseSourceOfFundsData);

            print(" \n \n controller.regionWiseSourceOfFundsData wiuygif : ${controller.regionWiseSourceOfFundsData}");

            return regionWiseSourceOfFundsData;

          } else {
            throw Exception('Unexpected data structure in "resp_body"');
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
    return null; // Return null if there's an error or no data
  }


  Future<Map<String, Map<String, dynamic>>?> fetchClusterWiseSourceOfFundsData(SourceFundsController controller) async {
    try {
      final response = await http.get(
        Uri.parse('$base/gpl-cluster-wise-source-of-funds?locationId=${controller.selectLocationId!}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData.containsKey('resp_body')) {
          final Map<String, dynamic> respBody = jsonData['resp_body'];

          // Ensure 'resp_body' contains the expected data structure
          if (respBody is Map<String, dynamic>) {
            // Create the desired map structure directly
            Map<String, Map<String, dynamic>> locationWiseSourceOfFundsData = {};
            respBody.forEach((key, data) {
              locationWiseSourceOfFundsData[key] = {
                'noOfHouseholds': data['noOfHouseholds'],
                'beneficiary': data['beneficiary'],
                'subsidy': data['subsidy'],
                'credits': data['credits'],
                'dbf': data['dbf'],
              };
            });

            // Update the controller or perform any necessary actions
            controller.updateLocationWiseSourceOfFundsData(locationWiseSourceOfFundsData);

            print(" \n \n controller.locationWiseSourceOfFundsData wiuygif : ${controller.locationWiseSourceOfFundsData}");

            return locationWiseSourceOfFundsData;

          } else {
            throw Exception('Unexpected data structure in "resp_body"');
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
    return null; // Return null if there's an error or no data
  }




}
