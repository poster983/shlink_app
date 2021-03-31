import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:shlink_app/widgets/app_version.dart';

class SettingsView extends StatelessWidget {
  HomeView() {

  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget arrow = SizedBox(width: 1, height: 1);
    if (!kIsWeb) {
      if (Platform.isIOS) {
        arrow = Icon(CupertinoIcons.forward);
      }
    }

    return Container(
      width: 1,
      child: ListView(
      children: [
        Card(
          child: //Text("Map Settings")
          ListTile(
          leading: Icon(Icons.map),
          title: Text("Map Settings"),
          trailing: arrow,
          onTap: () {
            Get.toNamed("/settings/map");
          },
        )
        ),
        Card(
          child: //Text("Map Settings")
          ListTile(
          leading: Icon(Icons.link),
          title: Text("Services"),
          trailing: arrow,
          onTap: () {
            //todo
            //Get.toNamed("/settings/map");
          },
        )
        ),
        AppVersion()
        /**/
      ],
      )
    );
  }
}
