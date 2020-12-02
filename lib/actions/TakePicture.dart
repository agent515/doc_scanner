import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/screens/CameraPreview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePicture extends StatefulWidget {
  // var cameras;
  // TakePicture(this.cameras);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  Future _initializeControllerFuture;
  CameraController _controller;
  List<CameraDescription> _cameras;

  @override
  void initState() {
    _takePhoto();
    super.initState();
  }

  Future<void> _takePhoto() async {
    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    try {
      // Ensure the camera is initialized
      await _initializeControllerFuture;
      // Construct the path where the image should be saved using the path
      // package.
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
          (await getTemporaryDirectory()).path,
          '${DateTime.now()}.png',
    );
    // Attempt to take a picture and log where it's been saved
    await _controller.takePicture(path);
    } catch (e) {
    // If an error occurs, log the error to the console.
    print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // Provide an onPressed callback
          onPressed: () {
            _takePhoto();
          },
        )
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
