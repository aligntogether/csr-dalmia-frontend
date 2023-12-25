import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/pages/loginUtility/page/login.dart';
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
  static Future<String> getSharedPref(
      String key, BuildContext context, bool redirect) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);

    // If null then redirect to login
    if (value == null && redirect) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext ctx) => Login()),
      );
      throw Exception('Not Logged In');
    }
    return value == null ? "" : value;
  }

  static clearSharedPrefAccess() async {
    var keysToClear = [
      USER_ID_SHAREDPREF_KEY,
      ACCESS_TOKEN_SHAREDPREF_KEY,
      REFRESH_TOKEN_SHAREDPREF_KEY,
      USER_TYPES_SHAREDPREF_KEY
    ];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    keysToClear.forEach((element) {
      prefs.remove(element);
    });
  }
}
