import 'package:flutter/material.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/shared/app_drawer.dart';
import 'package:ninjain/shop/grid_items.dart';

class FeaturesPage extends StatelessWidget {
  FeaturesPage({super.key, required this.featureName});
  final String featureName;
  final List<String> items = [
    'combat-bracer-arm-gauntlets.jpg',
    'dark-assassin-ninja-swords.jpg',
    'dark-assassin-tactical-wakizashi-5053718.jpg',
    'dark-night-ninja-swords.jpg',
    'dark-night-ninja-swords-5577738.jpg',
    'ninja-hand-claws.jpg',
    'ninja-hand-claws-1241963.jpg',
    'post-apocalyptic-hook-blade-sword.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(context, 'Features'),
      drawer: AppDrawer(title: 'Feature'),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                featureName,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          GridItems(items),
        ],
      ),
    );
  }
}
