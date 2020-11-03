import 'package:flutter/material.dart';

class Methods {
  static void showSnackBar(String text, context) {
    SnackBar snackBar = SnackBar(content: Text(text), duration: Duration(seconds: 6),);
    Scaffold.of(context)
        .showSnackBar(snackBar);
  }
  static String getEmptyInputError="String Cannot be empty";
}