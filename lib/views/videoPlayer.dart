import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

import 'cameraFeed.dart';
import '../constants.dart';
// import './constants.dart';

class VideoPlayer extends StatefulWidget {
  static const String route = '/video';
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late FlickManager flickManager;
  late String videoUrl;
  Offset position = Offset(10, 10);
  final cameraFeed = CameraFeed();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    videoUrl = arguments['source'];
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(videoUrl),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    flickManager.dispose();
  }

  void updatePosition(Offset newPosition) {
    setState(() => position = newPosition);
    // print('adadcec $position');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //video player
          FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              videoFit: BoxFit.contain,
              controls: FlickPortraitControls(
                iconSize: 0,
                fontSize: 14,
                progressBarSettings: FlickProgressBarSettings(
                  handleRadius: 8,
                  height: 4,
                ),
              ),
            ),
            preferredDeviceOrientation: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
            systemUIOverlay: [],
            wakelockEnabled: true,
          ),
          //close button
          Positioned(
            top: 10,
            right: 0,
            child: MaterialButton(
              onPressed: () => Get.back(),
              padding: EdgeInsets.zero,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.black.withOpacity(0.9),
                  width: 1,
                ),
              ),
              height: 26,
              color: Colors.white.withOpacity(0.8),
              child: Icon(
                Icons.close_rounded,
                color: Colors.black.withOpacity(0.9),
                size: 18,
              ),
            ),
          ),
          //cameraFeed
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              maxSimultaneousDrags: 1,
              onDragEnd: (details) => updatePosition(details.offset),
              child: Container(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(gDefaultMargin / 2),
                  child: cameraFeed,
                ),
              ),
              feedback: Container(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(gDefaultMargin / 2),
                  child: cameraFeed,
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                color: Colors.black26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
