import 'package:flutter/material.dart';
import 'app_drawer.dart';

// home page widget
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
              indicatorColor: Colors.black,
              labelColor: Colors.black,
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
          ),
          body: TabBarView(
            children: [
              Text('data1'),
              Text('data2'),
              Text('data3'),
              Text('data4'),
            ],
          )),
    );
  }
}
