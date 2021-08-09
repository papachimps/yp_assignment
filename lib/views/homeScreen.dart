import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/authController.dart';
import '../constants.dart';
import 'signScreen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';
  final fbService = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(fbService.getSessionUser()!.photoURL),
          ),
        ),
        title: Text('Welcome ${fbService.getSessionUser()!.displayName}!'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                fbService.signOutFromGoogle();
                Get.offAndToNamed(SignInScreen.route);
              },
              icon: Icon(Icons.logout_rounded))
        ],
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
