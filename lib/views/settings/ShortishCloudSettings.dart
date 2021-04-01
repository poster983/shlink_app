

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';




class ShortishCloudView extends StatefulWidget {
  ShortishCloudView({Key? key}) : super(key: key);

  @override
  _ShortishCloudViewState createState() => _ShortishCloudViewState();
}

class _ShortishCloudViewState extends State<ShortishCloudView> {

  final box = Hive.box("preferences");


  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Shortish Cloud"),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: BackButton(
            onPressed: () {
              if (Get.previousRoute == "") {
                Get.offAllNamed("/settings");
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text("Coming Soon"),
            )));
  }
}
