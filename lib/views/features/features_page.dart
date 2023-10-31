import 'package:flutter/material.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/widgets/grid_items.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({
    super.key,
    required this.featureName,
    required this.items,
  });
  final String featureName;
  final List<Product> items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppbar(title: 'Features'),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                featureName,
                style: const TextStyle(
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
