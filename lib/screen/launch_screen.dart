import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/function/take_picture.dart';
import 'package:camera/camera.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  List<File> attachmentList = [];
  _launchcamera() {
    _showCamera();
  }

  _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final pickedImage = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      attachmentList.add(pickedImage);
    });
  }

  void _removeImage(File pickedFile) {
    setState(() {
      attachmentList.remove(pickedFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: _launchcamera(),
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 10,
                ),
              ),
            ),
          ),
          attachmentList.length >= 1
              ? Padding(
            padding: const EdgeInsets.all(10),
            // child: FileListPreview(attachmentList, _removeImage),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
