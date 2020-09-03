import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/widgets/add_server.dart';

void showSnackBar({Widget message, FlatButton button, String text}) {
  GetBar(
          animationDuration: new Duration(milliseconds: 300),
          messageText: message,
          message: text,
          mainButton: button,
          duration: Duration(seconds: 3),
        ).show();
}


