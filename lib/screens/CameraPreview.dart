import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  List<CameraDescription> _cameras;
  CameraController _controller;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      if (!_controller.value.isInitialized) {
        return Container();
      }
    } else {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return Container();
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            _buildCameraPreview(),
          ],
        ),
      );
    }
  }

  Widget _buildCameraPreview() {
    final size = MediaQuery.of(context).size;
    return ClipRect(
      child: Container(
        child: Transform.scale(
          scale: _controller.value.aspectRatio / size.aspectRatio,
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
