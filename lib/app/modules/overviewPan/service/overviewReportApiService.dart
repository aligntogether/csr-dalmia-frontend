import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class OverviewReportApiService {
  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';

  Future<Map<String, dynamic>> getListOfRegions() async {
    try {
      String url = '$base/list-regions';

      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response manav: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> regionsData = respBody['resp_body'];

          final List<Map<String, dynamic>> regions = regionsData
              .map<Map<String, dynamic>>((region) => {
                    'regionId': region['regionId'],
                    'region': region['region'],
                    'rhId': region['rhId'],
                  })
              .toList();

          Map<String, dynamic> newMap = new Map<String, dynamic>();

          newMap.putIfAbsent("regionId", () => 1001);
          newMap.putIfAbsent("region", () => "All Regions");
          newMap.putIfAbsent("rhId", () => "0000");
          regions.add(newMap);

          return {
            'regions': regions
          }; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }

  Future<Map<String, dynamic>> getListOfLocations(int regionId) async {
    try {
      final response =
          await http.get(Uri.parse('$base/list-locations?regionId=$regionId'));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_body')) {
          final List<dynamic> locationsData = respBody['resp_body'];

          print("Object3");

          final List<Map<String, dynamic>> locations = locationsData
              .map<Map<String, dynamic>>((location) => {
                    'locationId': location['locationId'],
                    'location': location['location'],
                    'locationCode': location['locationCode']
                  })
              .toList();

          return {
            'locations': locations
          }; // Returning a map with 'regions' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }

  Future<Map<String, dynamic>?> getListOfClusters(int locationId) async {
    try {
      String url = '$base/list-cluster-by-location?locationId=$locationId';

      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

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

          final List<Map<String, dynamic>> clusters = clustersData
              .map<Map<String, dynamic>>((cluster) => {
                    'clusterId': cluster['clusterId'],
                    'clusterName': cluster['clusterName'],
                    'vdfName': cluster['vdfName'],
                  })
              .toList();

          print("sgncy $clusters");

          return {
            'clusters': clusters
          }; // Returning a map with 'clusters' key containing the list
        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }

  Future<String> validateDuplicatePanchayat(
      int clusterId, String panchayatName, String panchayatCode) async {
    try {
      String url =
          '$base/validate-duplicate-panchayat?clusterId=$clusterId&panchayatName=$panchayatName&panchayatCode=$panchayatCode';

      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

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
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }

  Future<String> replaceVdf(int clusterId, String vdfName) async {
    try {
      String url =
          '$base/replace-vdf-for-cluster?clusterId=$clusterId&vdfName=$vdfName';

      final response =
          await http.put(Uri.parse(url)).timeout(Duration(seconds: 30));

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
        throw Exception(
            'Failed to add panchayat. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }

  late List<Map<String, Map<String, dynamic>>> overviewMappedList;
  Future<List<Map<String, Map<String, dynamic>>>> getPanIndiaReport(
      List<String> allLocations, List<String> objectKeys) async {
    try {
      String url = '$base/pan-india-report';

      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg') &&
            respBody['resp_msg'] == 'Data Found') {
          final Map<String, dynamic> respData = respBody['resp_body'];

          // Example: Extracting the data for each location
          final Map<String, Map<String, dynamic>> locations =
              respData.map((location, data) {
            return MapEntry(
              location,
              {
                'allotted': data['allotted'],
                'mapped': data['mapped'],
                'selected': data['selected'],
                'hhCovered': data['hhCovered'],
                'planned': data['planned'],
                'completed': data['completed'],
                'householdWithAtLeast1Completed':
                    data['householdWithAtLeast1Completed'],
                'noInterventionPlanned': data['noInterventionPlanned'],
                'followupOverdue': data['followupOverdue'],
                'zeroAdditionalIncome': data['zeroAdditionalIncome'],
                'lessThan25KIncome': data['lessThan25KIncome'],
                'between25KTO50KIncome': data['between25KTO50KIncome'],
                'between50KTO75KIncome': data['between50KTO75KIncome'],
                'between75KTO1LIncome': data['between75KTO1LIncome'],
                'moreThan1LIncome': data['moreThan1LIncome'],
              },
            );
          });

          overviewMappedList =
              await generateOverviewList(locations, allLocations, objectKeys);

          print("overviewMappedList : $overviewMappedList");

          if (overviewMappedList.isEmpty) return [];

          return overviewMappedList; // Returning a map with 'locations' key containing the data
        } else {
          throw Exception('Data not found in the response');
        }
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }

  List<Map<String, Map<String, dynamic>>> overViewMappedListFun() {
    return overviewMappedList;
  }

  Future<List<Map<String, Map<String, dynamic>>>> getRegionWiseReport(
      List<String> allLocations, List<String> objectKeys, int regionId) async {
    try {
      String url = '$base/region-wise-report?regionId=$regionId';

      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg') &&
            respBody['resp_msg'] == 'Data Found') {
          final Map<String, dynamic> respData = respBody['resp_body'];

          // Example: Extracting the data for each location
          final Map<String, Map<String, dynamic>> locations =
              respData.map((location, data) {
            return MapEntry(
              location,
              {
                'allotted': data['allotted'],
                'mapped': data['mapped'],
                'selected': data['selected'],
                'hhCovered': data['hhCovered'],
                'planned': data['planned'],
                'completed': data['completed'],
                'householdWithAtLeast1Completed':
                    data['householdWithAtLeast1Completed'],
                'noInterventionPlanned': data['noInterventionPlanned'],
                'followupOverdue': data['followupOverdue'],
                'zeroAdditionalIncome': data['zeroAdditionalIncome'],
                'lessThan25KIncome': data['lessThan25KIncome'],
                'between25KTO50KIncome': data['between25KTO50KIncome'],
                'between50KTO75KIncome': data['between50KTO75KIncome'],
                'between75KTO1LIncome': data['between75KTO1LIncome'],
                'moreThan1LIncome': data['moreThan1LIncome'],
              },
            );
          });

          List<Map<String, Map<String, dynamic>>> overviewMappedList =
              await generateOverviewList(locations, allLocations, objectKeys);

          print("overviewMappedList : $overviewMappedList");

          if (overviewMappedList.isEmpty) return [];

          return overviewMappedList; // Returning a map with 'locations' key containing the data
        } else {
          throw Exception('Data not found in the response');
        }
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error making API request: $e');
    }
  }

  List<Map<String, Map<String, dynamic>>> generateOverviewList(
    Map<String, Map<String, dynamic>> panIndiaOverview,
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

      var allLocations = [
        "DPM",
        "ALR",
        "BGM",
        "KDP",
        "CHA",
        "SOUTH",
        "MEG",
        "UMG",
        "JGR",
        "LAN",
        "NE",
        "CUT",
        "MED",
        "BOK",
        "RAJ",
        "KAL",
        "EAST",
        "CEMENT",
        "NIG",
        "RAM",
        "JOW",
        "NIN",
        "KOL",
        "SUGAR",
        "PANINDIA"
      ];

      // Iterate through each location
      for (String location in locations) {
        // Check if the location exists in panIndiaOverview
        if (panIndiaOverview.containsKey(location)) {
          // Add the value for the current key and location
          keyValues[location] = panIndiaOverview[location]![key] ?? 0;
          if (location == "DPM" ||
              location == "ALR" ||
              location == "BGM" ||
              location == "KDP" ||
              location == "CHA")
            southSum = panIndiaOverview[location]![key] ?? 0;
          else if (location == "MEG" ||
              location == "UMG" ||
              location == "JGR" ||
              location == "LAN")
            neSum = panIndiaOverview[location]![key] ?? 0;
          else if (location == "CUT" ||
              location == "MED" ||
              location == "BOK" ||
              location == "RAJ" ||
              location == "KAL")
            eastSum = panIndiaOverview[location]![key] ?? 0;
          else if (location == "NIG" ||
              location == "RAM" ||
              location == "JOW" ||
              location == "NIN" ||
              location == "KOL")
            sugarSum = panIndiaOverview[location]![key] ?? 0;
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
          keyValues[location] = ((southSum ?? 0) +
                  (neSum ?? 0) +
                  (eastSum ?? 0) +
                  (sugarSum ?? 0)) ??
              0;
      }

      overviewMap[key] = keyValues;
    }

    overviewList.add(overviewMap);
    return overviewList;
  }
}
