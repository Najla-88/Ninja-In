import '../models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

AppBar AppAppbar(
  BuildContext context,
  String title, {
  List<IconButton> actions = const [],
  // List<String> tabs = const [],
  List<Category> tabs = const [],
}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
    actions: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            ...actions,
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) => GestureDetector(
                onTap: () {
                  themeProvider.toggleTheme();
                },
                child: SizedBox(
                  child: Icon(
                    themeProvider.isDarkMode ? Icons.sunny : Icons.nightlight,
                    size: 27.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
    bottom: tabs.isNotEmpty
        ? TabBar(
            isScrollable: true,
            physics: BouncingScrollPhysics(),
            tabs: tabs
                .map((tab) => Tab(
                      // child: Text(tab),
                      child: Text(tab.name ?? ''),
                    ))
                .toList(),
          )
        : null, // Set bottom to null if tabs list is empty
  );
}
