import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

class RhLeverWiseReportServices{


  String? base = dotenv.env['BASE_URL'];



  Future<List<dynamic>> getRegionByRhId(String rhId,String accessId) async {
    try {
      String url = "$base/list-regions-under-user?userId=$rhId";
      print(rhId);

      final response = await http.get(Uri.parse(url),headers: {'X-Access-Token': accessId});
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

  Future<Map<String,dynamic>> getRhLeverWiseReportByRegionId(int  regionId,String accessId) async{
    try{
      String url = "$base/rh-lever-wise-report?regionId=$regionId";
      final response = await http.get(Uri.parse(url),headers: {'X-Access-Token': accessId});
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