import 'dart:async';
import 'package:cureskin/Screens/Forgot_Password.dart';
import 'package:flutter/material.dart';
import 'package:cureskin/Screens/Login_Screen.dart';
import 'package:cureskin/Screens/Signup_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return Container(
      color: Colors.white,
      child: Center(
        child: Image(
          image: AssetImage('images/splash.png'),height: 100, width: 100,
        ),
      ),
    );
  }
}
