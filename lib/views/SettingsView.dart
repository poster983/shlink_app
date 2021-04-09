import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/widgets/app_version.dart';
import 'package:shlink_app/widgets/shortish_text_logo.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  Widget donationButton = Container();
  Widget arrow = SizedBox(width: 1, height: 1);
  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  SettingsView() {
    //build arrow
    if (!kIsWeb) {
      if (Platform.isIOS) {
        arrow = Icon(CupertinoIcons.forward);
      }
    }

    //Build donation button
    if (kIsWeb) {
      donationButton = Container(
          constraints: BoxConstraints(
              maxWidth: 60, minWidth: 40, maxHeight: 40, minHeight: 20),
          //width: 50,
          //height:10,
          child: InkWell(
              onTap: () =>
                  _launchURL("https://buymeacoffee.com/joeyneedssleep"),
              child: SizedBox(
                  child: SvgPicture.network(
                "https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=joeyneedssleep&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00",
                semanticsLabel: 'Buy me a coffee',
                placeholderBuilder: (BuildContext context) =>
                    Container(color: Colors.grey),
              ))));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //super.dispose();
  }

  Widget _settingLink(
      {required String title,
      required IconData icon,
      void Function()? onTap,
      String? toNamed}) {
    assert(toNamed != null || onTap != null);
    return //Wrap(children: [
        Card(
            child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: arrow,
      onTap: onTap ??
          () {
            Get.toNamed(toNamed!);
          },
    ));
    //]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      
      Container(
          padding: EdgeInsets.only(top: 35),
          constraints: BoxConstraints(maxWidth: 1000),
          //width: 1,
          child: ListView(
            //mainAxisSize: MainAxisSize.min,
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: ShortishTextLogo(
                  after: " /settings",
                  style: TextStyle(fontSize: (Get.width > 400)?50:25,),
                ),
              ),
              
              new IconButton(
                icon: Icon(Icons.brightness_medium),
                onPressed: () {
                  if (Get.isDarkMode) {
                    Get.changeTheme(AppTheme.lightTheme);
                  } else {
                    Get.changeTheme(AppTheme.darkTheme);
                  }
                }),
              _settingLink(
                  title: "Shortish Cloud",
                  icon: Icons.cloud_circle_outlined,
                  toNamed: "/settings/cloud"),
              _settingLink(
                  title: "Map Settings",
                  icon: Icons.map,
                  toNamed: "/settings/map"),
              _settingLink(title: "Services", icon: Icons.link, onTap: () {}),

              /*Card(
            child: ListTile(
          leading: Icon(Icons.cloud_circle_outlined),
          title: Text("Shortish Cloud"),
          trailing: arrow,
          onTap: () {
            //todo
            Get.toNamed("/settings/cloud");
          },
        )),*/
              /*Card(
            child: ListTile(
          leading: Icon(Icons.map),
          title: Text("Map Settings"),
          trailing: arrow,
          onTap: () {
            Get.toNamed("/settings/map");
          },
        )),*/
              /*Card(
                child: ListTile(
              leading: Icon(Icons.link),
              title: Text("Services"),
              trailing: arrow,
              onTap: () {
                //todo
                //Get.toNamed("/settings/map");
              },
            )),*/
              donationButton,
              AppVersion()
              /**/
            ],
          ))
    ]);
  }
}
