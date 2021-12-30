// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables, unused_local_variable, unnecessary_string_escapes, non_constant_identifier_names, unnecessary_string_interpolations, unused_element, unnecessary_brace_in_string_interps, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/Database.dart';
import 'package:flutter_chat_app/views/conversations_screens.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

String _myName;

class _SearchscreenState extends State<Searchscreen> {
  Databasemethods databasemethods = Databasemethods();
  TextEditingController searchtexteditingcontoller = TextEditingController();
  QuerySnapshot searchsnapshot;

  Widget searchList() {
    return searchsnapshot != null
        ? ListView.builder(
            itemCount: searchsnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Searchtile(
                userName: searchsnapshot.documents[index].data["name"],
                userEmail: searchsnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }

  initiatesearch() {
    databasemethods
        .getuserbyusername(searchtexteditingcontoller.text)
        .then((val) {
      setState(() {
        searchsnapshot = val;
      });
    });
  }

  createchatroomandstartconversatiom({
    String userName,
  }) {
    print("${Constants.myName}");
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      Databasemethods().createchatroom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print("you cannot send message to yourself");
    }
  }

  Widget Searchtile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              userName,
              style: simpletext(),
            ),
            Text(
              userEmail,
              style: simpletext(),
            )
          ]),
          Spacer(),
          GestureDetector(
            onTap: () {
              createchatroomandstartconversatiom(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarmain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54ffffff),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchtexteditingcontoller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "search username...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiatesearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0x36ffffff),
                              const Color(0x0fffffff)
                            ]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
