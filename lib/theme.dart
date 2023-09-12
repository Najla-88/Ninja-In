import 'package:flutter/material.dart';

class MyThemes {
  static bool isDark = true;
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      color: Colors.black12,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      // indicatorColor: Colors.white,// doesnt work -_-
    ),
  );

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      color: Colors.white54,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      // indicatorColor: Colors.black,
    ),
  );
}
