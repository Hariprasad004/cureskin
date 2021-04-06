import 'dart:async';
import 'package:cureskin/Screens/Forgot_Password.dart';
import 'package:flutter/material.dart';
import 'package:cureskin/Screens/Login_Screen.dart';
import 'package:cureskin/Screens/Signup_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash Screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() => print("Completed"));
    Timer(
        Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(context, SignupScreen.id)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
          child: Center(
            child: Image(
              image: AssetImage('images/splash.png'),height: 120, width: 120,
            ),
          ),
        ),
          SizedBox(height: 60.0,),
          SpinKitRipple(color:Colors.red,),
      ]),
    );
  }
}
