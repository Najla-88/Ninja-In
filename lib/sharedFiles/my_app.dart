import 'package:flutter/material.dart';
import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        // actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        color: Colors.black12,
      ),
      colorScheme: const ColorScheme.dark().copyWith(primary: Colors.white));

  final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        // actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        color: Colors.white54, //<-- SEE HERE
      ),
      colorScheme: const ColorScheme.light().copyWith(primary: Colors.black));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ninja-In',
      // theme: darkTheme,
      theme: lightTheme,
      home: const MyHomePage(title: 'Ninja-In'),
    );
  }
}
