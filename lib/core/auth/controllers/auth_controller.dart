import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AuthController extends GetxController {

AuthController();

  final _isSignedIn = false.obs;
  set isSignedIn(value) => this._isSignedIn.value = value;
  get isSignedIn => this._isSignedIn.value;

}