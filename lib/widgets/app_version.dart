import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/types/ShortUrl.dart';

class AppVersion extends StatefulWidget {
  AppVersion({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AppVersionState createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  PackageInfo? packageInfo;
  bool showAll = false;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo _packageInfo) {
      setState(() {
        packageInfo = _packageInfo;
      });

      print(packageInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => setState(() {
        showAll = true;
      }),
      child: (packageInfo != null)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Shortish"),
                (showAll)
                    ? Text(packageInfo!.version +
                        " (" +
                        packageInfo!.buildNumber +
                        ")")
                    : Text(packageInfo!.version),
                (showAll) ? (!kIsWeb)?Text(packageInfo!.packageName):Text("Progressive Web App") : Container(),
                (showAll) ? new IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: "WILL DELETE ALL HISTORY, SERVICES, SETTINGS AND YOUR SHORTISH CLOUD INSTANCE",
                  onPressed: () {
                    Hive.box("preferences").deleteFromDisk();
                    Hive.box("services").deleteFromDisk();
                    Hive.box<ShortUrl>("history").deleteFromDisk();
                    showSnackBar(text: "Deleted all services");
                  }) : Container(),
              ],
            )
          : Container(),
    );
  }
}
