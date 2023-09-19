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

    // inputDecorationTheme: InputDecorationTheme(
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: const BorderSide(
    //       color: Colors.black87,
    //     ),
    //     borderRadius: BorderRadius.circular(50),
    //   ),
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: Colors.black87,
    //     ),
    //     borderRadius: BorderRadius.circular(50),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: Colors.redAccent,
    //     ),
    //     borderRadius: BorderRadius.circular(50),
    //   ),
    // ),
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
