import 'package:flutter/material.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:ninjain/shared/app_drawer.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(context, 'Cart'),
      drawer: AppDrawer(title: 'Cart'),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8.0,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image(
              image: AssetImage('assets/images/product_image.png'),
            ),
            title: Text('Name:'),
            subtitle: Text('Price:'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    size: 13,
                  ),
                  onPressed: () {},
                ),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 13,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
