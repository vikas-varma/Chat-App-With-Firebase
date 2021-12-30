// ignore_for_file: use_key_in_widget_constructors, missing_return, empty_statements, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/views/sign_in.dart';
import 'package:flutter_chat_app/views/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  toggleView() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return Signin(toggleView);
    } else {
      return Signup(toggleView);
    }
  }
}
