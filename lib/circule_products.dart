import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CirculeProducts(int rowNum) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ListView.builder(
        shrinkWrap: true, // Allow the ListView to take up the available space
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rowNum,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const CircleAvatar(
                    maxRadius: 25,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const CircleAvatar(
                    maxRadius: 25,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const CircleAvatar(
                    maxRadius: 25,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: const CircleAvatar(
                    maxRadius: 25,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
