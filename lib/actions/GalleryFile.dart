import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryFile extends StatefulWidget {
  @override
  _GalleryFileState createState() => _GalleryFileState();
}

class _GalleryFileState extends State<GalleryFile> {
  File _image;
  
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
      //   child: _image == null
      //       ? new Text('No image selected.')
      //       : new Image.file(_image),
      // ),
      child: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    ),
    );
  }
}
