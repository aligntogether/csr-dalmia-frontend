import 'dart:convert';
import 'package:http/http.dart' as http;

class FormLogic {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchCasteOptions();
  // }
  static Future<List<dynamic>> fetchCasteOptions() async {
    final String url = 'http://192.168.1.71:8080/dropdown?titleId=105';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> options = data['resp_body'][0]['options'];
        return options;
      } else {
        throw Exception('Failed to load caste options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
