import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar(title, message, {Icon icon}) {
  Get.snackbar(
        title,
        message,
        icon: icon,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        duration: Duration(milliseconds: 3000),
      );
}