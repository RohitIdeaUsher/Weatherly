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
  textTheme: lightTextTheme,
  iconTheme: const IconThemeData(color: Colors.black87),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    labelStyle: TextStyle(color: Colors.black87),
    hintStyle: TextStyle(color: Colors.black45),
  ),
);

const lightTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  ),
  bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
  ),
  labelLarge: TextStyle(fontSize: 16, color: Colors.black54),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  indicatorColor: const Color(0xff060720),
  scaffoldBackgroundColor: const Color(0xff060720),
  cardColor: Colors.blue[200],
  textTheme: darkTextTheme,
  iconTheme: const IconThemeData(color: Colors.white70),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff1f1f2e),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white60),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: TextStyle(color: Colors.white38),
  ),
);

const darkTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  ),
  bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  ),
  labelLarge: TextStyle(fontSize: 16, color: Colors.white60),
);
