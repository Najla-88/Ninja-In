import 'package:flutter/material.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/repositories/product_repository.dart';
import '../models/feature_model.dart';
import '../views/features/features_page.dart';

Widget CirculeProducts(List<Features> items) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              ProductRepository prodRepo = ProductRepository();
              List<Product> prods =
                  await prodRepo.getProdByFeat(items[index].id!);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FeaturesPage(
                      featureName: items[index].name!,
                      items: prods,
                    );
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
                backgroundImage: MemoryImage(items[index].image!),
                // AssetImage('assets/images/products/${items[index]}'),
                // NetworkImage(items[index].img!),
              ),
            ),
          ),
          Text(
            items[index].name!,
            textAlign: TextAlign.center,
          ),
        ],
      );
    },
  );
}
