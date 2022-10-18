import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/widgets/maps/DeviceMap.dart';
import 'package:shlink_app/widgets/maps/MapNavBar.dart';
import 'package:shlink_app/widgets/maps/MapPOI.dart';

class VisitsMapView extends StatelessWidget {
  ShortUrl shortUrl;
  List<ShortUrlVisit> shortUrlVisits;
  Map<String, List<ShortUrlVisit>> visitsByLocation = {};
  //late Service? service;
  final box = Hive.box("preferences");

  List<MapPOI> poiList = [];
  List<LatLng> coordList = [];

  VisitsMapView(this.shortUrl, this.shortUrlVisits) {
    /*Service? _service = Services.find(shortUrl.serviceName);
    if (_service == null) {
      throw Exception("Could not find Service");
    }*/

    shortUrlVisits.forEach((e) {
      if (e.location != null) {
        var lst = visitsByLocation[e.location!.coordinates.latitude.toString() +
            e.location!.coordinates.longitude.toString()];
        if (lst == null) {
          visitsByLocation[e.location!.coordinates.latitude.toString() +
              e.location!.coordinates.longitude.toString()] = [];
        }
        visitsByLocation[e.location!.coordinates.latitude.toString() +
                e.location!.coordinates.longitude.toString()]!
            .add(e);
      }
    });

    visitsByLocation.forEach((key, value) {
      if (value.length > 0) {
        String near = "Unknown";
        if(value[0].location!.city !=null && value[0].location!.city != "") {
          near = "Near ${value[0].location!.city}";
        } else if (value[0].location!.region !=null && value[0].location!.region != "") {
          near = "Near ${value[0].location!.region}";
        } else if (value[0].location!.country !=null && value[0].location!.country != "") {
          near = "Near ${value[0].location!.country}";
        }
        poiList.add(MapPOI(
            location: value[0].location!.coordinates,
            color: randomColor(),
            title:
                "${value.length} ${(value.length == 1) ? "visit" : "visits"}",
            subtitle: near));
      }
    });

    coordList = poiList.map((element) {
      return element.location;
    }).toList();
  }

  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        DeviceMap(
          startingCoord: (coordList.length == 0)?LatLng(0,0):computeCentroid(coordList),
          poiList: poiList,
          mapService: MapService.DeviceDefault /*MapService.values.firstWhere(
              (e) =>
                  e.toString() ==
                  "MapService." + box.get("mapService", defaultValue: null),
              orElse: () => MapService.DeviceDefault),*/
        ),
        Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              right: 10,
            ),
            constraints: BoxConstraints(maxWidth: 410),
            child: MapNavBar(shortUrl: shortUrl)),
      ],
    ));
  }
}
