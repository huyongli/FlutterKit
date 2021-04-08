import 'package:flutter/material.dart';

class ThemeFactory {
  static ThemeData build() {
    return ThemeData(
      primarySwatch: Colors.blue,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(color: Colors.black87, fontSize: 14),
          primary: Colors.white,
          elevation: 0,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black12, width: 0.5)),
        ),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
        bodyText2: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
