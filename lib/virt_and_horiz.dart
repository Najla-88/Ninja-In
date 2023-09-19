import 'package:flutter/material.dart';

class VertAndHoriz extends StatelessWidget {
  VertAndHoriz({super.key, required this.Vitems, required this.Hitems});

  final int Vitems;
  final int Hitems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Vitems, // Number of vertical items
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Text('Vertical Item $index'),
            Container(
              height: 200, // Height of the horizontal ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Hitems, // Number of horizontal items
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 150, // Width of each horizontal item
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
