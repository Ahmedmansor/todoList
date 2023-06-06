import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )));

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )));
}
