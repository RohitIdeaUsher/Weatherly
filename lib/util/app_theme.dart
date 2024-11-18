import 'package:flutter/material.dart';

// final lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primarySwatch: Colors.blue,
//   scaffoldBackgroundColor: Colors.white,
// );

// final darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primarySwatch: Colors.blueGrey,
//   scaffoldBackgroundColor: const Color(0xff060720),
// );

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  indicatorColor: Colors.blue[100],
  cardColor: Colors.blue[100],
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  indicatorColor: const Color(0xff060720),
  scaffoldBackgroundColor: const Color(0xff060720),
  cardColor: Colors.blue[200],
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
);
