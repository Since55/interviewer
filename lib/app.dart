import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:interviewer/core/auth/screens/initial_screen.dart';

import 'config/routes/pages.dart';

class AppCore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('App started');
    return GetMaterialApp(
      title: 'Inteviewer',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      defaultTransition: Transition.rightToLeft,
      getPages: AppPages.pages,
      home: InitialScreen(),
    );
  }
}