import 'package:flutter/material.dart';

final themeData = ThemeData(
  // main colors
  primaryColor: Colors.deepPurple,
  primaryColorLight: Colors.purple,

  // app bar theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.deepPurple,
    elevation: 1,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurpleAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple,
  )),
);
