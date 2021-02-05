import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproject/Usergroup.dart';
import 'package:mobileproject/loginscreen.dart';
import 'package:mobileproject/profilepage.dart';
import 'package:mobileproject/user.dart';
import 'package:mobileproject/user.dart';
import 'package:mobileproject/userdetail.dart';
import 'package:mobileproject/usergroupdetail.dart';
import 'package:mobileproject/users.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart'as http;
import 'package:toast/toast.dart';

class mainpage extends StatefulWidget {
  final User user;
  final Users users;
  final Usergroup usergroup;
  final Userdetail userdetail;

  const mainpage({Key key, this.user, this.users, this.usergroup, this.userdetail}) : super(key: key);
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  File _image;
  int value;
  String pathAsset = 'assests/groupimage.png';
  TextEditingController _groupname = TextEditingController();
  TextEditingController _groupID = TextEditingController();
  TextEditingController _joinpassword = TextEditingController();
  TextEditingController _searchID = TextEditingController();
  double screenHeight,screenWidth;
  String groupname,groupid,joinpassword,email;
  String titlecenter="Loading";
  List grouplist;
  List usergrouplist;
  String _homeloc = "searching...";
  Position _currentPosition;
  String gmaploc="";
  double latitude;
  double longitude;
  Set<Marker> markers = Set();
  MarkerId markerId1 = MarkerId("12");
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController gmcontroller;


  TextEditingController _search = TextEditingController();

