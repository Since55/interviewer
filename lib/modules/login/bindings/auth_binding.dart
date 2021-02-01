import 'package:get/get.dart';
import 'package:interviewer/modules/login/controllers/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<LoginController>(LoginController(), permanent: true);
  }
}