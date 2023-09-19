import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key, required this.sliderItems});
  final List<String> sliderItems;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.25,
        // enlargeCenterPage: true,
        initialPage: 2,
        autoPlay: true,
      ),
      items: sliderItems.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                decoration: BoxDecoration(color: Colors.grey[800]),
                child: Text(
                  'text $i',
                  style: const TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }
}
