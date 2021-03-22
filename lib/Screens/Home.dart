import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hariprasad Poojary"),
      ),
    );
  }
}
