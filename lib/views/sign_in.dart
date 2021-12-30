// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/Database.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

import 'chatscreenroom.dart';

class Signin extends StatefulWidget {
  final Function toggle;
  Signin(this.toggle);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();
  Authmethods authmethods = Authmethods();
  Databasemethods databasemethods = Databasemethods();
  TextEditingController emailtexteditcontroller = TextEditingController();
  TextEditingController passwordtexteditcontroller = TextEditingController();
  bool isloding = false;
  QuerySnapshot snapshotuserinfo;
  signIn() {
    if (formkey.currentState.validate()) {
      HelperFunction.saveuseremailsharedpreference(
          emailtexteditcontroller.text);
      databasemethods
          .getuserbyuseremail(emailtexteditcontroller.text)
          .then((val) {
        snapshotuserinfo = val;
        HelperFunction.saveusernamesharedpreference(
            snapshotuserinfo.documents[0].data["name"]);
        // print("${snapshotuserinfo.documents[0].data["name"]}");
      });

      setState(() {
        isloding = true;
      });

      authmethods.Signinwithemailandpassword(
              emailtexteditcontroller.text, passwordtexteditcontroller.text)
          .then((val) {
        if (val != null) {
          HelperFunction.saveuserloggedinsharedpreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Chatroom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarmain(),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Please Provide a valid emailid";
                        },
                        controller: emailtexteditcontroller,
                        style: simpletext(),
                        decoration: textfield("Email"),
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.length > 6
                              ? null
                              : "Please provide password 6+ characters";
                        },
                        controller: passwordtexteditcontroller,
                        obscureText: true,
                        style: simpletext(),
                        decoration: textfield("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text(
                      "Forgot Password?",
                      style: simpletext(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Sign In With Google",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("Register now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            )),
      ),
    );
  }
}
