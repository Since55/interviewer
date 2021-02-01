import 'package:flutter/material.dart';

fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  nextFocus.requestFocus();
}