import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/modules/home/screens/home.dart';
import 'package:interviewer/modules/login/screens/login_screen.dart';

import '../controllers/auth_controller.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({Key key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // TODO: add auth check
    return 
    Obx(
      () {
        print('SIGNED IN: ${_authController.isSignedIn}');
        if (_authController.isSignedIn) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
