import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

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
