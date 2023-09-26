import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ninjain/shop/pic_view.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key, required this.sliderItems});
  final List<String> sliderItems;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.25,
        initialPage: 2,
        autoPlay: true,
      ),
      items: sliderItems.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.1,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Image(
                  image: AssetImage('assets/images/products/$i'),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PicView(picUrl: 'assets/images/products/$i');
                    },
                  ),
                );
              },
            );
          },
        );
      }).toList(),
    );
  }
}
