import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/Accounts/accounthome.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

class ExpectedActualServices {


  String? base = dotenv.env['BASE_URL'];

  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<String, dynamic>> getExpectedActualIncomeReport(String accessId) async {
    try {
      String url = "$base/gpl-exp-act-additional-income";

      final response = await http.get(Uri.parse(url),headers: {'X-Access-Token': accessId});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        print(data['resp_body']);

        return data['resp_body'];
      }
      else {
        return {"error": {"error": {"error": "failed to fetch data"}}};
        };

    }
    catch (e) {
      print(e);
    }
    return {"error": {"error": {"error": "failed to fetch data"}}};
  }
  Future<Map<int, String>> getAllRegions(String accessId) async {
    try {
      String url = '$base/list-regions';


      final response = await http.get(Uri.parse(url),headers: {"X-Access-Token":accessId}).timeout(Duration(seconds: 30));

      print(response);
      if (response.statusCode == 200) {


        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> regionsData = respBody['resp_body'];

          Map<int, String> regions = {};
          for (var entry in regionsData) {
            regions[entry['regionId']] = entry['region'];
          }


          return regions; // Returning a map with 'regions' key containing the list
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
  Future<Map<String, List<String>>> getRegionLocation(Map<int, String> regions,String accessId) async {
    try {
      Map<String, List<String>> locations = {};

      for (int regionId in regions.keys) {
        String url = '$base/locations/search/findByRegionId?regionId=$regionId';

        final response = await http.get(Uri.parse(url),headers: {"X-Access-Token":accessId}).timeout(Duration(seconds: 30));

        if (response.statusCode == 200) {
          final Map<String, dynamic> respBody = json.decode(response.body);

          List<String> locationList = [];
          if (respBody["_embedded"] != null) {
            Map<String, dynamic> respData = respBody["_embedded"];
            List<dynamic> locationsData = respData["locations"];
            print("locationsData : $locationsData");
            for (var entry in locationsData) {
              locationList.add(entry['locationCode']);
            }
            print("HI");
            locations[regions[regionId]!] = locationList;
          } else {
            throw Exception('Response format does not contain expected data');
          }
        } else {
          throw Exception('Failed to load data. Status code: ${response.statusCode}');
        }
      }

      print("locations : $locations");
      return locations;
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }



}