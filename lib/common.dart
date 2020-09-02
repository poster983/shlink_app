import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({Widget message, String text}) {
  GetBar(
          animationDuration: new Duration(milliseconds: 300),
          messageText: message,
          message: text,
          duration: Duration(seconds: 3),
        ).show();
}