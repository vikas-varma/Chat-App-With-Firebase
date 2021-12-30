// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/Database.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/views/chatscreenroom.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class Signup extends StatefulWidget {
  final Function toggle;
  Signup(this.toggle);

  @override
  _SignupState createState() => _SignupState();
}

bool isloading = false;
Authmethods authMethods = Authmethods();
Databasemethods databasemethods = Databasemethods();

final formkey = GlobalKey<FormState>();

class _SignupState extends State<Signup> {
  TextEditingController usernametexteditcontroller = TextEditingController();
  TextEditingController emailtexteditcontroller = TextEditingController();
  TextEditingController passwordtexteditcontroller = TextEditingController();
  signmeup() {
    if (formkey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernametexteditcontroller.text,
        "email": emailtexteditcontroller.text
      };

      HelperFunction.saveuseremailsharedpreference(
          emailtexteditcontroller.text);
      HelperFunction.saveusernamesharedpreference(
          usernametexteditcontroller.text);

      setState(() {
        isloading = true;
      });
      authMethods
          .signupwithemailandpassword(
              emailtexteditcontroller.text, passwordtexteditcontroller.text)
          .then((val) {
        // print("${val.uid}");

        databasemethods.uploaduserinfo(userInfoMap);
        HelperFunction.saveuserloggedinsharedpreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Chatroom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarmain(),
      body: isloading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : SingleChildScrollView(
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
                                return val.isEmpty || val.length < 3
                                    ? "Please Provide a valid Username"
                                    : null;
                              },
                              controller: usernametexteditcontroller,
                              style: simpletext(),
                              decoration: textfield("username"),
                            ),
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
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please provide password 6+ characters";
                              },
                              controller: passwordtexteditcontroller,
                              style: simpletext(),
                              decoration: textfield(
                                "Password",
                              ),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
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
                          signmeup();
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
                            "Sign up",
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
                          "Sign up with google",
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
                                "Already have an account? ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Sign In now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.underline)),
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
