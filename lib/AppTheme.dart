import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  //
  AppTheme._();

  static double get padding { return (Get.width > 500) ? 60 : 20;}

  static final ThemeData lightTheme = ThemeData(
    fontFamily: "WorkSans",
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      actionsIconTheme: IconThemeData(color: Colors.grey),
      iconTheme: IconThemeData(color: Colors.grey),
      color: Colors.white,
      brightness: Brightness.light,
      textTheme:
          TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 20)),
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
    fontFamily: "WorkSans",
    primarySwatch: Colors.red,
    //primarySwatch: Colors.grey,
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFE03A3C),
      textTheme: ButtonTextTheme.primary,
    ),

    accentColor: Color(0xFFE03A3C),
    //backgroundColor: Colors.black,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData blackTheme = darkTheme.copyWith(
    canvasColor: Color.fromRGBO(0, 0, 0, 1),
    backgroundColor: Color.fromRGBO(0, 0, 0, 1),
    scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
    cardColor: Color.fromRGBO(21, 21, 21, 1),
    dialogBackgroundColor: Color.fromRGBO(21, 21, 21, 1),
    
  );
}

class AppColors {
  static Color black = Color.fromRGBO(23, 24, 35, 1);
  static Color orange = Color.fromRGBO(251, 138, 40, 1);
  static Color red = Color.fromRGBO(255, 83, 91, 1);
  static Color green = Color.fromRGBO(59, 186, 146, 1);
  static Color lightBlue = Color.fromRGBO(93, 196, 243, 1);
  static Color blue = Color.fromRGBO(71, 99, 235, 1);
  static Color purple = Color.fromRGBO(112, 112, 255, 1);

  static final Color shortish = Color.fromRGBO(251, 54, 64, 1);
}
