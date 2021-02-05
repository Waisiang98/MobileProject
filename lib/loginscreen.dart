import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobileproject/registerscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:mobileproject/user.dart';
import 'package:mobileproject/mainpage.dart';


class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _passwordVisible=false;
  bool isChecked=false;
  String username="";
  String password="";
  SharedPreferences pres;


  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/earth1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  height: 170,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assests/findme.png"),
                        backgroundColor: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blueGrey,
                            size: 24.0,
                          ),
                          SizedBox(width: 5),
                          Container(
                            child: Center(
                              child: Text(
                                "Track Your Friend Now",
                                style: TextStyle(
                                    decorationColor: Colors.white70,
                                    fontFamily: 'IndieFlower',
                                    fontSize: 20.0,
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
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blueGrey,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  height: 40,
                  thickness: 1.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height:5),
              Stack(
                children: [
                  Center(
                    child:Container(
                      height: 380,
                      width: 330,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                        height: 50,
                        width: 330,
                        child: TextField(
                          controller: _username,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                              hintStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              hintText: 'UserName',
                              icon: Icon(Icons.people,
                                color: Colors.black,)
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                        height: 50,
                        width: 330,
                        child: TextField(
                          controller: _password,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white70,
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            icon: Icon(Icons.lock,
                              color: Colors.black,),
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
                          ),
                          obscureText: _passwordVisible,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: Checkbox(
                                value: isChecked,
                                onChanged: (bool value){
                                  onChange(value);
                                }
                            ),
                          ),
                          Text('Remember me',
                            style: TextStyle(
                              color: Colors.black,
                            ),),
                        ],
                      ),
                      Center(
                        child: RaisedButton.icon(
                            icon: Icon(Icons.login),
                            color: Colors.white,
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            label: Text('Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _login),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Dont Have account?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
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
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: _RegisterScreen,
                            child: Text("Sign up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
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

  void _login() {
    username=_username.text;
    password=_password.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible:false);
    pr.style(message: 'Login...');

    http.post("https://wxxsspecial983.com/findme/php/login_user.php",
        body: {
          "username":username,
          "password":password,
        }).then((res){
      print(res.body);
      var string=res.body;
      List userdata=string.split(",");
      print(userdata);
      if (userdata[0]== "success"){
        Toast.show(
          "Login Success",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        User user  = new User(username: username,
          email:userdata[1],
          name: userdata[2],
          password:userdata[4],
          imagename: userdata[5],
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>mainpage(user: user,)));
      }
      else {
        Toast.show(
          "Login Failed",context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err){
      print(err);
    });



  }

  void _RegisterScreen() {
    Navigator.push(context,MaterialPageRoute(builder:
        (BuildContext context)=> RegisterScreen()));
  }

  void onChange(bool value) {
    setState(() {
      isChecked=value;
      savepref(value);
    });
  }

  void loadPref() async {
    pres = await SharedPreferences.getInstance();
    username=(pres.getString('username'))??'';
    password=(pres.getString('password'))??'';
    isChecked=(pres.getBool('rememberme'))??false;

    if(username.isNotEmpty){
      _username.text=username;
      _password.text=password;
      isChecked=isChecked;
    }

  }

  void savepref(bool value) async {
    pres = await SharedPreferences.getInstance();
    username=_username.text;
    password=_password.text;
    if(value){
      if (username.length<5 && password.length<3){
        print('email/password error');
      }
      else{
        await pres.setString('username',username);
        await pres.setString('password',password);
        await pres.setBool('rememberme',value);
        Toast.show('I remember you',context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        print('success');
      }
    }
    else{
      await pres.setString('username',username);
      await pres.setString('password',password);
      await pres.setBool('rememberme',value);
      setState(() {
        _username.text='';
        _password.text='';
        isChecked=false;
      });
    }

  }

}
