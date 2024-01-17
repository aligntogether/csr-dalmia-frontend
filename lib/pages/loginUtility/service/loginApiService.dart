import 'dart:convert';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/loginUtility/controller/loginController.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginApiService {


  String? base = dotenv.env['BASE_URL'];
  // String? base = 'https://mobiledevcloud.dalmiabharat.com:443/csr';
  // String? base = 'http://192.168.1.68:8080/csr';



  Future<Map<String, String>> loginViaOtp(int? mobileNumber) async {

    try {
      String url = 'https://mobileqacloud.dalmiabharat.com/dalmiabharat-auth/auth/login_otp';

      Map<String, dynamic> requestBody = {
        "appName": "CSR",
        "appVersion": "1.0.1",
        "brand": "Chrome",
        "platform": "web",
        "deviceOs": "Windows",
        "deviceApiLevel": "1",
        "deviceType": "Chrome",
        "deviceModel": "Chrome",
        "deviceVersionNumber": "117.0.0.0",
        "deviceManufacturer": "Chrome",
        "deviceId": "X/wC8zyiwWvOjrsMHZHoKQ==-chrome-windows",
        "imei": "NA",
        "mobileNumber": "${mobileNumber}"
      };

      final response = await http.post(Uri.parse(url),

          headers: <String, String> {
            'X-AppName': 'ISWEB',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(requestBody)
      ).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("\n API Response: ${response.body} \n");

        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['resp_code'] == 'DM1011') {

        if (jsonData['resp_body'] != null) {
          Map<String, String> hmap = new Map();

          if (jsonData['resp_body'].containsKey('otpTokenId')) {
            hmap.putIfAbsent(
                'otpTokenId', () => jsonData['resp_body']['otpTokenId']!);
          }
          if (jsonData['resp_body'].containsKey('referenceId')) {
            hmap.putIfAbsent(
                'referenceId', () => jsonData['resp_body']['referenceId']!);
          }

          return hmap;
        }
        else {
          print("Failed to get Mobile number : ${response.body}");
          throw Exception('${json.decode(response.body)['resp_msg']}');
        }

      }
        else {
          print("Failed to get Mobile number : ${response.body}");
          throw Exception('${json.decode(response.body)['resp_msg']}');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to get Token ID. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making Login API request: $e");
      throw Exception('${e.toString()}');
    }
  }


  Future<Map<String, String>> checkValidUserOtp(LoginController controller, String? otpCode) async {

    try {
      String url = 'https://mobileqacloud.dalmiabharat.com/dalmiabharat-auth/auth/checkValidUserNewOTP';

      print("controller.referenceId ${controller.referenceId}");
      print("mobileNumber : ${controller.selectMobileController.value.text}");
      print("userId: ${controller.userIdWithTimeStamp}");
      print("otpTokenId: ${controller.otpTokenId}");
      print("code: ${otpCode.toString()}");


      Map<String, dynamic> requestBody = {
      "appName": "CSR",
      "appVersion": "1.0.1",
      "brand": "Chrome",
      "platform": "web",
      "deviceOs": "Windows",
      "deviceApiLevel": "1",
      "deviceType": "Chrome",
      "deviceModel": "Chrome",
      "deviceVersionNumber": "111.0.0.0",
      "deviceManufacturer": "Chrome",
      "deviceId": "X/wC8zyiwWvOjrsMHZHoKQ==-chrome-windows",
      "imei": "NA",
      "referenceId": controller.referenceId,
      "mobileNumber": controller.selectMobileController.value.text,
      "userId": controller.userIdWithTimeStamp,
      "otpTokenId": controller.otpTokenId,
      "code": otpCode.toString(),
        // "referenceId": controller.referenceId,
        // "mobileNumber": controller.selectMobileController.value.text,
        // "userId": controller.userIdWithTimeStamp,
        // "otpTokenId": controller.otpTokenId,
        // "code": otpCode
      };

      final response = await http.post(Uri.parse(url),

          headers: <String, String> {
            'Content-Type': 'application/json',
            'device_os': 'Android',
            'deviceApiLevel': '1',
            'deviceVersionNumber': '2',
            'device_model': '234',
            'device_manufacturer': 'Realme'
          },
          body: jsonEncode(requestBody)
      ).timeout(Duration(seconds: 30));


      if (response.statusCode == 200) {
        print("\n API Response: ${response.body} \n");

        final Map<String, dynamic> jsonData = json.decode(response.body);

        print("\n API jsonData : ${jsonData} \n");


        if (jsonData['resp_body'] != null) {

          Map<String, String> hmap = new Map();

          if (jsonData['resp_body'].containsKey('appName')) {
            hmap.putIfAbsent('appName', () => jsonData['resp_body']['appName']!);
          }

          if (jsonData['resp_body'].containsKey('accessToken')) {
            hmap.putIfAbsent('accessToken', () => jsonData['resp_body']['accessToken']!);
          }

          if (jsonData['resp_body'].containsKey('refreshToken')) {
            hmap.putIfAbsent('refreshToken', () => jsonData['resp_body']['refreshToken']!);
          }

          if (jsonData['resp_body'].containsKey('platform')) {
            hmap.putIfAbsent('platform', () => jsonData['resp_body']['platform']!);
          }

          print("hmap : $hmap");

          return hmap;

        } else {
          throw Exception('Response format does not contain expected data');
        }
      } else {
        print("API Error Response: ${response.body}");
        throw Exception('Failed to get Token ID. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error making Login API request: $e");
      throw Exception('Error making Login API request: $e}');
    }
  }


  Future<Map<String, String>> getUserRoleByReferenceId(String? referenceId) async {

    try {
      String url = '$base/user-type';

      print("\n : url \n" + referenceId!);
      var headers = {
        'accept': '*/*'
      };
      var request = http.Request('GET', Uri.parse('https://mobiledevcloud.dalmiabharat.com/csr/user-type?referenceId=${referenceId}'));


      request.headers.addAll(headers);

      http.StreamedResponse resp = await request.send();

      // final response = await http.get(Uri.parse(url),
      //   headers: <String, String> {
      //     "referenceId": referenceId!
      //   },
      // ).timeout(Duration(seconds: 30));
      String response = await resp.stream.bytesToString();
      print("\n : response ${response} \n");


      if (resp.statusCode == 200) {
        // print("\n \n reAPI Response: ${response.stream.bytesToString()}");

        final Map<String, dynamic> jsonData = json.decode(response);

        print("\n API jsonData : ${jsonData} \n");


        if (jsonData['resp_body'] != null) {

          Map<String, String> hmap = new Map();

          if (jsonData['resp_body'].containsKey('userName')) {
            hmap.putIfAbsent('userName', () => jsonData['resp_body']['userName']!);
          }

          if (jsonData['resp_body'].containsKey('mobileNumber')) {
            hmap.putIfAbsent('mobileNumber', () => jsonData['resp_body']['mobileNumber']!);
          }

          if (jsonData['resp_body'].containsKey('userRole')) {
            hmap.putIfAbsent('userRole', () => jsonData['resp_body']['userRole']!);
          }

          print("hmap hamjdhsfgcna : $hmap");

          return hmap;

        } else {
          throw Exception('${jsonData['resp_body']}');
        }
      } else {
        print("API Error Response: ${resp.statusCode}");
        throw Exception('${json.decode(resp.stream.toString())['resp_msg']}');
      }
    } catch (e) {
      print("Error making API request: $e");
      throw Exception('${e.toString()}');
    }
  }



}
