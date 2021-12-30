// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/authenticate.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/views/chatscreenroom.dart';
import 'package:flutter_chat_app/views/sign_in.dart';
import 'package:flutter_chat_app/views/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getusernameloggedinsharedpreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Easy Chat",
      theme: ThemeData(
          primaryColor: Color(0xff145C9E),
          scaffoldBackgroundColor: Color(0xff1f1f1f),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: userIsLoggedIn != null ? Chatroom() : Authenticate(),
    );
  }
}
