import 'package:flutter/material.dart';

import 'horiz_products.dart';

class PicView extends StatelessWidget {
  PicView({super.key, required this.picUrl});
  final String picUrl;

  final List<String> items = [
    'combat-bracer-arm-gauntlets.jpg',
    'dark-assassin-ninja-swords.jpg',
    'dark-assassin-tactical-wakizashi-5053718.jpg',
    'dark-night-ninja-swords.jpg',
    'dark-night-ninja-swords-5577738.jpg',
    'ninja-hand-claws.jpg',
    'ninja-hand-claws-1241963.jpg',
    'post-apocalyptic-hook-blade-sword.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.75,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage(picUrl),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Product Name',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Product Description',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Price: \$99.99',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Add to cart'),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColorDark,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                HorizProducts(items),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
