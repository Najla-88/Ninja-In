import 'package:flutter/material.dart';

// This class will handle the state and logic
// for managing the dark mode.

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();

// it notifies all the listeners that are listening to changes in
// the state managed by the ChangeNotifier.
// This allows dependent widgets to be rebuilt and reflect the updated state.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
