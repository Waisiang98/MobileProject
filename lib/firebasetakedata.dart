import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserInfo(String username){
    FirebaseFirestore.instance.collection("Users").where("name", isEqualTo: username)
        .get();
  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("Users")
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }
  createChatRoom(String chatroomid, chatroommap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatroomid).set(chatroommap).
    catchError((e){
      print(e.toString());
    });
  }
  getConversationMessages(String chatroomid, messageMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomid).collection("chats").add(messageMap).
    catchError((e){
      print("got problem here");
    });
  }

  loadConversationMessages(String chatroomid) async {
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomid).collection("chats").orderBy("time",descending: false).snapshots();
  }
}