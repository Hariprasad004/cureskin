import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result='';
  List _outputs;
  File _image;
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "asset/model_unquant.tflite",
      labels: "asset/labels.txt",
      numThreads: 1,
    );
  }
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true
    );
    setState(() {
      _loading = false;
      showSpinner = false;
      _outputs = output;
      result = _outputs[0]["label"];
      // _res = result.split(' ')[1];
    });
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
  pickImage(ImageSource source) async {
    final picked = await _picker.getImage(source: source,maxWidth: 400,
        maxHeight: 400);
    File image = File(picked.path);
    if (image == null) return null;
    setState(() {
      showSpinner = true;
      _loading = true;
      _image = image;
    });
    Navigator.pop(context);
    classifyImage(_image);
  }
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
                  pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  pickImage(ImageSource.gallery);
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


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF303036),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select an Image",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        // backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _loading ? Container(
                height: 500,
                width: 500,
              ):
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image == null ? Container() : Image.file(_image),
                    SizedBox(
                      height: 20,
                    ),
                    _image == null ? Container() : _outputs != null ?
                    Text(result,style: TextStyle(color: Colors.amber,fontSize: 20, fontWeight: FontWeight.w800),
                    ) : Container(child: Text(""))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FloatingActionButton(
                tooltip: 'Pick Image',
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => BottomSheet()));
                },
                child: Icon(Icons.add_a_photo,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}