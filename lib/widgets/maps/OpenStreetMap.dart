import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shlink_app/widgets/maps/OSM_Marker.dart';

class OpenStreetMap extends StatelessWidget {
  MapController mapController;
  MapPosition mapPosition;
  LatLng startingCoord;
  List<Marker> poiList;
  //LatLng mapPosition = new LatLng(0, 0);
  //WebBrowserController controller;

  /*_loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('iframe/test.html');
    print(fileText);
    String dataURL = Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
    print(dataURL);
    return dataURL;
    //controller.loadUrl(
    //  "data:text/html;charset=utf-8,%3Chtml%3E%20%20%0A%20%20%20%20%3Chead%3E%0A%20%20%20%20%20%20%20%20%3Cscript%20src%3D%22https%3A%2F%2Fcdn.apple-mapkit.com%2Fmk%2F5.0.x%2Fmapkit.js%22%3E%3C%2Fscript%3E%0A%20%20%20%20%3C%2Fhead%3E%0A%20%20%20%20%3Cbody%3E%0A%20%20%20%20%20%20%20%20%3Cdiv%20id%3D%22map%22%20style%3D%22margin%3A%200%20auto%3B%20width%3A%20100%25%3B%22%3ELoading%20map%3C%2Fdiv%3E%0A%20%20%20%20%20%20%20%20%3Cscript%20type%3D%22text%2Fjavascript%22%3E%0A%20%20%20%20%20%20%20%20const%20mapkit%20%3D%20window.mapkit%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20mapkit.init%28%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20authorizationCallback%3A%20%28done%29%20%3D%3E%20%7B%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20done%28%22eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IldCOTJVRlhXWkMifQ.eyJpc3MiOiIyQkpRWFVTNEFWIiwiaWF0IjoxNjE2OTcwMjUzLCJleHAiOjE2MTk1NjIyMjB9.MbWGsofHU7bBQZkWQcwNn4wtxOtBLq75ysEoKli1bSAyn1T3JflmSgJHfsE2Kib99sFjAUsuNKXfrhhHKDXqcQ%22%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%29%3B%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20const%20coordinate%20%3D%20new%20mapkit.Coordinate%2839.871287%2C%20-75.674710%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20const%20span%20%3D%20new%20mapkit.CoordinateSpan%281%2C%201%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20const%20region%20%3D%20new%20mapkit.CoordinateRegion%28coordinate%2C%20span%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20const%20map%20%3D%20new%20mapkit.Map%28%27map%27%2C%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20region%3A%20region%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20showsUserLocationControl%3A%20true%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20showsScale%3A%20mapkit.FeatureVisibility.Visible%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20const%20annotation%20%3D%20new%20mapkit.MarkerAnnotation%28coordinate%2C%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20title%3A%20%22Longwood%20Gardens%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20subtitle%3A%20%22Botanical%20Garden%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20map.addAnnotation%28annotation%29%3B%0A%20%20%20%20%20%20%20%20%3C%2Fscript%3E%0A%20%20%20%20%3C%2Fbody%3E%0A%3C%2Fhtml%3E");
  }*/
  /*final IFrameElement _iframeElement = IFrameElement();
  Widget _iframeWidget;
  UniqueKey iframeKey;*/

  /*String dataURL;
  final iframe = html.IFrameElement();*/

  OpenStreetMap({this.mapController, this.startingCoord, this.poiList}) {
    /*if (mapController == null) {
      mapController = new MapController();
    }*/

    if (startingCoord == null) {
      startingCoord = LatLng(0, 0);
    }

    if (poiList == null) {
      poiList = [];
    }
    //print(mapController.center);
    /*_loadHtmlFromAssets().then((url) {
      dataURL = url;
      iframe.src = dataURL;
    });
    iframe.height = "100%";
    iframe.width = "100%";
    iframe.style.border = 'none';*/
    /*_iframeElement.height = '100%';
    _iframeElement.width = '100%';
    _loadHtmlFromAssets().then((url) {
      _iframeElement.src = url;
    });
    
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory("iframeElement", (int viewId) => _iframeElement);

    _iframeWidget = HtmlElementView(
      key: iframeKey = UniqueKey(),
      viewType: 'iframeElement',
    );*/
  }
  /*html.Node mapDomTree() {
    /*final h1 = html.HeadingElement.h1();
  h1.appendText('Dart website');*/

    //iframe.src = abo;

    final div = html.DivElement()..append(iframe);

    return iframe;
  }*/

  double scrolling(double scrollPosition) {
    return pow(-0.0138 * scrollPosition, 2) +
        (0.2418 * scrollPosition) -
        0.0056;
    //return (exp(deg)-exp(-deg))/exp(deg)+exp(-deg);
  }

  @override
  Widget build(BuildContext context) {
    print("HI");
    return Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            /*print(log(pointerSignal.scrollDelta.dy.abs()));
            print(log(mapPosition.zoom));*/
            //print(mapController);
            if (pointerSignal.scrollDelta.dy < 0) {
              if (mapPosition.zoom <= 17) {
                print(scrolling(mapPosition.zoom));
                mapController.move(mapPosition.center, mapPosition.zoom + 1);
              }
            } else {
              print(log(mapPosition.zoom));
              mapController.move(mapPosition.center,
                  mapPosition.zoom - log(mapPosition.zoom) / 5);
            }
          }
        },
        child: Stack(children: [
          FlutterMap(
            mapController: mapController = MapController(),
            options: MapOptions(
              onPositionChanged: (position, hasGesture) {
                mapPosition = position;
                //position.
              },
              //controller: mapController,
              center: startingCoord,
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                  maxZoom: 17,
                  maxNativeZoom: 17,
                  minNativeZoom: 0,
                  tileProvider: const CachedTileProvider(),
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: poiList),
            ],
          ),
          Align(
              child: Text(
            "+",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          )),
        ]));

    /*SizedBox(
          width: 600,
          height: 400,
          child: MapWidget(

          location: MapLocation(
            query: 'Paris',
          ),
          markers: Set.from([
            MapMarker(
              query: 'Eiffel Tower',
            ),
          ]),
        )
        //WebNode(node: mapDomTree()),
        )*/
    /*SizedBox(
          width: 600,
          height: 400,
          child: WebBrowser(
            onCreated: (_controller) async {
              controller = _controller;
              controller.loadUrl(await _loadHtmlFromAssets());
            },
            interactionSettings: WebBrowserInteractionSettings(
              bottomBar: null,
              topBar: null,
            ),
            iframeSettings: WebBrowserIFrameSettings(
              allow: WebBrowserFeaturePolicy(geolocation: true)
            ),
            initialUrl: 'about:blank',
            javascriptEnabled: true,
          ),
        ),*/
    /*SizedBox(width: 600,
          height: 400,
          child: _iframeWidget
        ),*/
    /*TextButton(onPressed: () {
          _iframeElement.contentWindow.postMessage("hithere", "*");
        }, child: Text("PressMe")),*/
  }
}

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    //return NetworkImage(getTileUrl(coords, options));
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}
