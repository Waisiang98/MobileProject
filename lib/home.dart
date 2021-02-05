import 'package:flutter/material.dart';
import 'package:mobileproject/loginscreen.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.blueAccent;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assests/day.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: ProgressIndicator()),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {

    super.initState();
    controller =AnimationController(duration:const Duration(milliseconds: 3000),vsync:this);
    animation = Tween(begin:0.0,end:1.0).animate(controller)..addListener(() {
      setState(() {
        if(animation.value>0.99){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder:(BuildContext context)=> loginscreen()));
        }

      });
    });
    controller.repeat();
  }
  @override
  void dispose(){
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: GlowingProgressIndicator(
              child: CircleAvatar(
                backgroundColor: Colors.white60,
                radius: 100,
                child: Image.asset(
                    "assests/findme.png"
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadingText('Loading',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black87,
                  letterSpacing: 2.0,
                ),)
            ],
          ),
        ],
      ),
    );
  }
}
