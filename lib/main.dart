import 'package:flutter/material.dart';
import 'package:cureskin/Screens/Splash_Screen.dart';
import 'package:cureskin/Screens/Login_Screen.dart';
import 'package:cureskin/Screens/Signup_Screen.dart';
import 'package:cureskin/Screens/Forgot_Password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
      },
    );
  }
}
