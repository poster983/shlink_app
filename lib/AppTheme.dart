import 'package:flutter/material.dart';
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      brightness: Brightness.light,
      textTheme: ThemeData.light().textTheme
    ),
    //primaryColor: Colors.red,
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFE03A3C),
      textTheme: ButtonTextTheme.primary,
    ),
    brightness: Brightness.light,
    accentColor: Color(0xFFE03A3C),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    
  );
 
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    //primarySwatch: Colors.grey,
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFE03A3C),
      textTheme: ButtonTextTheme.primary,
    ),

    accentColor: Color(0xFFE03A3C),
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
