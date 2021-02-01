import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/core/auth/controllers/auth_controller.dart';
import 'package:interviewer/utils/helpers/text_helpers.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController _authController = Get.find();
  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void login(String email, String password) async {
    try {
      if (isNotNullOrEmpty(email) && isNotNullOrEmpty(password)) {
        Get.snackbar(
          'Signing In',
          'Please wait...',
          icon: Icon(Icons.pending),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white38,
          duration: Duration(milliseconds: 1000),
        );
      }

      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print(_authResult);
      this._authController.isSignedIn = true.obs();
    } catch (e) {
      // this.isSignedIn = false.obs();
      Get.snackbar(
        "Error while Signing In",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        duration: Duration(milliseconds: 900),
        overlayBlur: 1,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      this._authController.isSignedIn = false.obs();
    } catch (e) {
      Get.snackbar(
        "Error while signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        overlayBlur: 1,
      );
    }
  }
}

// class Auth