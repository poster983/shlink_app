import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/maps/DeviceMap.dart';
import 'package:shlink_app/widgets/maps/MapNavBar.dart';

class MapTestView extends StatelessWidget {
  MapTestView() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      DeviceMap(),
      FlutterLogo(size: 100,),
      Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10, left: 10, right: 10,),
        constraints: BoxConstraints(maxWidth: 410),
        child: MapNavBar()
      )
      
    ],)
    
    );
  }
}
