import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPreviewScreen extends StatefulWidget {
  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _setImageView()
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openGallery(context);
        },
        child: Icon(Icons.photo_library),
      ),
    );
  }
}


// Future<void> _showSelectionDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("From where you want to take photos?"),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text("Gallery"),
//                   onTap: () {
//                     _openGallery(context);
//                   },
//                 ),
//                 Padding(padding: EdgeInsets.all(8.0)),
//                 // GestureDetector(
//                 //   child: Text("camera"),
//                 //   onTap: () {
//                 //     _openCamera(context);
//                 //   },
//                 // )
//               ],
//             ),
//           ),
//         );
//       }
//   );
// }

void _openGallery(BuildContext context) async {
  var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    var imageFile = picture;
  });
  Navigator.of(context).pop();
}

void setState(Null Function() param0) {
}


Widget _setImageView() {
  var imageFile;
  if (imageFile != null) {
    return Image.file(imageFile, width: 500, height: 500);
  } else {
    return Text("Please select an image");
  }
}

