import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

class AddVillageApiService {


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


  Future<String> addVillage(int panchayatId, String villageName, String villageCode) async {

    try {
      String url = '$base/add-village';

      Map<String, dynamic> requestBody = {
        "panchayatId": panchayatId,
        "villageName": villageName,
        "villageCode": villageCode
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
          final String addVillageResMessage = respBody['resp_msg'];

          return addVillageResMessage; // Returning a map with 'clusters' key containing the list
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
