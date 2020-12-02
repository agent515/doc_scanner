import 'package:flutter/material.dart';
import 'dart:io';

class PreviewScreen extends StatefulWidget {

  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Image.file(File(widget.imgPath), fit: BoxFit.cover,)
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.clear, color: Colors.white, size: 36,),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                MaterialButton(
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.done, color: Colors.white, size: 36,),
                    ),
                ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
