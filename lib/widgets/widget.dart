// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

appbarmain([BuildContext context]) {
  return AppBar(
    title: Center(
      child: Image.asset(
        "assets/images/log.png",
        height: 50,
      ),
    ),
  );
}

InputDecoration textfield(String hinttext) {
  return InputDecoration(
      hintText: hinttext,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      // ignore: prefer_const_constructors
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpletext() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumtext() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
