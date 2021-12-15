import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.cyan,
    accentColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      color: Colors.cyan,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.cyan,
    ),
    bodyText1: TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 50,
    backgroundColor: Colors.cyan,
  ),
);
