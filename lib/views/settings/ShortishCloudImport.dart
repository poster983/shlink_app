import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/views/settings/ShortishCloudOptIn.dart';

class ShortishCloudImportView extends StatefulWidget {
  ShortishCloudImportView({Key? key}) : super(key: key);

  @override
  _ShortishCloudImportViewState createState() => _ShortishCloudImportViewState();
}

class _ShortishCloudImportViewState extends State<ShortishCloudImportView> {
  //final box = Hive.box("preferences");


  @override
  void initState() {
    //box.get("shortish_cloud_state", defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import Shortish Cloud"),
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
            width: Get.width,
            child: Column(
              children: [
                Text("Import an existing Shortish Cloud account", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                SizedBox(height: 30),
              ],
            )
          ) 
    );
    
  }
}
