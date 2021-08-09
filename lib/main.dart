import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yp_assignment/cameraFeed.dart';

import '/constants.dart';
import '/videoPlayer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomeScreen.route,
      debugShowCheckedModeBanner: false,
      // // get
      getPages: [
        GetPage(
          name: HomeScreen.route,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: VideoPlayer.route,
          page: () => VideoPlayer(),
        ),
        GetPage(
          name: CameraFeed.route,
          page: () => CameraFeed(),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List of Videos'),
        elevation: 0,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: gDefaultMargin2,
          horizontal: gDefaultMargin,
        ),
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> video = videoList[index];
          return Column(
            children: [
              ListTile(
                leading:
                    CircleAvatar(backgroundImage: NetworkImage(video['thumb'])),
                title: Text(video['title']),
                subtitle: Text(video['subtitle']),
                trailing: Icon(Icons.play_circle_fill_rounded),
                onTap: () {
                  // Get.toNamed('/camera');
                  Get.toNamed('/video',
                      arguments: {'source': video['sources'].first});
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
