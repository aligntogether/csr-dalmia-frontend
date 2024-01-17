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

}