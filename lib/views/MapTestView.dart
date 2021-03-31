import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/widgets/maps/DeviceMap.dart';
import 'package:shlink_app/widgets/maps/MapNavBar.dart';
import 'package:shlink_app/widgets/maps/MapPOI.dart';
import 'package:shlink_app/widgets/maps/OSM_Marker.dart';

class MapTestView extends StatelessWidget {
  LatLng startingCoord = LatLng(29.719460, -95.388951);
  List<MapPOI> testPOI;
  final box = Hive.box("preferences");

  MapTestView() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        DeviceMap(
          startingCoord: startingCoord,
          poiList: testPOI,
          mapService: MapService.values.firstWhere(
              (e) =>
                  e.toString() ==
                  "MapService." + box.get("mapService", defaultValue: null),
              orElse: () => null),
        ),
        Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              right: 10,
            ),
            constraints: BoxConstraints(maxWidth: 410),
            child: MapNavBar()),
      ],
    ));
  }
}
