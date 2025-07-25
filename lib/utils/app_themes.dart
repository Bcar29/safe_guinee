import 'package:flutter/material.dart';

class AppThemes {
  // light theme
  static final light = ThemeData(
    primaryColor: const Color.fromARGB(255, 63, 81, 181),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 63, 81, 181),
      primary: const Color.fromARGB(255, 63, 81, 181),
      brightness: Brightness.light,
      surface: Colors.white
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor:  Color(0xFFff5722),
      unselectedItemColor: Colors.grey
    )
  );

  // dark theme
  static final dark = ThemeData(
    primaryColor: const Color.fromARGB(255, 63, 81, 181),
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor:  Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 63, 81, 181),
      primary: const Color.fromARGB(255, 63, 81, 181),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
    ),
    cardColor: const Color(0xFF121212),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:  const Color(0xFF121212),
      selectedItemColor:  Color.fromARGB(255, 63, 81, 181),
      unselectedItemColor: Colors.grey
    )
  );


}
