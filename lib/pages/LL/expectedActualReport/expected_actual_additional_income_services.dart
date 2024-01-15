  import 'dart:convert';
  import 'package:dalmia/helper/sharedpref.dart';
  import 'package:dalmia/pages/Accounts/accounthome.dart';
  import 'package:http/http.dart' as http;


  import 'package:flutter_dotenv/flutter_dotenv.dart';

  class ExpectedActualAdditionalIncomeServices {


    String? base = dotenv.env['BASE_URL'];

    // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
    // String? base = 'http://192.168.1.16:8082';


    Future<String> getLocationIdByLocationLeadId(String refId) async {
      try {
        String url = "$base/locations/search/findLocationIdByLocationLead?locationLead=$refId";

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          return data;
        }
        else {
          return "error";
        }
      }
      catch (e) {
        print(e);
      }
      return "error";
    }

    //get location name by location id
    Future<String> getLocationNameByLocationId(String locationId) async {
      try {
        String url = "$base/locations/$locationId";
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          return data['locationCode'];
        }
        else {
          return "error";
        }
      }
      catch (e) {
        print(e);
      }
      return "error";
    }

    Future<Map<String, dynamic>> getExpectedActualAdditionalIncome(
        String locationId) async {
      try {
        String url = "$base/expected-actual-additional-income?locationId=$locationId";

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          var data = body['resp_body'];
         print(data);
          return data;
        }
        else {
          return {'error': 'error'};
        }
      }
      catch (e) {
        print(e);
      }
      return {'error': 'error'};
    }

  }