  @override
  initState()  {
    super.initState();
    _getLocation();
    getgrouplist();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Group List",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 10.0,
                    offset: Offset(-5.0, 5.0),
                  ),
                  Shadow(
                    color: Colors.red,
                    blurRadius: 10.0,
                    offset: Offset(-5.0, 5.0),
                  ),
                ]
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Image(
            image: AssetImage("assests/dec1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        drawer: Drawer(
          child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assests/drawer1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Flexible(
                  child: Card(
                    shadowColor: Colors.blueGrey,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assests/dec1.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child:CachedNetworkImage(
                              imageUrl:"http://wxxsspecial983.com/findme/images/userimages/${widget.user.imagename}.jpg" ,
                              fit: BoxFit.cover,
                              placeholder: (context,url)=>
                              new CircularProgressIndicator(),
                              errorWidget: (context,url,error)=>
                              new Icon(
                                Icons.broken_image,
                                size: screenWidth/3,
                              ),),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ) ,),
                                  Text(widget.user.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.red,
                                            blurRadius: 10.0,
                                            offset: Offset(-5.0, 5.0),
                                          ),
                                        ]
                                    ) ,)

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Latitude :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ) ,),
                                  Container(
                                    width: 100,
                                    child: Text(latitude.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.red,
                                              blurRadius: 10.0,
                                              offset: Offset(-5.0, 5.0),
                                            ),
                                          ]
                                      ) ,),
                                  )

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Longitude :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ) ,),
                                  Container(
                                    width: 100,
                                    child: Text(longitude.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.red,
                                              blurRadius: 10.0,
                                              offset: Offset(-5.0, 5.0),
                                            ),
                                          ]
                                      ) ,),
                                  )

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                    child: InkWell(
                        onTap: homepage,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assests/dec1.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 40,
                                ),
                                Text("Home Page",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue,
                                          blurRadius: 10.0,
                                          offset: Offset(-5.0, 5.0),
                                        ),
                                      ]
                                  ),),
                              ],
                            )))),
                Card(
                    child: InkWell(
                        onTap: beforesearch,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assests/dec1.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 40,
                                ),
                                Text("Search Group",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue,
                                          blurRadius: 10.0,
                                          offset: Offset(-5.0, 5.0),
                                        ),
                                      ]
                                  ),),
                              ],
                            )))),
                Card(
                    child: InkWell(
                        onTap: _creategroup,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assests/dec1.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                                Text("Create Group",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue,
                                          blurRadius: 10.0,
                                          offset: Offset(-5.0, 5.0),
                                        ),
                                      ]
                                  ),),
                              ],
                            )))),
                Card(
                    child: InkWell(
                        onTap: _userprofile,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assests/dec1.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_rounded,
                                  size: 40,
                                ),
                                Text("My Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue,
                                          blurRadius: 10.0,
                                          offset: Offset(-5.0, 5.0),
                                        ),
                                      ]
                                  ),),
                              ],
                            )))),
                Card(
                    child: InkWell(
                        onTap: _signout,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assests/dec1.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              ),
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.outbond_outlined,
                                  size: 40,
                                ),
                                Text("Sign out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blue,
                                          blurRadius: 10.0,
                                          offset: Offset(-5.0, 5.0),
                                        ),
                                      ]
                                  ),),
                              ],
                            )))),
              ],
            ),
          ),

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/earth1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              grouplist ==null
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
                          getgrouplist();
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: getgrouplist,
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
                    childAspectRatio: (screenWidth/screenHeight)/0.25,
                    children: List.generate(grouplist.length, (index){
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
                                onLongPress: () => {
                                  _deletegroup(index,context)
                                },
                                onTap: ()=> _Ingroup(index),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blueGrey,
                                          width: 1.0,
                                        ),
                                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      height: screenHeight/5.0,
                                      width: screenWidth/2.3,
                                      child: new CachedNetworkImage(
                                        imageUrl:"http://wxxsspecial983.com/findme/images/groupimages/${grouplist[index]['groupimage']}.jpg" ,
                                        fit: BoxFit.cover,
                                        placeholder: (context,url)=>
                                        new CircularProgressIndicator(),
                                        errorWidget: (context,url,error)=>
                                        new Icon(
                                          Icons.broken_image,
                                          size: screenWidth/3,
                                        ),),),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Group ID :",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                            Text(grouplist[index]['groupid'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.red,
                                                      blurRadius: 10.0,
                                                      offset: Offset(-5.0, 5.0),
                                                    ),
                                                  ]),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Group Name :",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                            Text(grouplist[index]['groupname'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.red,
                                                      blurRadius: 10.0,
                                                      offset: Offset(-5.0, 5.0),
                                                    ),
                                                  ]),),
                                          ],
                                        ),
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
                  )),
            ],
          ),
        ),




      ),
    );
  }

  void _userprofile() {
    Users users = new Users(
      username: widget.user.username,
      email:widget.user.email,
      name: widget.user.name,
      password:widget.user.password,
      longitude: longitude.toString(),
      latitude: latitude.toString(),
      address: _homeloc,
      imagename: widget.user.imagename,

    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>profilepage(users:users,)));

  }

  Future <void> _searchgroup(String text)async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("https://wxxsspecial983.com/findme/php/search_group.php",
        body: {
          "groupid": text,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        grouplist = null;
        setState(() {
          titlecenter = "No Group Found";
        });
        Toast.show(
          "Search found no result",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          grouplist = jsondata["group"];
          Toast.show(
            "Groups search found. ",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }



  void _creategroup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
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
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 60,
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
                      child: Center(
                        child: Text(
                          "Create a new Group? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
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
                              side: BorderSide(color: Colors.blueGrey)
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
                            onCreate();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 70,
                        child: new FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueGrey)
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


  void onCreate() {
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
                    child: Text("Create a new Group",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height:450,
                          width: 330,
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
                          child: Stack(
                            children: [
                              SizedBox(height: 5),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => {_onPictureSelection(newSetState)},
                                    child: Center(
                                      child: Container(
                                        height: screenHeight/3.6,
                                        width: screenWidth/1.8,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _image==null
                                                  ?AssetImage(pathAsset)
                                                  :FileImage(_image),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                              width: 3.0,
                                              color: Colors.redAccent,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 180,
                                        child: TextFormField(
                                          controller: _groupname,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText: 'Group Name',
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
                                  Container(
                                    height: 35,
                                    width: 180,
                                    child: TextFormField(
                                      controller: _groupID,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                        ),
                                        hintText: 'Group ID',
                                        filled: true,
                                        fillColor: Colors.white70,
                                      ),
                                      validator: validateGroupID.validate,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 35,
                                    width: 180,
                                    child: TextFormField(
                                      controller: _joinpassword,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                        ),
                                        hintText: 'Password To Join',
                                        filled: true,
                                        fillColor: Colors.white70,
                                      ),
                                      validator: validatePassword.validate,
                                    ),
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
                                            "Create",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            _beforecreate(context);
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
                                          fontSize: 12,
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

  _onPictureSelection(newSetState) {
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: new Container(
            height: screenHeight/4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Take picture from:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)
                          ),),
                        minWidth: 100,
                        height:60,
                        child: Container(
                          child: Text('Camera',
                            style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: ()=> {Navigator.pop(context),_chooseCamera(newSetState)},
                      ),
                    ),
                    SizedBox(width:10),
                    Flexible(
                        child: MaterialButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          minWidth: 100,
                          height:60,
                          child: Text('Gallery',
                            style: TextStyle(
                              color:Colors.black,
                            ),),
                          textColor: Colors.black,
                          elevation: 10,
                          onPressed: ()=> {Navigator.pop(context),_chooseGallery(newSetState)},
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },);

  }
  void _officialcreate(context) {
    groupname=_groupname.text;
    groupid=_groupID.text;
    joinpassword=_joinpassword.text;
    String base64Image= base64Encode(_image.readAsBytesSync());

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Creating...');

    http.post("https://wxxsspecial983.com/findme/php/locationgroup.php",
        body: {
          "username": widget.user.username,
          "email":widget.user.email,
          "groupname":groupname,
          "groupid":groupid,
          "joinpassword":joinpassword,
          "encoded_string":base64Image,
          "imagename":widget.user.username+groupname,
        }).then((res){
      print(res.body);
      if (res.body =="success"){
        Toast.show(
          "Group Created Success",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Navigator.pop(context);
      }
      else {
        Toast.show(
          "Group Created fail",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
    }).catchError((err){
      print(err);
    });

  }

  void _chooseCamera(newSetState)async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera,maxHeight: 800, maxWidth: 800);
    _cropImage(newSetState);
    newSetState(() {
    });
  }
  void _chooseGallery(newSetState) async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage(newSetState);
    newSetState(() {
    });
  }
  Future <Null>_cropImage(newSetState) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ?[
          CropAspectRatioPreset.square,
        ]
            :[
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.indigoAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title:'Cropper',));
    if (croppedFile !=null){
      _image=croppedFile;
      newSetState(() {
      });
    }
  }


  bool _validate(context) {
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      _officialcreate(context);
      return true;
    }
    else{
      return false;
    }
  }

  void _beforecreate(context) {
    if (_image == null) {
      Toast.show("Group picture empty!.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      _validate(context);
      return;
    }
    _validate(context);
  }

  Future <void> getgrouplist()async {
    http.post("https://wxxsspecial983.com/findme/php/load_group.php",
        body: {
          "email": widget.user.email,
        }).then((res){
      print(widget.user.email);
      print(res.body);
      if (res.body=="nodata"){
        grouplist=null;
        titlecenter="You haven't join any group yet";
      }
      else{
        setState(() {
          var jsondata=json.decode(res.body);
          grouplist = jsondata["group"];

        });
      }
    }).catchError((err){
      print(err);
    });

  }

  _Ingroup(int index) {
    print("check");
    print(grouplist[index]['groupid']);
    print(widget.user.username);
    http.post("https://wxxsspecial983.com/findme/php/in_group.php",
        body: {
          "username": widget.user.username,
          "email":widget.user.email,
          "groupid": grouplist[index]['groupid'],
        }).then((res){
      print(res.body);
      if (res.body =="success"){
        Users users = new Users(
          name: widget.user.name,
          imagename: widget.user.imagename,
          email: widget.user.email,
          latitude: latitude.toString(),
          longitude: longitude.toString(),
          address: _homeloc,
        );
        Usergroup usergroup = new Usergroup(
          email: grouplist[index]["email"],
          id: grouplist[index]["groupid"],
          groupname: grouplist[index]["groupname"],
          image: grouplist[index]["groupimage"],
        );
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>usergroupdetail(usergroup:usergroup,users:users)));
      }
      else {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AlertDialog(
                  backgroundColor: Colors.white,
                  title: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assests/dec1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "You are not this group member yet. ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Do you want to join? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
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
                                side: BorderSide(color: Colors.blueGrey)
                            ),
                            color: Colors.white,
                            child: new Text(
                              "Join",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              beforejoin(index);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 70,
                          child: new FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blueGrey)
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
            );
          },
        );
      }
    }).catchError((err){
      print(err);
    });

  }

  void beforejoin(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey1,
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
                      child: Text("Please Enter Password:",
                          style: TextStyle(color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 330,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assests/dec1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 180,
                                    child: TextFormField(
                                      controller: _joinpassword,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                        ),
                                        hintText: 'Password To Join',
                                        filled: true,
                                        fillColor: Colors.white70,
                                      ),
                                      validator: validatePassword.validate,
                                    ),
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
                                            "Join",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            _beforejoin(index,_joinpassword.text,context);
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

  void _beforejoin(int index,String pass,context) {
    if (pass == null){
      Toast.show("Password cannot empty!.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      return;
    }
    else{
      _validate1(index,pass, context);
    }

  }

  bool _validate1(int index,String pass,context) {
    final form = formKey1.currentState;
    form.save();
    if(form.validate()){
      form.save();
      _officialjoin(index,pass, context);
      return true;
    }
    else{
      return false;
    }
  }

  void _officialjoin(int index,String pass, context) {
    print("Password join:"+pass);
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Joining...');

    http.post("https://wxxsspecial983.com/findme/php/join_group.php",
        body: {
          "password":pass,
        }).then((res){
      print(res.body);
      if (res.body =="success"){
        http.post("https://wxxsspecial983.com/findme/php/official_join_group.php",
            body: {
              "username":widget.user.username,
              "email":widget.user.email,
              "password":pass,
              "groupname": grouplist[index]['groupname'],
              "groupid": grouplist[index]['groupid'],
              "groupimage": grouplist[index]['groupimage'],
            }).then((res){
          print(res.body);
        }).catchError((err){
          print(err);
        });
        Toast.show(
          "Joined Success",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Navigator.pop(context);
        getgrouplist();
      }
      else {
        Toast.show(
          "Wrong Password",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
    }).catchError((err){
      print(err);
    });


  }


  void _getLocation() async {
    try {
      var position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() async {
        print("here");
        print(position);
        _currentPosition = position;
        print(_currentPosition);
        if (_currentPosition != null) {
          final coordinates = new Coordinates(
              _currentPosition.latitude, _currentPosition.longitude);
          var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
          setState(() {
            var first = addresses.first;
            _homeloc = first.addressLine;
            if (_homeloc != null) {
              latitude = _currentPosition.latitude;
              longitude = _currentPosition.longitude;

              http.post("https://wxxsspecial983.com/findme/php/update_user.php",
                  body: {
                    "username":widget.user.username,
                    "password":widget.user.password,
                    "latitude":latitude.toString(),
                    "longitude": longitude.toString(),
                    "address": _homeloc,
                  }).then((res){
                print(res.body);
                if(res.body=="success"){
                  print("Location Success get");
                }
              }).catchError((err){
                print(err);
              });
            }
          });
        }
      });
    } catch (exception) {
      print(exception.toString());
    }
  }


  void homepage() {
    Navigator.of(context).pop();
    getgrouplist();
  }

  void beforesearch() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
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
                    child: Text("Please Enter Group ID:",
                        style: TextStyle(color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 330,
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
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 5),
                                Container(
                                  height: 35,
                                  width: 180,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _searchID,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: 'GroupID',
                                      filled: true,
                                      fillColor: Colors.white70,
                                    ),
                                  ),
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
                                          "Seach",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _searchgroup(_searchID.text);
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
                                        fontSize: 12,
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
        );
      },
    );
  }

  void _signout() {
    Navigator.push(context,MaterialPageRoute(builder:
        (BuildContext context)=> loginscreen()));
  }

  void _deletegroup(int index, context) {
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
                      "Delete "+grouplist[index]['groupname']+" Group?",
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
                            officialdelete(index);
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

  void officialdelete(int index) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Deleting...');

    http.post("https://wxxsspecial983.com/findme/php/delete_group.php",
        body: {
          "email":widget.user.email,
          "groupid": grouplist[index]['groupid'],
        }).then((res){
      print(res.body);
      if (res.body =="success"){
        Toast.show(
          "Delete Success",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>loginscreen()));
      }
      else {
        Toast.show(
          "No Data Found. Delete fail",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
    }).catchError((err){
      print(err);
    });
  }
}



class validateGroupName {
  static String validate(String groupname){
    if(groupname.isEmpty){
      return "UserName cannot be empty";
    }
    return null;
  }
}

class validateGroupID {
  static String validate(String groupid ){
    if(groupid.isEmpty){
      return "GroupID cannot be empty";
    }
    return null;
  }
}

class validatePassword {
  static String validate(String joinpassword ){
    if(joinpassword.isEmpty){
      return "Password cannot be empty";
    }
    return null;
  }
}
