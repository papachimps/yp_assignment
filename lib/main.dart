import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '/controller/authController.dart';
import '/views/signScreen.dart';
import '/views/homeScreen.dart';
import '/views/videoPlayer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final fbService = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'yp_assignment',
      debugShowCheckedModeBanner: false,
      initialRoute: fbService.getSessionUser() == null
          ? SignInScreen.route
          : HomeScreen.route,
      // // get
      getPages: [
        GetPage(
          name: SignInScreen.route,
          page: () => SignInScreen(),
        ),
        GetPage(
          name: HomeScreen.route,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: VideoPlayer.route,
          page: () => VideoPlayer(),
        ),
      ],
    );
  }
}


