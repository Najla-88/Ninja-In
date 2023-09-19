import 'package:flutter/material.dart';

Widget GridItems(int VItems) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: VItems, // Number of vertical items
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          // Text('Vertical Item $index'),
          Container(
            margin: EdgeInsets.all(10),
            height: 200, // Height of the horizontal ListView
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 2, // Number of horizontal items
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  width: 150, // Width of each horizontal item
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Container(
                        height: 160,
                        width: 150,
                        color: Colors.black45,
                        child: Text('Picture'),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        color: Colors.black,
                        child: Text(
                          'Discription',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Text('Horizontal Item $index'),
                  // ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
