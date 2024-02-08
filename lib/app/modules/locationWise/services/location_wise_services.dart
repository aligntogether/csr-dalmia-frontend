import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationWiseServices{


  String? base = dotenv.env['BASE_URL'];
  Future<Map<String,dynamic>> getAllReport() async {
    try {
      String url = "$base/gpl-eaai-aaai-report";


      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        print(data['resp_body']);

        return data['resp_body'];
      }
      else {
        return {"error":"Couldn't fetch data"};
      };

    }
    catch (e) {
      print(e);
    }
    return {"error":"Couldn't fetch data"};
  }
  Future<Map<int, String>> getAllRegions() async {
    try {
      String url = '$base/list-regions';


      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

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
  Future<Map<String, List<String>>>getRegionLocation(Map<int, String> regions) async {
    try {
      print("regions : $regions");
      Map<String, List<String>> locations = {};

      for (int regionId in regions.keys) {
        print("regionId : $regionId");
        String url = '$base/locations/search/findByRegionId?regionId=$regionId';

        final response = await http.get(Uri.parse(url), headers: {'accept': '*/*'},).timeout(Duration(seconds: 30));
        print("response : $response");

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
            print("HIs");
            print("locationList : $locationList");
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