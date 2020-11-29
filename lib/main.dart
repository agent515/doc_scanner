import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/function/gallery.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;
  // final picker = ImagePicker();

  Future getImage(bool isCamera) async {
    File image;
    if(isCamera) {
      image = ImagePicker.pickImage(source: ImageSource.camera) as File;
    } else {
      image = ImagePicker.pickImage(source: ImageSource.gallery) as File;
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.photo_library,
                  size: 50,
                  ),
                  onPressed: () {
                    getImage(false);
              }),
              SizedBox(height: 10.0,),
              IconButton(
                  icon: Icon(Icons.circle,
                  size: 50,
                  ),
                  onPressed: () {
                    getImage(true);
              }),
              _image == null? Container() : Image.file(_image, height: 500.0, width: 500.0),
            ],
          ),
        ),
      ),
    );
  }
}
