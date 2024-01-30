import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LeverWiseApiServices{
  String? base = dotenv.env['BASE_URL'];


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
  Future<Map<String, List<String>>> getRegionLocation(Map<int, String> regions) async {
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



  Future<List<Map<String, Map<String, dynamic>>>> getLeverWiseReport(List<String> allLocations, List<String> objectKeys) async {
    try {
print("i am here");
      String url = '$base/gpl-lever-wise-report';

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));
print("i am here");

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");


        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg') && respBody['resp_msg'] == 'Data Found') {
          final Map<String, dynamic> respData = respBody['resp_body'];

          // Example: Extracting the data for each location
          final Map<String, Map<String, dynamic>> locations = respData.map((location, data) {
            return MapEntry(
              location,
              {
                'Agriculture': data['Agriculture'],
                'Horticulture': data['Horticulture'],
                'Livestock': data['Livestock'],
                'Water': data['Water'],
                'IGA': data['IGA'],
                'Non DIKSHA Skills': data['Non DIKSHA Skills'],
                'Micro Enterprise': data['Micro Enterprice'],

              },
            );
          });


          List<Map<String, Map<String, dynamic>>> leverWiseReportList = await generateLeverWiseReportList(locations, allLocations, objectKeys);

          print("overviewMappedList : $leverWiseReportList");

          if (leverWiseReportList.isEmpty)
            return [];

          return leverWiseReportList; // Returning a map with 'locations' key containing the data
        } else {
          throw Exception('Data not found in the response');
        }
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }

  List<Map<String, Map<String, dynamic>>> generateLeverWiseReportList(
      Map<String, Map<String, dynamic>> leverWiseReport,
      List<String> locations,
      List<String> keys,
      ) {
    List<Map<String, Map<String, dynamic>>> overviewList = [];
    Map<String, Map<String, dynamic>> overviewMap = {};

    // Iterate through each key (e.g., "allotted", "mapped", etc.)
    for (String key in keys) {
      Map<String, dynamic> keyValues = {};
      int southSum = 0;
      int neSum = 0;
      int eastSum = 0;
      int sugarSum = 0;



// Iterate through each location
      for (String location in locations) {
        // Check if the location exists in panIndiaOverview
        if (leverWiseReport.containsKey(location)) {
          // Add the value for the current key and location
          keyValues[location] = leverWiseReport[location]![key] ?? 0;

          if (["Dalmiapuram", "Ariyalur", "Belagaum", "Kadapa", "Chandrapur"]
              .contains(location))
            southSum = leverWiseReport[location]![key] ?? 0;
          else
          if (["Megalaya", "Umrangso", "Jagiroad", "Lanka"].contains(location))
            neSum = leverWiseReport[location]![key] ?? 0;
          else if (["Cuttak", "Medinipur", "Bokaro", "Rajgangpur", "Kholapur"]
              .contains(location))
            eastSum = leverWiseReport[location]![key] ?? 0;
          else if (["Nigohi", "Ramgarh", "Jawaharpur", "Ninaidevi", "Kholapur"]
              .contains(location))
            sugarSum = leverWiseReport[location]![key] ?? 0;
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
          keyValues[location] =
              ((southSum ?? 0) + (neSum ?? 0) + (eastSum ?? 0)) ?? 0;
        else if (location == "SUGAR")
          keyValues[location] = sugarSum ?? 0;
        else if (location == "PANIND")
          keyValues[location] =
              ((southSum ?? 0) + (neSum ?? 0) + (eastSum ?? 0) +
                  (sugarSum ?? 0)) ?? 0;
      }

      overviewMap[key] = keyValues;
    }

      overviewList.add(overviewMap);
    return overviewList;
  }



}