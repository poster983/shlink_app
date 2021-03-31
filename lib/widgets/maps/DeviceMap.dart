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
  DeviceMap({Key key, this.startingCoord, this.poiList, this.mapService})
      : super(key: key);

  LatLng startingCoord;
  List<MapPOI> poiList;
  MapService mapService;

  @override
  _DeviceMapState createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  a.AppleMapController appleController;
  g.GoogleMapController googleController;
  //pm.PlatformMapController platformMapController;

  @override
  void initState() {
    super.initState();
    if (widget.startingCoord == null) {
      widget.startingCoord = LatLng(0, 0);
    }

    if (widget.poiList == null) {
      widget.poiList = [];
    }

    if (widget.mapService == null) {
      if (!kIsWeb) {
        if (Platform.isAndroid) {
          widget.mapService = MapService.GoogleMaps;
        }
        if (Platform.isIOS) {
          widget.mapService = MapService.AppleMaps;
        }
      } else {
        widget.mapService = MapService.OpenStreetMap;
      }

    }
    //_appleMapsStarting = LatLng(widget.startingCoord.latitudeInRad, widget.startingCoord.longitudeInRad);
    //_slat = widget.startingCoord.latitudeInRad;
    //_slong = widget.startingCoord.longitudeInRad;
  }

  Widget chooseMapService() {
    if (widget.mapService == MapService.AppleMaps) {
      print("Loading Apple Maps");
      return a.AppleMap(
        /*circles: Set.from([
            Circle(circleId: CircleId("circletest"), center: )
          ]),*/
        annotations: Set.from(widget.poiList.map((e) {
          return e.toAppleMaps();
        })),
        onMapCreated: (_appleController) {
          appleController = _appleController;
          appleController.moveCamera(a.CameraUpdate.newLatLng(a.LatLng(
              widget.startingCoord.latitude, widget.startingCoord.longitude)));
        },
        //onMapCreated: _onMapCreated,
        initialCameraPosition: const a.CameraPosition(
          target: a.LatLng(0, 0),
        ),
      );
    }
    if (widget.mapService == MapService.GoogleMaps) {
      print("Loading Google Maps");
      return g.GoogleMap(
        markers: Set.from(widget.poiList.map((e) {
          return e.toGoogleMaps();
        })),
        onMapCreated: (controller) => googleController = controller,
        initialCameraPosition: g.CameraPosition(
            target: g.LatLng(
                widget.startingCoord.latitude, widget.startingCoord.longitude)),
      );
    }
    if (widget.mapService == MapService.OpenStreetMap) {
      print("Loading OpenStreetMap");
      return OpenStreetMap(
          startingCoord: widget.startingCoord,
          poiList: widget.poiList.map((e) {
            return e.toOSM();
          }).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return chooseMapService();
  }
}

enum MapService { GoogleMaps, AppleMaps, OpenStreetMap }
