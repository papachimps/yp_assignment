import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'camera.dart';

class CameraFeed extends StatefulWidget {
  static const String route = '/camera';

  _CameraFeedState createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  late final List<CameraDescription> _cameras;
  late final CameraController _controller;
  int _selected = 1;
  bool isInitialised = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setupCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isInitialised) {
      return Transform.rotate(
        angle: 3.14 * 1 * 1,
        child: CameraPreview(_controller),
      );
    } else
      return Container();
  }

  Future<void> setupCamera() async {
    await [Permission.camera].request();
    _cameras = await availableCameras();
    _controller = await selectCamera();
    await _controller.initialize().whenComplete(() => setState(() {
          isInitialised = true;
        }));
    // print('asuewc ${_controller.value.isInitialized}');
  }

  Future<CameraController> selectCamera() async {
    var controller =
        CameraController(_cameras[_selected], ResolutionPreset.medium);
    return controller;
  }
}
