import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/maps/OpenStreetMap.dart';

class DeviceMap extends StatefulWidget {
  DeviceMap({Key key}) : super(key: key);

  @override
  _DeviceMapState createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  Widget chooseMapService() {
    if (!kIsWeb) {
      // is not web
      if (Platform.isIOS) {
        //is on iOS/iPadOS
        print("Loading Apple Maps");
        return AppleMap(
          
          //onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0.0, 0.0),
          ),
        );
      }
    }

    return OpenStreetMap();
  }

  @override
  Widget build(BuildContext context) {
    return chooseMapService();
  }
}
