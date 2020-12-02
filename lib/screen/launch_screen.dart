import 'dart:math';

import 'package:app/screen/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  CameraController _cameraController;
  int _selectedCameraIndex = 0;
  List<CameraDescription> cameras;
  String imgPath;
  File _imageFile;
  dynamic _pickImageError;
  List<String> files = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getAvailableCameras();
  }

  getAvailableCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.length > 0) {
        await initCamera(cameras[_selectedCameraIndex]);
      } else {
        print('No Cameras avaialble');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    _cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (_cameraController.value.hasError) {
      print(_cameraController.value.errorDescription);
    }
    try {
      await _cameraController.initialize();
    } catch (e) {
      print(e);
    }
  }

  Widget cameraPreview() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Text(
        'Loading',
      );
    }
    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: CameraPreview(_cameraController),
    );
  }

  Widget cameraControl() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton(
        heroTag: 'camera',
        child: Icon(
          Icons.camera_alt,
        ),
        onPressed: onCapture,
      ),
    );
  }

  Widget intoTheGallery() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: FloatingActionButton(
        heroTag: 'gallery',
        child: Icon(
          Icons.image,
        ),
        onPressed: _onImageButtonPressed,
      ),
    );
  }

  void _onImageButtonPressed() async {
    try {
      final pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery,
      );
      bool result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(
            imgPath: pickedFile.path,
            fileName: pickedFile.path
                .toString()
                .split('/')[pickedFile.path.toString().split('/').length - 1],
          ),
        ),
      );
      if (result) {
        setState(() {
          _imageFile = File(pickedFile.path);
          files.add(_imageFile.path);
        });
      } else
        print("Discarded");
      print(files);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  onCapture() async {
    try {
      final p = await getApplicationDocumentsDirectory();
      final name = DateTime.now().toString();
      final path = "${p.path}/$name.png";

      await _cameraController.takePicture(path);

      bool result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(
            imgPath: path,
            fileName: name,
          ),
        ),
      );
      if (result) {
        files.add(path);
        print(files);
      } else
        print("Discarded");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [cameraPreview(), cameraControl(), intoTheGallery()],
      ),
    );
  }
}
