import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homeScreen.dart';
import '../controller/authController.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign-in';
  final fbService = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Center(
        child: Obx(
          () => fbService.isLoading.value
              ? CircularProgressIndicator()
              : MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    fbService.signInwithGoogle().then((value) {
                      print(fbService.userName);
                      Get.offAndToNamed(HomeScreen.route);
                    });
                  },
                  child: Text('Sign-In'),
                ),
        ),
      ),
    );
  }
}