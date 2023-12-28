import 'dart:convert';
import 'package:dalmia/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp.dart';

class FeedbackApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
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
            'location': location['location'],
            'locationLead': location['locationLead'],
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


  Future<Map<String, String>?> addFeedback(int userId, int recipientId) async {

    print("userId : $userId");
    print("recipientId : $recipientId");

    try {
      String url = '$base/add-feedback?userId=$userId&recipientId=$recipientId';


      final response = await http.post(Uri.parse(url),).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          print("object");
          if (respBody['resp_msg'] != 'Data Found')
            return null;
        }

        if (respBody.containsKey('resp_body')) {
          // final Map<String, String> addFeedbackResMessage = respBody['resp_body'];

          print("addFeedbackResMessage : ${respBody['resp_body']}");

          Map<String, String> hmap = new Map();

          hmap.putIfAbsent('feedbackId', () => respBody['resp_body']['feedbackId'].toString());
          hmap.putIfAbsent('senderId', () => respBody['resp_body']['senderId'].toString());
          hmap.putIfAbsent('recipientId', () => respBody['resp_body']['recipientId'].toString());

          return hmap; // Returning a map with 'clusters' key containing the list
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


  Future<String?> updateFeedback(String userId, String feedbackId, String accepted) async {

    print("userId : $userId");
    print("feedbackId : $feedbackId");
    print("accepted : $accepted");

    try {
      String url = '$base/update-feedback?userId=$userId&feedbackId=$feedbackId&accepted=$accepted';


      final response = await http.put(Uri.parse(url),).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("API Response: ${response.body}");

        // Parse the response and extract regionId and region
        final Map<String, dynamic> respBody = json.decode(response.body);

        if (respBody.containsKey('resp_msg')) {
          print("object");
          if (respBody['resp_msg'] != 'Data Updated') {
            return null;
          }
          else {
            return respBody['resp_msg'];
          }
        }

      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to update Feedback. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('Error making API request: $e');
    }
  }


  Future<bool> sendFeedback(StompClient client, String latestMessage, FeedbackController controller) async {
    try {

      if (client == null && !client.connected) {
        return false;
      }

      // Create a sample JSON object
      Map<String, dynamic> sampleFeedback = {
        'feedbackId': controller.feedbackId,
        'message': latestMessage,
        'accepted': 0,
        'senderId': controller.senderId,
        'recipientId': controller.recipientId
      };

      // Convert the sample object to JSON and send it as a STOMP message
      final message = jsonEncode(sampleFeedback);
      client.send(
        destination: '/feedback/send-feedback',
        body: message,
      );

      return true;
    } catch (e) {
      print("Error sending feedback via STOMP: $e");
      return false;
    }
  }



}
