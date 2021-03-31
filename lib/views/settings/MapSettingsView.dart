import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/widgets/maps/DeviceMap.dart';
import 'package:shlink_app/widgets/maps/MapPOI.dart';

class MapSettingsView extends StatefulWidget {
  MapSettingsView({Key key}) : super(key: key);

  @override
  _MapSettingsViewState createState() => _MapSettingsViewState();
}

class _MapSettingsViewState extends State<MapSettingsView> {
  String mapServiceChoice;
  final box = Hive.box("preferences");

  LatLng startingCoord = LatLng(29.719460, -95.388951);
  List<MapPOI> testPOI;
  @override
  void initState() {
    mapServiceChoice = box.get("mapService", defaultValue: "Open Street Map");

    print(mapServiceChoice);

    testPOI = [
      new MapPOI(
          location: LatLng(
              startingCoord.latitude + 0.1, startingCoord.longitude + 0.1),
          color: Colors.blue,
          subtitle: "Near Houston",
          title: "300 views"),
      new MapPOI(
          location: LatLng(
              startingCoord.latitude + 0.499, startingCoord.longitude + 0.499),
          color: Colors.red,
          subtitle: "Near nowhere",
          title: "1500 views"),
      new MapPOI(
          location: LatLng(40.689250, -74.044554),
          color: Colors.orange,
          subtitle: "Near New York City",
          title: "35 views"),
      new MapPOI(
          location: LatLng(51.538629, -0.016545),
          color: Colors.purple,
          subtitle: "Near Stratford",
          title: "93 views"),
      new MapPOI(
          location: startingCoord,
          color: Colors.green,
          subtitle: "Near Houston",
          title: "500 views"),
    ];
  }
  /*@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }*/

  List<Widget> generateListView() {
    List<Widget> list = [];
    //prefered map provider
    list.add(Text("Prefered map provider"));
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        list.add(
          RadioListTile<String>(
            title: const Text('Google Maps'),
            value: "GoogleMaps",
            groupValue: mapServiceChoice,
            onChanged: (String value) {
              setState(() {
                mapServiceChoice = value;
              });
            },
          ),
        );
      }
      if (Platform.isIOS) {
        list.add(
          RadioListTile<String>(
            title: const Text('Apple Maps'),
            value: "AppleMaps",
            groupValue: mapServiceChoice,
            onChanged: (String value) {
              setState(() {
                mapServiceChoice = value;
              });
            },
          ),
        );
      }
    }
    list.add(
      RadioListTile<String>(
        title: const Text('Open Street Map'),
        value: "OpenStreetMap",
        groupValue: mapServiceChoice,
        onChanged: (String value) {
          setState(() {
            mapServiceChoice = value;
          });
        },
      ),
    );

    list.add(
        Text("Maps are only supported by Shlink and Kutt.it at the moment"));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    print(MapService.values);
    return Scaffold(
      appBar: AppBar(
        title: Text("Map settings"),
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListView(shrinkWrap: true, children: generateListView()),
        SizedBox(height: 10),
        Expanded(
          child: Container(
              padding: EdgeInsets.all(15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: DeviceMap(
                    startingCoord: startingCoord,
                    poiList: testPOI,
                    mapService: MapService.values
                        .firstWhere((e) => e.toString() == "MapService."+mapServiceChoice),
                  ))),
        )
      ]),
    ));
  }
}
