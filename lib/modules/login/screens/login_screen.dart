import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/modules/login/controllers/login_controller.dart';
import 'package:interviewer/utils/helpers/field_helpers.dart';

class LoginScreen extends GetWidget<LoginController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final LoginController _authController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: this._emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  onEditingComplete: () {
                    fieldFocusChange(_emailFocus, _passwordFocus);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: this._passwordController,
                  focusNode: _passwordFocus,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _authController.login(_emailController.text.trim(), _passwordController.text.trim(),);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
