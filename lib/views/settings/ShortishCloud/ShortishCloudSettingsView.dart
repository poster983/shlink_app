import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/views/settings/ShortishCloud/ShortishCloudOptInView.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShortishCloudView extends StatefulWidget {
  ShortishCloudView({Key? key}) : super(key: key);

  @override
  _ShortishCloudViewState createState() => _ShortishCloudViewState();
}

class _ShortishCloudViewState extends State<ShortishCloudView> {
  final box = Hive.box("preferences");

  bool showAPIKey = false;
  late String apiKey;

  @override
  void initState() {
    //box.get("shortish_cloud_state", defaultValue: false);
  }

  Widget apiKeyModel() {
    String key = box.get("shortish_cloud_apikey", defaultValue: "");
    
    return Dialog(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
      Flexible(
        flex: 3,
        child: QrImage(
        data: key,
        version: QrVersions.auto,
        //size: 200.0,
      ),
      ),
      Flexible(
        flex: 3,
        child: SelectableText(key, style: TextStyle(fontSize: 20),)
      )
    ])));
  }

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
            width: Get.width,
            padding: EdgeInsets.all(8),
            child: ValueListenableBuilder(
                valueListenable: Hive.box<dynamic>('preferences').listenable(),
                builder: (context, Box box, widget) {
                  //Shortish cloud is enabled
                  if (box.get("shortish_cloud_enabled", defaultValue: false) ==
                      true) {
                    return Column(children: [
                      SizedBox(height: 30),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 300, maxWidth: 300),
                        child: Image.asset("assets/app_icon/rounded.png"),
                      ),
                      SizedBox(height: 10),
                      Text("Shortish Cloud", style: TextStyle(fontSize: 30)),
                      SizedBox(height: 10),
                      CupertinoButton.filled(
                          child: Text("Show API Key"),
                          onPressed: () {
                            Get.dialog(apiKeyModel());
                          })
                    ]);
                  }
                  //Shortish cloud is disabled. User needs to sign up
                  return Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 300, maxWidth: 300),
                        child: Image.asset("assets/app_icon/rounded.png"),
                      ),
                      SizedBox(height: 10),
                      Text("Shortish Cloud", style: TextStyle(fontSize: 30)),
                      Text(
                        "Currently Shortish offers an opt-in shortining service that unlocks this app's full potential.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text("Features", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 2),
                      Text(
                        "URL shortening using shrti.sh",
                      ),
                      Text(
                        "Custom slug (path)",
                      ),
                      Text(
                        "Click Analytics",
                      ),
                      Text(
                        "Location analytics",
                      ),
                      Text(
                        "History backup for shrti.sh links",
                      ),
                      Text(
                        "More to come soon",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Shortish Cloud is completely free and relies on donations for its usage. Please consider donating if you find this service useful",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      CupertinoButton.filled(
                          child: Text("Opt-In"),
                          onPressed: () {
                            Get.to(() => ShortishCloudOptInView());
                          })
                    ],
                  );
                })));
  }
}
