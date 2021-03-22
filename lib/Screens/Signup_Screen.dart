import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'Signup Screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String _email,p1,p2;
  // TextEditingController _password = TextEditingController();
  // TextEditingController _cpass = TextEditingController();
  // final _formkey = GlobalKey<FormState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text(
                          'SIGNUP',
                          style:
                          TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
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
                          // validator: (String value){
                          //   if(value.isEmpty){
                          //     return "Enter Email Address";
                          //   }
                          //   else
                          //     return null;
                          // },
                          onChanged: (value){
                            _email = value;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          // controller: _password,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                          // validator: (String value){
                          //   if(value.isEmpty){
                          //     return "Enter Password";
                          //   }
                          //   else
                          //     return null;
                          // },
                          onChanged: (value){
                            p1 = value;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          // controller: _cpass,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                          // validator: (String value){
                          //   if(value.isEmpty){
                          //     return "Enter Confirm Password";
                          //   }
                          //   else if(_password.text != _cpass.text){
                          //     return "Password doesn't match";
                          //   }
                          //   else
                          //     return null;
                          // },
                          onChanged: (value){
                            p2 = value;
                          },
                        ),
                        SizedBox(height: 50.0),
                        Container(
                            height: 50.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () async{
                                  // if(_formkey.currentState.validate()){
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(email: _email,
                                          password: p1);
                                      print(newUser);
                                      if(newUser!=null){
                                        //Success
                                        Navigator.popAndPushNamed(context, LoginScreen.id);
                                      }

                                    }
                                    catch(e){
                                      //Failed
                                      print(e.toString());
                                    }
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  // }
                                  // else{
                                  //   print("Unsuccessful");
                                  // }
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
                      ],
                    )),
              ]),
        ));
  }
}