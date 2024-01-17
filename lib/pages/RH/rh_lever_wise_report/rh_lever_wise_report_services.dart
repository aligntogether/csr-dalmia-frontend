import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RhLeverWiseReportServices{


  String? base = dotenv.env['BASE_URL'];



  Future<List<dynamic>> getRegionByRhId(String rhId) async {
    try {
      String url = "$base/list-regions-under-user?userId=$rhId";
      print(rhId);

      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        print(data['resp_body']);

        return data['resp_body'];
      }
      else {
        return [];
      };

    }
    catch (e) {
      print(e);
    }
    return [];
  }

  Future<Map<String,dynamic>> getRhLeverWiseReportByRegionId(int  regionId) async{
    try{
      String url = "$base/rh-lever-wise-report?regionId=$regionId";
      final response = await http.get(Uri.parse(url));
      print(response);
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
    catch (e){
      print(e);
    }
    return {"error":"Couldn't fetch data"};


  }


}