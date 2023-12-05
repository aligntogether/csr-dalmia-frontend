import 'package:dalmia/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  /**
   *  Function to store the user ID using SharedPreferences
   */
  static Future<bool> storeSharedPref(String key, dynamic value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  /**
   *  Function to get the saved SharedPreferences
   */
  static Future<String> getSharedPref(String key, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);

    // If null then redirect to login
    if (value == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext ctx) => Login()),
      );
      throw Exception('Not Logged In');
    }
    return value;
  }
}
