import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/User1.dart';
import 'package:mobileproject/firebasetakedata.dart';
import 'package:mobileproject/userdetail.dart';
import 'dart:async';
import 'package:mobileproject/users.dart';

class userofficialloca extends StatefulWidget {
  final Userdetail userdetails;
  final User1 cusers;
  final String chatRoomId;

  const userofficialloca({Key key, this.userdetails, this.cusers,this.chatRoomId}) : super(key: key);
  @override
  _userofficiallocaState createState() => _userofficiallocaState();
}

class _userofficiallocaState extends State<userofficialloca> {
  double latituded;
  double longituded;
  TextEditingController _message = new TextEditingController();
  DatabaseMethods firebase = new DatabaseMethods();
  String login_user;
  String chat_user;
  Stream chatMessagesStream;

  @override
  void initState() {
    firebase.loadConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream=value;
      });
    });
    print("here value:"+chatMessagesStream.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            widget.userdetails.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blue,
                    offset: Offset(5.0, 5.0),
                  ),
                ]
            ),
          ),
          flexibleSpace: Image(
            image: AssetImage("assests/dec1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/earth1.jpg"),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: Colors.blueGrey,
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              ChatMesasgeList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 50,
                          width: 300,
                          child: TextField(
                            controller: _message,
                            decoration:InputDecoration(
                              hintText: "Enter a message",
                              hintStyle: TextStyle(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: FlatButton(
                            child: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: sendMessage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

  Widget ChatMesasgeList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        return snapshot.hasData?ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return MessageTile(snapshot.data.docs[index].data()['message'],
                  snapshot.data.docs[index].data()['send by']== widget.cusers.name);
            }): Container();
      },);

  }

  sendMessage() {
    if(_message.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message": _message.text,
        "send by": widget.cusers.name,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      firebase.getConversationMessages(widget.chatRoomId, messageMap);
      _message.text="";

    }
    else {
      print("error messages");
    }


  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 :0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isSendByMe? Colors.blueAccent
              : Colors.white,
          borderRadius: isSendByMe? BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23),
          ):  BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),
        ),
        child: Text(message,
          style: TextStyle(
            fontSize: 17,
          ),),
      ),
    );
  }
}



