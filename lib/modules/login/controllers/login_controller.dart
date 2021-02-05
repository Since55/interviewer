import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interviewer/core/auth/controllers/auth_controller.dart';
import 'package:interviewer/modules/home/screens/home.dart';
import 'package:interviewer/utils/helpers/text_helpers.dart';
import 'package:interviewer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController _authController = Get.find();
  GoogleSignInAccount _user;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // scopes: GoogleApiConstants.API_SCOPES,
  );
  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    _isLoggedIn();
  }

  void _isLoggedIn() async {
    bool _isSignedIn = await _googleSignIn.isSignedIn();
    if (_isSignedIn) {
      this._user = _googleSignIn.currentUser;
      this._authController.isSignedIn = true.obs();
    }
  }

  // Not used. If smth wrong with sign in, look at signInWithGoogle()
  void login(String email, String password) async {
    try {
      if (isNotNullOrEmpty(email) && isNotNullOrEmpty(password)) {
        showSnackbar(
          'Signing In',
          'Please wait...',
          icon: Icon(Icons.pending),
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
      showSnackbar(
        "Error while Signing In",
        e.message,
      );
    }
  }

  void signInWithGoogle() async {
    try {
      _user = await _googleSignIn.signIn();
      if (_user != null) {
        this._authController.isSignedIn = true.obs();
      }
    } catch (error) {
      print(error);
      showSnackbar(
        "Error while Signing In",
        error.message,
      );
    }
  }

  Future _clearPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear(); 
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _clearPrefs();
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
