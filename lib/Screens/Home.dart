import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:getwidget/getwidget.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSpinner = false;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Widget BottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Select an image',
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  chooseImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  chooseImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void chooseImage(ImageSource source) async {
    final pickerFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickerFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF303036),
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
            child: Center(
              child: TextButton(
                autofocus: false,
                // child: _imageFile == null
                //     ? Image.asset(
                //   'images/placeholder.jpg',
                // )
                // : FileImage(File(_imageFile.path)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => BottomSheet()));
                },
                // child: CircleAvatar(
                //   radius: 100.0,
                //   backgroundImage: _imageFile == null
                //       ? AssetImage('images/placeholder.jpg')
                //   : FileImage(File(_imageFile.path)),
                // ),
                child: GFAvatar(
                  radius: 190.0,
                  backgroundImage: _imageFile == null
                      ? AssetImage('images/placeholder.jpg')
                      // ? Image(image: Text("Select an image"),)
                      : FileImage(
                          File(_imageFile.path),
                        ),
                  shape: GFAvatarShape.standard,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0,),
          Center(
            child: Container(
                height: 50.0,
                width: 150.0,
                child: Material(
                  // borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.deepOrange,
                  color: Colors.red,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Okay',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
