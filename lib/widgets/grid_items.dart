import 'package:flutter/material.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/widgets/product_view.dart';

Widget GridItems(List<Product> product) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: product.length,
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
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                product[index].name.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            child:
                // Image.asset(
                //   'assets/product/products/${product[index]}',
                //   fit: BoxFit.cover,
                // ),
                //     Image.network(
                //   product[index].images![0],
                //   fit: BoxFit.cover,
                // ),
                Image.memory(
              product[index].images![0].img!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                // return PicView(picUrl: 'assets/product/products/$i');
                return ProductView(pic: product[index]);
              },
            ),
          );
        },
      );
    },
  );
}
