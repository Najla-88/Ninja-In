import 'package:flutter/material.dart';

Widget HorizProducts(int itemsC) {
  return SizedBox(
    height: 140,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        // separatorBuilder: (context, index) {
        //   return SizedBox(
        //     width: 10,
        //   );
        // },
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: itemsC,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            // height: 10,
            width: 100,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(9),
              color: Colors.grey,
            ),
            child: Column(
              children: [
                Container(
                  height: 93,
                  width: 100,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.vertical(
                      //   top: Radius.circular(9),
                      // ),
                      // color: Colors.black,
                      ),
                ),
                Container(
                  height: 27,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.vertical(
                    //   bottom: Radius.circular(9),
                    // ),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
