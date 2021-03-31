import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  AppVersion({Key key}) : super(key: key);

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
  PackageInfo packageInfo;
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
                    ? Text(packageInfo.version +
                        " (" +
                        packageInfo.buildNumber +
                        ")")
                    : Text(packageInfo.version),
                (showAll) ? Text(packageInfo.packageName) : Container(),
              ],
            )
          : Container(),
    );
  }
}
