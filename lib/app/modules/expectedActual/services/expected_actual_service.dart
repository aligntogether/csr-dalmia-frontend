import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/Accounts/accounthome.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExpectedActualServices {


  String? base = dotenv.env['BASE_URL'];

  // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.16:8082';


  Future<Map<String, dynamic>> getExpectedActualIncomeReport() async {
    try {
      String url = "$base/gpl-exp-act-additional-income";

      final response = await http.get(Uri.parse(url));
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



}