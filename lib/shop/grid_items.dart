import 'package:flutter/material.dart';
import 'package:ninjain/shop/pic_view.dart';

Widget GridItems(List<String> images) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: images.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.0,
    ),
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
              width: 0.1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: GridTile(
            child: Image.asset(
              'assets/images/products/${images[index]}',
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                'discription description description description',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PicView(
                    picUrl: 'assets/images/products/${images[index]}');
              },
            ),
          );
        },
      );
    },
  );
}
