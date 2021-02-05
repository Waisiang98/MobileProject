import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileproject/User1.dart';
import 'package:mobileproject/Usergroup.dart';
import 'package:mobileproject/firebasetakedata.dart';
import 'package:mobileproject/mainpage.dart';
import 'package:mobileproject/userdetail.dart';
import 'package:mobileproject/userofficialloca.dart';
import 'package:mobileproject/users.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart'as http;
import 'package:toast/toast.dart';

class usergroupdetail extends StatefulWidget {
  final Usergroup usergroup;
  final Users users;

  const usergroupdetail({Key key, this.usergroup, this.users}) : super(key: key);


  @override
  _usergroupdetailState createState() => _usergroupdetailState();
}

class _usergroupdetailState extends State<usergroupdetail> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _searchuser = new TextEditingController();
  List usergrouplist;
  List userlist;
  List seconduserlist;
  List adduserlist;
  double screenHeight,screenWidth;
  String titlecenter="No other member";
  String email;
  String login_user;
  String chat_user;
  String chatRoomId;

  DatabaseMethods firebase = new DatabaseMethods();

  @override
  void initState() {
    super.initState();
    _load_group_user();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Image(
              image: AssetImage("assests/dec1.jpg"),
              fit: BoxFit.cover,
            ),
            title: Text(
              widget.usergroup.groupname,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 24,
                  color: Colors.black,
                  onPressed: () {
                    _addmember();
                  },
                ),
              ),
            ]),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/earth1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              children: [
                Text(
                  "My ID information:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl: "http://wxxsspecial983.com/findme/images/userimages/${widget.users.imagename}.jpg",
                            fit: BoxFit.fill,
                            placeholder: (context,url)=>
                            new CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>
                            new Icon(
                              Icons.broken_image,
                            ),),
                        ),
                        SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name:"+widget.users.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "Email:"+widget.users.email,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Latitude:"+widget.users.latitude,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "Longitude:"+widget.users.longitude,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              width: 190,
                              child: Text(
                                "Address:"+widget.users.address,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Group Members Information:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(
                  height: 40,
                  thickness: 1.0,
                  color: Colors.white,
                ),
                usergrouplist ==null
                    ? Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(titlecenter),),),
                      Container(
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 14,
                          icon: Icon(Icons.refresh),
                          onPressed:() {
                            _load_group_user();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _backprevious,
                        child: Text("back",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),),
                      ),
                    ],
                  ),)
                    : Flexible(
                    child: GridView.count(crossAxisCount: 1,
                      childAspectRatio: (screenWidth/screenHeight)/0.3,
                      children: List.generate(usergrouplist.length, (index){
                        return Padding(
                          padding: EdgeInsets.all(0.8),
                          child: SingleChildScrollView(
                            child: Card(
                              child:InkWell(
                                onTap: ()=> _Inmemberdetail(index),
                                child: Row(
                                  children: [
                                    Container(
                                      height: screenHeight/5.0,
                                      width: screenWidth/2.3,
                                      child: CachedNetworkImage(
                                        imageUrl:"http://wxxsspecial983.com/findme/images/userimages/${usergrouplist[index]['userImageName']}.jpg" ,
                                        fit: BoxFit.fill,
                                        placeholder: (context,url)=>
                                        new CircularProgressIndicator(),
                                        errorWidget: (context,url,error)=>
                                        new Icon(
                                          Icons.broken_image,
                                          size: screenWidth/3,
                                        ),),),
                                    SizedBox(height:10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name:"+usergrouplist[index]['userName'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Email:"+usergrouplist[index]['userEmail'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                        Container(
                                          width: 190,
                                          child: Text("Address:"+usergrouplist[index]['address'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightBlueAccent),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
              ]
          ),
        ),
      ),
    );
  }

  void _addmember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AlertDialog(
                backgroundColor: Colors.white,
                title: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: new Text(
                      "Add a new member? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                content: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        child: new FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                          color: Colors.white,
                          child: new Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            searchaddmember();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 70,
                        child: new FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                          color: Colors.white,
                          child: new Text(
                            "No",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _load_group_user() {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Opening...');

    http.post("https://wxxsspecial983.com/findme/php/load_group_user.php",
        body: {
          "email":widget.usergroup.email,
          "groupid":widget.usergroup.id,
        }).then((res){
      print(res.body);
      if (res.body =="nodata"){
        Toast.show(
          "No Result Found",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
      else {
        setState(() {
          var jsondata=json.decode(res.body);
          usergrouplist = jsondata["usergroup"];
          Toast.show(
            "Members Found",context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
          );
        });
      }
    }).catchError((err){
      print(err);
    });

  }

  void _backprevious() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>mainpage()));
  }

  _Inmemberdetail(int index) {
    Userdetail userdetails = new Userdetail(
      name: usergrouplist[index]['userName'],
      email: usergrouplist[index]['userEmail'],
      latitude: usergrouplist[index]['latitude'],
      longitude: usergrouplist[index]['longitude'],
      address: usergrouplist[index]['address'],
    );
    User1 cusers = new User1(
        name: widget.users.name
    );

    login_user = widget.users.name;
    chat_user = usergrouplist[index]['userName'];

    print("Here:"+login_user);
    print("Here:"+ chat_user);

    if (login_user != chat_user){
      chatRoomId = getChatRoomId(login_user,chat_user);

      List<String> different_users = [login_user,chat_user];
      Map<String, dynamic> chatRoommap = {
        "users": different_users,
        "chatidRoom": chatRoomId,
      };
      firebase.createChatRoom(chatRoomId,chatRoommap);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>userofficialloca(cusers: cusers,userdetails:userdetails, chatRoomId: chatRoomId ,)));
    }
    else{
      Toast.show(
        "You Cannot Chat to yourselves",context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
    }
  }

  void searchaddmember() {
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: StatefulBuilder(
            builder: (context, newSetState) {
              return AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  title: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text("Enter a User Email",
                          style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 330,
                          color: Colors.white60,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 180,
                                        child: TextFormField(
                                          controller: _searchuser,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: 'User Email',
                                            border: OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(15.0),
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white70,
                                          ),
                                          validator: validateGroupName.validate,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        child: new FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.blueGrey)
                                          ),
                                          color: Colors.white,
                                          child: new Text(
                                            "Search",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            _beforesearch(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => {Navigator.pop(context)},
                                    child: Center(
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ));
            },
          ),
        );
      },
    );
  }

  void _beforesearch(context) {
    _validate(context);

  }
  bool _validate(context) {
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      Navigator.pop(context);
      _officialsearch();
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> _officialsearch() async {
    email=_searchuser.text;

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("https://wxxsspecial983.com/findme/php/load_user.php",
        body: {
          "email": email,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        seconduserlist = null;
        titlecenter = "No User Found";
        Toast.show(
          "No User Found",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          //user
          seconduserlist = jsondata["user"];
          Toast.show(
            "User search found. ",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          Navigator.of(context).pop();
          showuserresult();
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void showuserresult() {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: ( context) {
        return StatefulBuilder(
            builder: (context, newSetState){
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Center(
                  child: Container(
                    child: Text("User Result Found:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                content: seconduserlist ==null
                    ? Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(titlecenter),),),
                      Container(
                        child: IconButton(
                          color: Colors.black,
                          iconSize: 14,
                          icon: Icon(Icons.refresh),
                          onPressed:() {
                            _load_group_user();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _backprevious,
                        child: Text("back",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),),
                      ),
                    ],
                  ),)
                    : Flexible(
                  child: Container(
                    width: double.maxFinite,
                    child: GridView.count(crossAxisCount: 1,
                      childAspectRatio: (screenWidth/screenHeight)/0.25,
                      children: List.generate(seconduserlist.length, (index){
                        return Padding(
                          padding: EdgeInsets.all(0.5),
                          child: SingleChildScrollView(
                            child: Card(
                              child:Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assests/dec1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                    width: 1.0,
                                  ),
                                  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => {
                                    _agreeaddmember(index, context),
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                          imageUrl:"http://wxxsspecial983.com/findme/images/userimages/${seconduserlist[index]['userimage']}.jpg" ,
                                          fit: BoxFit.fill,
                                          placeholder: (context,url)=>
                                          new CircularProgressIndicator(),
                                          errorWidget: (context,url,error)=>
                                          new Icon(
                                            Icons.broken_image,
                                            size: screenWidth/3,
                                          ),),
                                      ),
                                      SizedBox(width:5),
                                      Column(
                                        children: [
                                          Text("Name:"+seconduserlist[index]['name'],style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  _agreeaddmember(int index, context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: new Text(
                "Agree to add:"+seconduserlist[index]['name'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                child: new FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.blue,
                  child: new Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _add(index, context);
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 70,
                child: new FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.white,
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _add(int index, context) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Adding...');

    print("here the data is:"+seconduserlist[index]['email']);

    http.post("https://wxxsspecial983.com/findme/php/load_new_group_user.php",
        body: {
          "email":seconduserlist[index]['email'],
        }).then((res){
      if (res.body =="nodata"){
        Toast.show(
          "No Result Found",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
      else {
        var jsondata=json.decode(res.body);
        adduserlist = jsondata["adduser"];
        print(res.body);
        http.post("https://wxxsspecial983.com/findme/php/add_group_user.php",
            body: {
              "email":adduserlist[index]["useremail"],
              "username": adduserlist[index]["username"],
              "groupid": usergrouplist[index]["groupId"],
              "groupimage": usergrouplist[index]["groupimage"],
              "password": usergrouplist[index]["grouppassword"],
              "groupname": usergrouplist[index]["groupname"],
            }).then((res){
          print(res.body);
          if (res.body =="success"){
            Toast.show(
              "User Added Succesfully",context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
            );
            Navigator.of(context).pop();
          }
          else {
            Toast.show(
              "Fail User Add",context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
            );
            Navigator.of(context).pop();
          }
        }).catchError((err){
          print(err);
        });
      }
    }).catchError((err){
      print(err);
    });


  }

  getChatRoomId(String a, String b) {
    if (a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }
    else {
      return "$a\_$b";
    }
  }


}

class validateGroupName {
  static String validate(String groupname){
    if(groupname.isEmpty){
      return "Empty cannot be empty";
    }
    return null;
  }
}
