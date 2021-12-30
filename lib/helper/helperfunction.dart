// ignore_for_file: unused_import, await_only_futures

import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedpreferenceloggedinkey = "ISLOGGEDIN";
  static String sharedpreferencenamedkey = "USERNAMEKEY";
  static String sharedpreferenceemailkey = "USEREMAILKEY";

  static Future<bool> saveuserloggedinsharedpreference(
      bool isuserloggedin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreferenceloggedinkey, isuserloggedin);
  }

  static Future<void> saveusernamesharedpreference(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferencenamedkey, username);
  }

  static Future<bool> saveuseremailsharedpreference(String useremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferencenamedkey, useremail);
  }

  static Future<bool> getusernameloggedinsharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedpreferenceloggedinkey);
  }

  static Future<String> getusernamesharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferencenamedkey);
  }

  static Future<String> getuseremailsharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedpreferenceemailkey);
  }
}
