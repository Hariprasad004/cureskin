import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class ForgotPassword extends StatefulWidget {
  static String id = "Forgot Password";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;
  String _email;
  bool showSpinner = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Form(
            key: _formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top:120.0, bottom:0.0),
                            child: Text('Reset',
                                style: TextStyle(
                                    fontSize: 80.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Center(
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(16.0, 185.0, 0.0, 0.0),
                            padding: EdgeInsets.only(top:185.0, bottom:0.0),
                            child: Text('Password',
                                style: TextStyle(
                                    fontSize: 80.0, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Enter Email Address";
                              }
                              else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                return "Enter a valid email";
                              }
                              else
                                return null;
                            },
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: 30.0),
                          Container(
                              height: 50.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.lightBlue,
                                color: Colors.blueAccent,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () async{
                                    if (_formkey.currentState.validate()) {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      try {
                                        await _auth.sendPasswordResetEmail(email: _email);
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        Toast.show('Verification email has been sent', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                                        Navigator.pop(context);
                                      } catch (e) {
                                        //Failed
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        print(e.message);
                                        Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                                      }
                                    } else {
                                      print("Unsuccessful");
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'RESET',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 25.0),
                        ],
                      )),
                ]),
          ),
        ));
  }
}
