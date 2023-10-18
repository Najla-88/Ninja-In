import 'package:flutter/material.dart';
import 'package:ninjain/models/feature_model.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/repositories/feature_repository.dart';
import 'package:ninjain/repositories/product_repository.dart';
import 'package:ninjain/widgets/slider.dart';
import '../../widgets/circule_products.dart';
import '../../widgets/grid_items.dart';

Future<Widget> shopPage(int cateId) async {
  final ProductRepository prodRepo = ProductRepository();
  final FeatureRepository featRepo = FeatureRepository();

  List<Product> prods = await prodRepo.getProdByCate(cateId);
  List<Features> feats = await featRepo.getFeatureByCateId(cateId);
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    child: Expanded(
      child: ListView(
        children: [
          MySlider(sliderItems: prods),
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
          CirculeProducts(feats),
          GridItems(prods),
        ],
      ),
    ),
  );
}
