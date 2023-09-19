import 'package:flutter/material.dart';
import 'package:ninjain/circule_products.dart';
import 'package:ninjain/grid_items.dart';
import 'package:ninjain/virt_and_horiz.dart';
// import 'package:ninjain/theme.dart';
import '../slider.dart';
import 'app_drawer.dart';
import 'bottom_bar.dart';
import 'horiz_products.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<String> items = ['Home', 'page1', 'page2'];
  final List<String> tabs = ['tab1', 'tab2', 'tab3', 'tab4'];

  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _onThemeChanged(bool isDark) {
  //   MyThemes.isDark = isDark;
  //   setState(() {});
  //   print('_onThemeChanged');
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ninja-In',
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
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: ListView(
                children: [
                  MySlider(sliderItems: items),
                  HorizProducts(5),
                  // VertAndHoriz(),
                  CirculeProducts(3),
                  GridItems(5),
                ],
              ),
            ),
            Column(
              children: [
                HorizProducts(10),
              ],
            ),
            VertAndHoriz(Vitems: 3, Hitems: 5),
            // ListView(
            //   children: [
            //     CirculeProducts(10),
            //   ],
            // ),
            GridItems(10),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(),
      ),
    );
  }
}
