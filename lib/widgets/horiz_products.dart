import 'package:flutter/material.dart';

import '../models/image_model.dart';

Widget HorizProducts(List<Images> items) {
  return SizedBox(
    height: 140,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: items.length - 1,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey[500],
              ),
              child: Image(
                // image: AssetImage('assets/images/products/${items[index]}')),
                image: MemoryImage(items[index + 1].img!),
              ));
        },
      ),
    ),
  );
}
