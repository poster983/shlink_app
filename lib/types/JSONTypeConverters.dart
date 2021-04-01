import 'dart:ui';

import 'package:latlong2/latlong.dart';

class JSONTypeConverters {
  //COLOR CONVERTERS
  static Color? colorFromJSON(int? colorHex) =>
      (colorHex == null) ? null : new Color(colorHex);
  static int colorToJSON(Color? color) => color!.value;

  //LATLNG CONVERTERS
  static LatLng latLngFromJSON(String coords) {
    //if (coords != null) {
      int index = coords.indexOf(",");
      double lat = double.parse(coords.substring(0, index));
      double long = double.parse(coords.substring(index + 1));
      return LatLng(lat, long);
    //}
    //return null;
  }

  static String latLngToJSON(LatLng coords) {
    return coords.latitude.toString() + "," + coords.longitude.toString();
  }
}
