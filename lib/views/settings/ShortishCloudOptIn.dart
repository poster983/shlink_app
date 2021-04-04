import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:shlink_app/common.dart';

class ShortishCloudOptInView extends StatefulWidget {
  ShortishCloudOptInView({Key? key}) : super(key: key);

  @override
  _ShortishCloudOptInViewState createState() => _ShortishCloudOptInViewState();
}

class _ShortishCloudOptInViewState extends State<ShortishCloudOptInView> {
  final box = Hive.box("preferences");

  @override
  void initState() {
    if (box.get("shortish_cloud_enabled", defaultValue: false)) {
      Get.offAllNamed("/");
    }
    //box.get("shortish_cloud_state", defaultValue: false);
  }

  Future<String> getAPIKey() async {
    http.Response res = await http.get(Uri.parse("TODO PUT URL IN CONFIGS"));
    return res.body;
  }

  void newUser() async {
    try {
      String key = await getAPIKey();
      box.put("shortish_cloud_enabled", true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("shortish_cloud_apikey", key);

      //TO DO ADD AS A SERVICE
    } catch (e) {
      print(e);
      showSnackBar(text: "Uhoh, please try again later");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Opt-In"),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: BackButton(
            onPressed: () {
              if (Get.previousRoute == "") {
                Get.offAllNamed("/settings/cloud");
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: ListView(shrinkWrap: true, children: <Widget>[
          Container(
              width: Get.width,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Terms Of Service",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SelectableText(
                      '''By opting in to the Shortish Cloud(https://shrti.sh) service, you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this site. The materials contained in this website are protected by applicable copyright and trademark law.

In no event shall the developer of Shortish or Shortish Cloud(https://shrti.sh) or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Shortish or Shortish Cloud(https://shrti.sh), even if the developer or an authorized representative of the developer has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.

The materials appearing on Shortish or Shortish Cloud(https://shrti.sh) website could include technical, typographical, or photographic errors. Shortish or Shortish Cloud(https://shrti.sh) does not warrant that any of the materials on its website are accurate, complete or current. Shortish or Shortish Cloud(https://shrti.sh) may make changes to the materials contained on its website at any time without notice. However Shortish or Shortish Cloud(https://shrti.sh) does not make any commitment to update the materials.

Shortish or Shortish Cloud(https://shrti.sh) has not reviewed all of the sites linked to its website and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by Shortish or Shortish Cloud(https://shrti.sh) of the site. Use of any such linked website is at the user's own risk.

Because Shortish and Shortish Cloud(https://shrti.sh) are provided free of charge there are some expectations that come along with that.  One such expectation is discontinuation of Shortish Cloud(https://shrti.sh).  In the event that Shortish Cloud(https://shrti.sh) is shut down.  Users may or may not receive notice.  Users always have the ability to back up their short links by either exporting them through the app or by using their assigned API key to export using the Shlink API(https://api-spec.shlink.io/).

Users may not try and generate multiple API keys. Those who attempt this may find that they are no longer able to access Shortish Cloud(https://shruti.sh) Users have the ability to Export their API key to transfer it to another device. The API key will also be automatically backed up when using the mobile app, however users are still expected to download and store a copy of their API key in the event it is not backed up. We are unable to recover ANY lost API key.

Shortish or Shortish Cloud(https://shrti.sh) may revise these terms of service for its website at any time without notice. By using this website you are agreeing to be bound by the then current version of these terms of service.

Tl;DR
We are not responsible for any links our users create and are not responsible for any service disruptions. Shortish Cloud may be shut down some day and in that case your links will cease to function.  You are expected to keep a backup of your API key safe as it cannot be recovered.  Do not make multiple Shortish Cloud accounts(API keys) on multiple devices. Instead select \"Existing User\"'''),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "By clicking any button below, you are opting in and agreeing to the terms above",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton.filled(
                      child: Text("New User"),
                      onPressed: () {
                        //Get.to(() => ShortishCloudOptInView());
                        ////HIVE BOX terms of servise agreed to date
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton.filled(
                      child: Text("Existing User"),
                      onPressed: () {
                        //Get.to(() => ShortishCloudOptInView());
                      })
                ],
              ))
        ]));
  }
}
