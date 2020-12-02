import 'dart:io';
import 'package:app/actions/TakePicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/CameraPreview.dart';
import 'actions/GalleryFile.dart';
import 'package:camera/camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Document Scanner",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: CameraScreen(),
          ),
          Container(
            height: 150.0,
            child: Row(
              children: [
               Expanded(
                   child: GalleryFile(),
               ),
                Expanded(
                  child: TakePicture(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

