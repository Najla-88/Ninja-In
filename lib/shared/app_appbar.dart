import 'package:ninjain/shared/search_bar_delegate.dart';
import '../models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Category> tabs;

  const AppAppbar({
    Key? key,
    required this.title,
    this.tabs = const [],
  }) : super(key: key);

  @override
  Size get preferredSize {
    double tabBarHeight =
        tabs.isNotEmpty ? kToolbarHeight + 48 : kToolbarHeight;
    return Size.fromHeight(tabBarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Container(
        height: kToolbarHeight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 20,
          ),
        ),
      ),
      actions: [
        title == "Shop"
            ? IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch<String>(
                    context: context,
                    delegate: SearchBarDelegate(),
                  );
                },
              )
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
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
                  .map(
                    (tab) => Tab(
                      child: Text(tab.name ?? ''),
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }
}
