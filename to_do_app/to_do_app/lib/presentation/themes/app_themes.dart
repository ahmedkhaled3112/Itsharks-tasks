import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.lightBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.indigo,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData();
}
