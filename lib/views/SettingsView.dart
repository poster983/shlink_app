import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shlink_app/widgets/app_version.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  Widget donationButton = Container();
  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
      
  SettingsView() {
    if (kIsWeb) {
      donationButton = Container(
        constraints: BoxConstraints(maxWidth: 60, minWidth: 40, maxHeight: 40, minHeight: 20),
        //width: 50,
        //height:10,
        child: InkWell(
          onTap: () => _launchURL("https://buymeacoffee.com/joeyneedssleep"),
          child: SizedBox(
            child: SvgPicture.network(
        "https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=joeyneedssleep&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00",
        semanticsLabel: 'Buy me a coffee',
        placeholderBuilder: (BuildContext context) => Container(color: Colors.grey),
      ))
        )
      );
      
    }
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
