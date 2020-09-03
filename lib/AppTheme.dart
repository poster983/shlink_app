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
      buttonColor: Colors.redAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    brightness: Brightness.light,
    accentColor: Colors.red,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    
  );
 
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    //primarySwatch: Colors.grey,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red,
      textTheme: ButtonTextTheme.primary,
    ),

    accentColor: Colors.red,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
