import 'package:flutter/material.dart';

Widget CirculeProducts() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ListView.builder(
          shrinkWrap: true, // Allow the ListView to take up the available space
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const CircleAvatar(
                      maxRadius: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const CircleAvatar(
                      maxRadius: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const CircleAvatar(
                      maxRadius: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const CircleAvatar(
                      maxRadius: 25,
                    ),
                  ),
                ],
              ),
            );
            ;
          }),
    ],
  );
}


// class CirculeProducts extends StatelessWidget {
  // const CirculeProducts({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: 11,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text('index = $index'),
  //         );
  //       },
  //     ),
  //   );

    //     Container(
    //   // color: Colors.amber,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.all(10),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       child: CircleAvatar(),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
//   }
// }
