import 'package:flutter/material.dart';
import 'package:ninjain/circule_products.dart';
import 'package:ninjain/theme.dart';
import '../slider.dart';
import 'app_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<String> items = ['Home', 'page1', 'page2'];
  final List<String> tabs = ['tab1', 'tab2', 'tab3', 'tab4'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onThemeChanged(bool isDark) {
    MyThemes.isDark = isDark;
    setState(() {});
    print('_onThemeChanged');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            // indicatorColor: Colors.black,
            // // labelColor: Colors.black,
            // indicatorColor: Colors.white,
            // labelColor: Colors.white,
            tabs: tabs
                .map((tab) => Tab(
                      child: Text(tab),
                    ))
                .toList(),
          ),
        ),
        drawer: AppDrawer(
          drawerItems: items,
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          // onThemeChanged: _onThemeChanged,
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: ListView(
                children: [
                  MySlider(sliderItems: items),
                  CirculeProducts(),
                ],
              ),
            ),
            const Column(
              children: [
                ListTile(
                  tileColor: Colors.amber,
                  title: Text(
                    'Neejo Dattebayo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'neejo-ninja@example.com',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              children: [
                CirculeProducts(),
              ],
            ),
            const Text('data4'),
          ],
        ),
      ),
    );
  }
}
