import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  primaryColorDark: Colors.white,

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
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey[600],
    selectedColor: Colors.black,
  ),

  // I didnt understand this
  // textButtonTheme: TextButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  //   ),
  // ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  primaryColorDark: Colors.black,
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
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey[600],
    selectedColor: Colors.white,
  ),
);
