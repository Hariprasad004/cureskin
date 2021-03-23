import 'package:flutter/material.dart';
import 'Home.dart';
import 'Forgot_Password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool showSpinner = false;

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
                          // padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                          padding: EdgeInsets.only(top:80.0, bottom:0.0),
                          child: Text('Hello',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Center(
                        child: Container(
                          // padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                          padding: EdgeInsets.only(top:155.0, bottom:0.0),
                          child: Text('There',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                                  borderSide: BorderSide(color: Colors.green))),
                          validator: (String value){
                            if(value.isEmpty){
                              return "Enter Email Address";
                            }
                            else
                              return null;
                          },
                          onChanged: (value){
                            _email = value;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
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
                          onChanged: (value){
                            _password = value;
                          },
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, ForgotPassword.id);
                            },
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 50.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightBlue,
                            color: Colors.blueAccent,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                if(_formkey.currentState.validate()){
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                      //Success
                                      final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                                      if(user!=null){
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        Toast.show('Login successful', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.greenAccent);
                                        Navigator.popAndPushNamed(context, HomeScreen.id);
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
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ));
  }
}
