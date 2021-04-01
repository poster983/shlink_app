import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:google_maps_flutter/google_maps_flutter.dart' as g;
//import 'package:platform_maps_flutter/platform_maps_flutter.dart' as pm;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/widgets/maps/OSM_Marker.dart';
import 'package:uuid/uuid.dart';

class MapPOI {
  LatLng location;
  Color? color;
  Widget? innerWidget;
  String? title;
  String? subtitle;

  MapPOI({required this.location, this.color, this.innerWidget, this.title, this.subtitle}) {
    if (color == null) {
      color = Colors.red;
    }
    if (innerWidget == null) {
      innerWidget = Icon(
        CupertinoIcons.map_pin,
        size: 20,
        color: Colors.white,
      );
    }
  }

  Marker toOSM() {
    return Marker(
      width: 70,
      height: 150,
      point: location,
      builder: (ctx) => Container(
        child: Center(
            child: OSMMarker(
          title: title,
          subtitle: subtitle,
          color: color!,
          content: this.innerWidget!,
          size: 50,
        )),
      ),
    );
  }

  apple.Annotation toAppleMaps() {
    return apple.Annotation(
        annotationId: apple.AnnotationId(Uuid().v4()),
        infoWindow: apple.InfoWindow(
          title: title,
          snippet: subtitle
        ),
        icon: apple.BitmapDescriptor.markerAnnotation,
        position: apple.LatLng(location.latitude, location.longitude));
  }

  g.Marker toGoogleMaps() {
    return g.Marker(
      markerId: g.MarkerId(Uuid().v4()),
      icon: g.BitmapDescriptor.defaultMarkerWithHue(HSVColor.fromColor(color!).hue),
      position: g.LatLng(location.latitude, location.longitude),
      infoWindow: g.InfoWindow(title: title, snippet: subtitle)
    );
  }

  /*pm.Marker toPlatformMaps() {
    return pm.Marker(
      markerId: pm.MarkerId(Uuid().v4()),
      position: pm.LatLng(location.latitude, location.longitude),
      icon: apple.BitmapDescriptor.markerAnnotation,
      
    );
  }*/
}
