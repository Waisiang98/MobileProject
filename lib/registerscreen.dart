import 'dart:convert';
import 'dart:io';
import 'package:mobileproject/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobileproject/firebasetakedata.dart';
import 'package:mobileproject/loginscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart'as http;
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  String pathAsset = 'assests/person.png';
  File _image;
  double screenHeight,screenWidth;
  bool TandC =false;
  bool _passwordVisible=false;
  String username, paswword, email, name;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods getuserinfo = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/earth1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('assests/findme.png'),
                        radius: 30,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Text("Registration Form",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IndieFlower',
                            fontSize: 24.0,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.blue,
                                offset: Offset(5.0, 5.0),
                              ),
                              Shadow(
                                color: Colors.red,
                                blurRadius: 10.0,
                                offset: Offset(-5.0, 5.0),
                              ),
                            ]
                        ),),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    height: 30,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 500,
                        width: 320,
                        child: new Container(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: GestureDetector(
                            onTap: () => {_onPictureSelection()},
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _image==null
                                        ?AssetImage(pathAsset)
                                        :FileImage(_image),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    width: 3.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(100.0))
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                            controller: _name,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Name *",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                BorderSide(color: Color(0XFF8B8B8B)),
                                gapPadding: 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              hintText: 'Name',
                            ),
                            validator: NameValidator.validate,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                            controller: _username,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "UserName *",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                BorderSide(color: Color(0XFF8B8B8B)),
                                gapPadding: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "UserName",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            validator: UsernameValidator.validate,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email *",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                BorderSide(color: Color(0XFF8B8B8B)),
                                gapPadding: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            validator: EmailValidator.validate,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 300,
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      :Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _passwordVisible=!_passwordVisible;
                                  });
                                },
                              ),
                              labelText: "Password *",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                BorderSide(color: Color(0XFF8B8B8B)),
                                gapPadding: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            validator: PasswordValidator.validate,
                            obscureText: _passwordVisible,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding:EdgeInsets.fromLTRB(40, 0, 0, 0) ,
                              child: Checkbox(value: TandC, onChanged: (bool value){
                                TandCPressed(value);
                              } ),
                            ),
                            Container(
                              child: Text("I agree the",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.blue,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                      Shadow(
                                        color: Colors.red,
                                        blurRadius: 10.0,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ]
                                ),),
                            ),
                            SizedBox(width:1),
                            GestureDetector(
                              onTap: regulationContent,
                              child: Text("term and regulation",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.blue,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                      Shadow(
                                        color: Colors.red,
                                        blurRadius: 10.0,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ]
                                ),),
                            ),
                            SizedBox(width: 1),
                            Container(
                              child: Text("of FindMe.",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.blue,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                      Shadow(
                                        color: Colors.red,
                                        blurRadius: 10.0,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ]
                                ),),
                            ),
                          ],
                        ),
                        Center(
                          child: RaisedButton.icon(
                              icon: Icon(Icons.app_registration),
                              color: Colors.white,
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              label: Text('Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: _registergate),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Already Registered?",
                                style: TextStyle(
                                    fontSize: 12,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.blue,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                      Shadow(
                                        color: Colors.red,
                                        blurRadius: 10.0,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ]
                                ),),
                            ),
                            SizedBox(width: 1),
                            GestureDetector(
                              onTap: _Login,
                              child: Text("Login Now",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.blue,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                      Shadow(
                                        color: Colors.red,
                                        blurRadius: 10.0,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ]
                                ),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void TandCPressed(bool tandC) {
    setState(() {
      TandC=tandC;
    });

  }

  void _confirmregister(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            content: new Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Are you",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width:1),
                      Text(
                        "CONFIRM",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:1),
                      Text(
                        "to register?",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: ()=> {
                      Navigator.of(context).pop(),
                      _register()
                    },
                    color: Colors.white,
                    child:Text(
                      'Yes',style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } );
  }

  void _register() {
    String base64Image= base64Encode(_image.readAsBytesSync());
    name=_name.text;
    username=_username.text;
    email=_email.text;
    paswword=_password.text;
    Map<String, String> userInfoMap = {
      "name": name,
      "email": email,
    };

    authMethods.signUpWithEmailAndPassword(email, paswword);
    getuserinfo.uploadUserInfo(userInfoMap);
    getuserinfo.getUserInfo(name);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Registering...');

    http.post("https://wxxsspecial983.com/findme/php/register.php",
        body: {
          "name":name,
          "username":username,
          "email":email,
          "password":paswword,
          "encoded_string":base64Image,
          "imagename":username+name,
        }).then((res){
      print(res.body);
      if (res.body =="success"){
        Toast.show(
          "Register Success",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>loginscreen()));
      }
      else {
        Toast.show(
          "Register fail",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
    }).catchError((err){
      print(err);
    });


  }

  void _Login() {
    Navigator.push(context,MaterialPageRoute(builder:
        (BuildContext context)=> loginscreen()));
  }

  void regulationContent() {
    showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: new Text("Term and Regulation Agreement Form",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
            content: new Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.0,
                            ),
                            text:
                            "This End User License Agreement (EULA) is a legal agreement between you and FINDME and its software and any third party software that may be distributed therewith (collectively the 'Software'). Upwork agrees to license the Software to you if you accept all the terms contained in this EULA. By installing, using, copying, or distributing all or any portion of the software, you accept and agree to be bound by all of the terms and condition of this EULA. IF YOU DO NOT AGREE WITH ANY OF THE TERMS OF THIS EULA, DO NOT DOWNLOAD, INSTALL OR USE THE SOFTWARE. Your use of the Software is also subject to your agreements with us concerning your use of the upwork.com website (the 'Site') and the services provided through that website. This EULA hereby incorporates by reference all terms, condition rules, policies and guidelines on the Site, including the FINDME (the 'Terms of Service')Capitalized terms not defined in this EULA are defined in the Terms of Services."
                          //children: getSpan(),"
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Back",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ) ,),
                    ),
                  ],
                ),
              ),
            ),

          );

        }
    );
  }

  void _registergate() {
    if (TandC==false){
      showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              content: new Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Please",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width:1),
                        Text(
                          "READ",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width:1),
                        Text(
                          "and",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width:1),
                        Text(
                          "AGREE",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "the term and regulation.",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    MaterialButton(
                      onPressed: ()=>{
                        Navigator.of(context).pop(),
                        _preregulationContent()},
                      color: Colors.white,
                      child: Text("Read",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ) ,),),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ) ,),)
                  ],
                ),
              ),
            );
          } );
      _validate();
    }
    else{
      _validate();
    }
  }
  bool _validate() {
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      _confirmregister();
      return true;
    }
    else{
      return false;
    }
  }

  _cancelButton() {
    Navigator.of(context).pop();
  }


  void _preregulationContent() {
    regulationContent();
  }

  _onPictureSelection() {
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
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
                  alignment: Alignment.center,
                  child: Text(
                    'Take picture from:',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Flexible(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        minWidth: 100,
                        height:100,
                        child: Text('Camera',
                          style: TextStyle(
                            color:Colors.black87,
                          ),),
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: ()=> {Navigator.pop(context),_chooseCamera()},
                      ),
                    ),
                    SizedBox(width:10),
                    Flexible(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          minWidth: 100,
                          height:100,
                          child: Text('Gallery',
                            style: TextStyle(
                              color:Colors.black87,
                            ),),
                          textColor: Colors.white,
                          elevation: 10,
                          onPressed: ()=> {Navigator.pop(context),_chooseGallery()},
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

  void _chooseCamera()async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera,maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {
    });
  }

  void _chooseGallery()async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {
    });
  }

  Future <Null>_cropImage() async {
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
      setState(() {
      });
    }
  }
}

class NameValidator {
  static String validate(String name){
    if(name.isEmpty){
      return "Name cannot be empty";
    }
    return null;
  }
}
class UsernameValidator {
  static String validate(String username){
    if(username.isEmpty){
      return "UserName cannot be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String password){
    if(password.isEmpty){
      return "Password cannot be empty";
    }
    else if (password.length > 15){
      return "Password length shall less than 15 alphanumerics";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String email){
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if(email.isEmpty){
      return "Email cannot be empty";
    }
    else if(!regExp.hasMatch(email)){
      return "Invalid email format";
    }
    return null;
  }
}
