import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapPOI {
  LatLng location;
  Color color;
  Widget innerWidget;
  String title;
  String subtitle;

  MapPOI({@required this.location, this.color, this.innerWidget, this.title, this.subtitle}) {
    if (color == null) {
      color = Colors.red;
    }
    if (innerWidget == null) {
      innerWidget = Icon(
        CupertinoIcons.map_pin,
        size: 25,
      );
    }
  }
}
