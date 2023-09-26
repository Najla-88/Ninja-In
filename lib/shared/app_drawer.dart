import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user_data.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  final List<List> drawerItems = const [
    [Text('Shop'), Icon(Icons.shopify), '/'],
    // [Text('Categories'), Icon(Icons.category), '/categories'],
    [Text('Cart'), Icon(Icons.shopping_cart_outlined), '/cartList'],
    [Text('Setting'), Icon(Icons.settings), '/setting'],
  ];
  final String title;
  AppDrawer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case 'Shop':
        _selectedIndex = 0;
        break;
      case 'Cart':
        _selectedIndex = 1;
        break;
      case 'Setting':
        _selectedIndex = 2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Drawer(
      child: ListView(
        children: [
          if (userData.username != '' && userData.uemail != '')
            SizedBox(
              height: 200,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/product_image.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        userData.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        // vertical: 5.0,
                      ),
                      child: Text(
                        userData.uemail,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              child: GestureDetector(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/product_image.png'),
                      ),
                      Text(
                        'Tap to login',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.drawerItems.length,
            itemBuilder: (context, index) {
              final item = widget.drawerItems[index];

              return ListTile(
                title: item[0],
                trailing: item[1],
                selected: _selectedIndex == index,
                onTap: () {
                  // _onItemTapped(index);
                  Navigator.of(context).pushNamed(item[2]);
                  // Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
