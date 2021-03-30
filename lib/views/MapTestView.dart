import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/widgets/maps/DeviceMap.dart';
import 'package:shlink_app/widgets/maps/MapNavBar.dart';
import 'package:shlink_app/widgets/maps/OSM_Marker.dart';

class MapTestView extends StatelessWidget {
  MapTestView() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      DeviceMap(startingCoord: LatLng(29.719460, -95.388951),),
      Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10, left: 10, right: 10,),
        constraints: BoxConstraints(maxWidth: 410),
        child: MapNavBar()
      ),
      
    ],)
    
    );
  }
}
