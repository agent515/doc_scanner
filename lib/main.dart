import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  CameraDescription get camera => null;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final fileName = DateTime
      .now()
      .millisecondsSinceEpoch
      .toString();
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  File _image;

    Future getImage(bool isCamera) async {
      File image;
      if (isCamera) {
        image = ImagePicker.pickImage(source: ImageSource.camera) as File;
      } else {
        image = ImagePicker.pickImage(source: ImageSource.gallery) as File;
      }
      setState(() {
        _image = image;
      });
    }

    @override
    void initState() {
      super.initState();

      _cameraController =
          CameraController(widget.camera, ResolutionPreset.medium);

      _initializeCameraControllerFuture = _cameraController.initialize();
      // _fileInit();
    }

// void _fileInit() async {
//     vidPath = join((await getTemporaryDirectory()).path, '${fileName}.mp4');
// }

    void _takePicture(BuildContext context) async {
      try {
        await _initializeCameraControllerFuture;
        final imgPath =
        join((await getTemporaryDirectory()).path, '${fileName}.png');
        await _cameraController.takePicture(imgPath);
        Navigator.pop(context, imgPath);
      } catch (e) {
        print(e);
      }
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 650.0,
                  width: 500.0,
                  child: FutureBuilder(
                    future: _initializeCameraControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_cameraController);
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            )
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        icon: Icon(
                          Icons.circle,
                          size: 100,
                        ),
                        onPressed: () {
                          getImage(true);
                        }),
                    _image == null ? Container() : Image.file(
                        _image, height: 500.0, width: 500.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    @override
    void dispose() {
      _cameraController.dispose();
      super.dispose();
    }
  }