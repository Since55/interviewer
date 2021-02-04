import 'package:get/get.dart';
import 'package:interviewer/config/routes/routes.dart';
import 'package:interviewer/core/auth/screens/initial_screen.dart';
import 'package:interviewer/modules/candidate/screens/candidate_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => InitialScreen(),
    ),
    //ADD PAGES HERE
  ];
}