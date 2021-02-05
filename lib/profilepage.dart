import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:mobileproject/loginscreen.dart';
import 'package:mobileproject/users.dart';

class profilepage extends StatefulWidget {
  final Users users;

  const profilepage({Key key, this.users}) : super(key: key);
  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  double screenHeight,screenWidth;
  String pathAsset = 'assests/person.png';
  String titlecenter="Loading";
  List userlist;

  @override
  void initState() {
    super.initState();
    _loaduserprofile();
  }
  @override
  Widget build(BuildContext context) {
    return widget.users.name ==null ? Scaffold(
      body: Container(),
    ) :SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Image(
            image: AssetImage("assests/dec1.jpg"),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: Text(
            "USER PROFILE",
            style: TextStyle(
              fontWeight:FontWeight.bold,
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/earth1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl:"http://wxxsspecial983.com/findme/images/userimages/${userlist[0]['userimage']}.jpg" ,
                  fit: BoxFit.cover,
                  placeholder: (context,url)=>
                  new CircularProgressIndicator(),
                  errorWidget: (context,url,error)=>
                  new Icon(
                    Icons.broken_image,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  height: 30,
                  thickness: 1.0,
                  color: Colors.grey[800],
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 390,
                      width: 350,
                      child: new Container(
                        child:Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assests/dec1.jpg"),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 1.0,
                            ),
                            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Name:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(userlist[0]["name"],
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Username:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(userlist[0]["username"],
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Email:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(userlist[0]["email"],
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Your Current Latitude:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(widget.users.latitude,
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Your Current Longitude:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(widget.users.longitude,
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("Your Current Address:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                        width: 390,
                        child: Text(widget.users.address,
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loaduserprofile() {
    http.post("https://wxxsspecial983.com/findme/php/load_user.php",
        body: {
          "email": widget.users.email,
        }).then((res){
      print(res.body);
      if (res.body=="nodata"){
        userlist=null;
        titlecenter="No information found";
      }
      else{
        setState(() {
          var jsondata=json.decode(res.body);
          userlist = jsondata["user"];

        });
      }
    }).catchError((err){
      print(err);
    });
  }

}

