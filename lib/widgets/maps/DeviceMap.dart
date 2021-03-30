import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:latlong2/latlong.dart' as l;

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/maps/OpenStreetMap.dart';

class DeviceMap extends StatefulWidget {
  DeviceMap({Key key, this.startingCoord}) : super(key: key);

  l.LatLng startingCoord;

  @override
  _DeviceMapState createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  AppleMapController appleController;

  @override
  void initState() {
    super.initState();
    if (widget.startingCoord == null) {
      widget.startingCoord = l.LatLng(0, 0);
    }
    //_appleMapsStarting = LatLng(widget.startingCoord.latitudeInRad, widget.startingCoord.longitudeInRad);
    //_slat = widget.startingCoord.latitudeInRad;
    //_slong = widget.startingCoord.longitudeInRad;
  }

  Widget chooseMapService() {
    if (!kIsWeb) {
      // is not web
      if (Platform.isIOS) {
        //is on iOS/iPadOS
        print("Loading Apple Maps");
        return AppleMap(
          /*circles: Set.from([
            Circle(circleId: CircleId("circletest"), center: )
          ]),*/
          annotations: Set.from([
            Annotation(

                annotationId: AnnotationId("test"),
                infoWindow: InfoWindow(title: "5", snippet: "views"),
                icon: BitmapDescriptor.markerAnnotation,
                position: LatLng(widget.startingCoord.latitude,
                    widget.startingCoord.longitude))
          ]),
          onMapCreated: (_appleController) {
            appleController = _appleController;
            appleController.moveCamera(CameraUpdate.newLatLng(LatLng(
                widget.startingCoord.latitude,
                widget.startingCoord.longitude)));
          },
          //onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
          ),
        );
      }
    }
    print("Loading OpenStreetMap");
    return OpenStreetMap(
      startingCoord: widget.startingCoord,
    );
  }

  @override
  Widget build(BuildContext context) {
    return chooseMapService();
  }
}
