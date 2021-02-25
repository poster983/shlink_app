import 'dart:ui';

class JSONTypeConverters {


  static Color colorFromJSON(int colorHex) => (colorHex == null)?null:new Color(colorHex);
  static int colorToJSON(Color color) => color.value;


}