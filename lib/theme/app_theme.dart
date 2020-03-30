import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Color.fromRGBO(42, 52, 71, 1),
    brightness: Brightness.light,
    backgroundColor: Color.fromRGBO(42, 52, 71, 1),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    fontFamily: 'Monte',
    hintColor: Colors.grey,
    buttonColor: Color.fromRGBO(44, 74, 104, 1),
    buttonTheme: ButtonThemeData(
      buttonColor: Color.fromRGBO(44, 74, 104, 1),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    ),
    textTheme: TextTheme(
        button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Monte')));
