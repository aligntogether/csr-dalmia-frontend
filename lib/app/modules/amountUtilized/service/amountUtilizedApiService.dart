import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class AmountUtilizedApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobileqacloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<int, String>> getListOfRegions(String userId) async {
    try {
      String url = '$base/list-regions-under-user?userId=$userId';


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


  Future<Map<String, List<String>>> getListOfLocations(Map<int, String> regions) async {
    try {
      Map<String, List<String>> locations = {};

      for (int regionId in regions.keys) {
        String url = '$base/locations/search/findByRegionId?regionId=$regionId';

        final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

        if (response.statusCode == 200) {
          final Map<String, dynamic> respBody = json.decode(response.body);

          List<String> locationList = [];
          if (respBody["_embedded"] != null) {
            Map<String, dynamic> respData = respBody["_embedded"];
            List<dynamic> locationsData = respData["locations"];
            for (var entry in locationsData) {
              locationList.add(entry['location']);
            }
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



  Future<Map<String, dynamic>> getAmountUtilizedByRhId(String refId) async {
    try {

      String url = '$base/rh-amount-utilized-by-location?userId=$refId';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {


        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final Map<String, dynamic> amountUtilized = respBody['resp_body'];

          return amountUtilized; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }
 Future<Map<String, dynamic>> getAmountUtilized() async {
    try {

      String url = '$base/gpl-amount-utilized-by-location';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {


        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final Map<String, dynamic> amountUtilized = respBody['resp_body'];
          print(amountUtilized);
          return amountUtilized; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }


  List<Map<String, Map<String, dynamic>>> generateAmountUtilizedList(
      Map<String, Map<String, dynamic>> amountUtilized,
      List<String> locations,
      List<String> keys,
      ) {
    List<Map<String, Map<String, dynamic>>> overviewList = [];
    Map<String, Map<String, dynamic>> overviewMap = {};

    // Iterate through each key (e.g., "allotted", "mapped", etc.)
    for (String key in keys) {
      Map<String, dynamic> keyValues = {};
      num southSum = 0;
      num neSum = 0;
      num eastSum = 0;
      num sugarSum = 0;
      num totalSum = 0;

      var allLocations = ["DPM", "ALR", "BGM", "KDP", "CHA", "SOUTH",
        "MEG", "UMG", "JGR", "LAN","NE",
        "CUT", "MED", "BOK", "RAJ", "KAL", "EAST", "CEMENT",
        "NIG", "RAM", "JOW", "NIN", "KOL", "SUGAR", "PANINDIA"];

      // Iterate through each location
      for (String location in locations) {
        // Check if the location exists in panIndiaOverview
        if (amountUtilized.containsKey(location)) {
          // Add the value for the current key and location
          keyValues[location] = amountUtilized[location]![key] ?? 0;
          totalSum += amountUtilized[location]![key] ?? 0;
          if (location == "DPM" || location == "ALR" || location == "BGM" || location == "KDP" || location == "CHA")
            southSum += amountUtilized[location]![key] ?? 0; // ! at end
          else if (location == "MEG" || location == "UMG" || location == "JGR" || location == "LAN")
            neSum = amountUtilized[location]![key] ?? 0;
          else if (location == "CUT" || location == "MED" || location == "BOK" || location == "RAJ" || location == "KAL")
            eastSum = amountUtilized[location]![key] ?? 0;
          else if (location == "NIG" || location == "RAM" || location == "JOW" || location == "NIN" || location == "KOL")
            sugarSum = amountUtilized[location]![key] ?? 0;


        } else {
          // If the location doesn't exist, set the value to 0
          keyValues[location] = 0;
        }

        if (location == "SOUTH")
          keyValues[location] = southSum ?? 0;
        else if (location == "NE")
          keyValues[location] = neSum ?? 0;
        else if (location == "EAST")
          keyValues[location] = eastSum ?? 0;
        else if (location == "CEMENT")
          keyValues[location] = ((southSum ?? 0) + (neSum ?? 0) + (eastSum ?? 0)) ?? 0;
        else if (location == "SUGAR")
          keyValues[location] = sugarSum ?? 0;
        else if (location == "PANIND")
          keyValues[location] = ((southSum ?? 0) + (neSum ?? 0) + (eastSum ?? 0) + (sugarSum ?? 0)) ?? 0;
        else if (location == "TOTAL")
          keyValues[location] = totalSum ?? 0;

      }

      overviewMap[key] = keyValues;
    }

    overviewList.add(overviewMap);
    return overviewList;
  }



  List<dynamic>? convertMapToList(Map<String, dynamic> rhRegions) {
    // var rhRegions = [
    //   {
    //     "SOUTH": {"DPM", "ALR", "BGM", "KDP", "CHA"},
    //     "SUGAR": {"NIG", "RAM", "JOW", "NIN", "KOL"}
    //   }
    // ];
      if (rhRegions.isNotEmpty) {
        var combinedList = <dynamic>[];

        for (var entry in rhRegions.entries) {
          combinedList.addAll(entry.value); // Add values
          combinedList.add(entry.key);      // Add key
        }

        print("Combined List: $combinedList");
        return combinedList;
      } else {
        print("Outer list is empty");
      }
  }



}
