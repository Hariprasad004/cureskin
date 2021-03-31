import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'Signup Screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String _email;
  TextEditingController _password = TextEditingController();
  TextEditingController _cpass = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //resizeToAvoidBottomPadding: false,
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
                            // padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            padding: EdgeInsets.only(top:110.0, bottom:0.0),
                            child: Text(
                              'SIGNUP',
                              style:
                              TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                // hintText: 'EMAIL',
                                // hintStyle: ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Email Address";
                              }
                              else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                return "Enter a valid email";
                              }
                              else
                                return null;
                            },
                            onChanged: (value){
                              _email = value;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            obscureText: true,
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Password";
                              }
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _cpass,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            obscureText: true,
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Confirm Password";
                              }
                              else if(_password.text != _cpass.text){
                                return "Password doesn't match";
                              }
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 50.0),
                          Container(
                              height: 50.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.lightBlue,
                                color: Colors.blueAccent,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () async{
                                    if(_formkey.currentState.validate()){
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      try {
                                        final newUser = await _auth
                                            .createUserWithEmailAndPassword(email: _email,
                                            password: _password.text);
                                        print(newUser);
                                        if(newUser!=null){
                                          //Success
                                          setState(() {
                                            showSpinner = false;
                                          });
                                          Toast.show("Signup successful. Please login.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                                          Navigator.popAndPushNamed(context, LoginScreen.id);
                                        }
                                      }
                                      catch(e){
                                        //Failed
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        print(e.message);
                                        Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                                      }
                                    }
                                    else{
                                      print("Unsuccessful");
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 5.0),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20.0),
                            child: InkWell(
                              child: Text(
                                'Already have an account? Login',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    fontFamily: 'Montserrat',
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: (){
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                            ),
                          ),
                          SizedBox(height: 25.0),
                        ],
                      )),
                ]),
          ),
        ));
  }
}