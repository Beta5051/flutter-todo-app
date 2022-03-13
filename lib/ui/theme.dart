import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: Colors.black,
  backgroundColor: Colors.white,
  canvasColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    elevation: 0,
  ),
);