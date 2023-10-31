import 'package:flutter/material.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/repositories/product_repository.dart';
import '../models/feature_model.dart';
import '../views/features/features_page.dart';

Widget CirculeProducts(List<Feature> items) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              List<Product> prods =
                  await ProductRepository().getProdByFeat(items[index].id!);
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
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black54,
                  width: 0.1,
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: MemoryImage(items[index].image!),
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
