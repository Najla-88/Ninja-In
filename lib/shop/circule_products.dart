import 'package:flutter/material.dart';

import '../features_page.dart';

// ignore: non_constant_identifier_names
Widget CirculeProducts(List<String> items) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FeaturesPage(featureName: 'Feature ${index + 1}');
                    },
                  ),
                );
              },
              child: Container(
                // width: 50, // Set the desired width for the container
                height: MediaQuery.of(context).size.width * 0.15,
                // Set the desired height for the container
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40, // Set the desired radius for the CircleAvatar
                  backgroundImage:
                      AssetImage('assets/images/products/${items[index]}'),
                ),
              ),
            ),
            Text('Feature ${index + 1}'), // max char 10
          ],
        ),
      );
    },
  );
}
