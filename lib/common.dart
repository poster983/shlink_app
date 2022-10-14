import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/widgets/add_server.dart';

void showSnackBar( {Widget? message, Widget? button, String? text}) {
  GetBar(
    animationDuration: new Duration(milliseconds: 300),
    messageText: message,
    message: text,
    mainButton: button,
    duration: Duration(seconds: 3),
  ).show();
}

Color randomColor() {
  var colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.indigo,
    Colors.cyan
  ];
  Random random = new Random();
  return colors[random.nextInt(colors.length)];
}
/*void printList(List lst) {
  String output = "[";
  lst.asMap().forEach((key, value) {
    
  })
  return map(lst, (x) => x.toString());
}*/
