import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:latlong2/latlong.dart';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as a;
import 'package:google_maps_flutter/google_maps_flutter.dart' as g;
import 'package:flutter/material.dart';
//import 'package:platform_maps_flutter/platform_maps_flutter.dart' as pm;
import 'package:shlink_app/widgets/maps/MapPOI.dart';
import 'package:shlink_app/widgets/maps/OpenStreetMap.dart';

class DeviceMap extends StatefulWidget {
  DeviceMap({Key key, this.startingCoord}) : super(key: key);

  LatLng startingCoord;

  @override
  _DeviceMapState createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  a.AppleMapController appleController;
  g.GoogleMapController googleController;
  //pm.PlatformMapController platformMapController;
  MapPOI testPOI;
  MapPOI testPOI2;
  MapPOI testPOI3;

  @override
  void initState() {
    super.initState();
    if (widget.startingCoord == null) {
      widget.startingCoord = LatLng(0, 0);
    }

    testPOI = new MapPOI(
        location: widget.startingCoord,
        color: Colors.green,
        title: "500 views");
    testPOI2 = new MapPOI(
        location: LatLng(widget.startingCoord.latitude + 0.1,
            widget.startingCoord.longitude + 0.1),
        color: Colors.blue,
        title: "300 views");
    testPOI3 = new MapPOI(
        location: LatLng(widget.startingCoord.latitude + 0.5,
            widget.startingCoord.longitude + 0.5),
        color: Colors.red,
        subtitle: "Near nowhere",
        title: "1500 views");
    //_appleMapsStarting = LatLng(widget.startingCoord.latitudeInRad, widget.startingCoord.longitudeInRad);
    //_slat = widget.startingCoord.latitudeInRad;
    //_slong = widget.startingCoord.longitudeInRad;
  }

  Widget chooseMapService() {
    if (!kIsWeb) {
      // is not web

      //platform is ios or android
      /*if (Platform.isIOS || Platform.isAndroid) {
        return pm.PlatformMap(
            markers: Set.from([
              
            ]),

            onMapCreated: (controller) {
              platformMapController = controller;
              //await Future.delayed(Duration(milliseconds: 500));
              platformMapController.animateCamera(
                  pm.CameraUpdate.newCameraPosition(pm.CameraPosition(
                      target: pm.LatLng(widget.startingCoord.latitude,
                          widget.startingCoord.longitude))));
            },
            initialCameraPosition: pm.CameraPosition(
              target: const pm.LatLng(0, 0),
              zoom: 16.0,
            ));
      }*/
      if (Platform.isAndroid) {
        //is android
        print("Loading Google Maps");
        return g.GoogleMap(
          markers: Set.from([testPOI.toGoogleMaps(), testPOI2.toGoogleMaps(), testPOI3.toGoogleMaps()]),
          onMapCreated: (controller) => googleController = controller,
          initialCameraPosition: g.CameraPosition(
              target: g.LatLng(widget.startingCoord.latitude,
                  widget.startingCoord.longitude)),
        );
      }
      if (Platform.isIOS) {
        //is on iOS/iPadOS
        print("Loading Apple Maps");
        return a.AppleMap(
          /*circles: Set.from([
            Circle(circleId: CircleId("circletest"), center: )
          ]),*/
          annotations:
              Set.from([testPOI.toAppleMaps(), testPOI2.toAppleMaps(), testPOI3.toAppleMaps()]),
          onMapCreated: (_appleController) {
            appleController = _appleController;
            appleController.moveCamera(a.CameraUpdate.newLatLng(a.LatLng(
                widget.startingCoord.latitude,
                widget.startingCoord.longitude)));
          },
          //onMapCreated: _onMapCreated,
          initialCameraPosition: const a.CameraPosition(
            target: a.LatLng(0, 0),
          ),
        );
      }
    }
    print("Loading OpenStreetMap");
    return OpenStreetMap(
        startingCoord: widget.startingCoord,
        poiList: [testPOI.toOSM(), testPOI2.toOSM(), testPOI3.toOSM()]);
  }

  @override
  Widget build(BuildContext context) {
    return chooseMapService();
  }
}
