// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/authenticate.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/helper/helperfunction.dart';
import 'package:flutter_chat_app/services/Database.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/views/conversations_screens.dart';
import 'package:flutter_chat_app/views/search.dart';
import 'package:flutter_chat_app/views/sign_in.dart';
import 'package:flutter_chat_app/widgets/widget.dart';

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Authmethods authmethods = Authmethods();
  Databasemethods databasemethods = Databasemethods();
  Stream chatRoomsStream;
  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data["chatroomId"]);
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunction.getusernamesharedpreference();
    databasemethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/images/log.png",
            height: 50,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authmethods.singnout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app_outlined)),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Searchscreen()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.black26),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConversationScreen(chatRoomId)));
            },
            child: Container(
              color: Colors.black26,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(
                      "${userName.substring(0, 1).toUpperCase()}",
                      style: mediumtext(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      userName,
                      style: mediumtext(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
