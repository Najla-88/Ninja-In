import 'package:flutter/material.dart';
import 'package:ninjain/shop/slider.dart';

import 'circule_products.dart';
import 'grid_items.dart';

Widget ShopPage(List<String> items) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    child: Expanded(
      child: ListView(
        children: [
          MySlider(sliderItems: items),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Text(
              'Features',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CirculeProducts(items),
          GridItems(items),
        ],
      ),
    ),
  );
}
