import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:shlink_app/widgets/app_version.dart';

class SettingsView extends StatelessWidget {
  Widget donationButton = Container();

  SettingsView() {
    if (kIsWeb) {
      /*donationButton = Material(
          child: Image.network(
              "https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=joeyneedssleep&button_colour=FF5F5F&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00"));
    
    */}
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
                child: ListTile(
              leading: Icon(Icons.cloud_circle_outlined),
              title: Text("Shortish Cloud"),
              trailing: arrow,
              onTap: () {
                //todo
                Get.toNamed("/settings/cloud");
              },
            )),
            Card(
                child: ListTile(
              leading: Icon(Icons.map),
              title: Text("Map Settings"),
              trailing: arrow,
              onTap: () {
                Get.toNamed("/settings/map");
              },
            )),
            Card(
                child: ListTile(
              leading: Icon(Icons.link),
              title: Text("Services"),
              trailing: arrow,
              onTap: () {
                //todo
                //Get.toNamed("/settings/map");
              },
            )),
            donationButton,
            AppVersion()
            /**/
          ],
        ));
  }
}
