import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_data.dart';

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
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
    List<List> drawerItems = userData.user.name != null
        ? [
            [Text('Shop'), Icon(Icons.shopify), '/'],
            [Text('Cart'), Icon(Icons.shopping_cart_outlined), '/cartList'],
            [Text('Setting'), Icon(Icons.settings), '/setting'],
          ]
        : [
            [Text('Shop'), Icon(Icons.shopify), '/'],
          ];
    Uint8List? userpicData = userData.user.img;

    return Drawer(
      child: ListView(
        children: [
          if (userData.user.name != null && userData.user.email != null)
            SizedBox(
              height: 200,
              child: GestureDetector(
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
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            userpicData != null && userpicData.isNotEmpty
                                ? MemoryImage(userpicData)
                                : const AssetImage(
                                        'assets/images/product_image.png')
                                    as ImageProvider<Object>?,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          userData.user.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          userData.user.email!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/userInfo');
                },
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
            itemCount: drawerItems.length,
            itemBuilder: (context, index) {
              final item = drawerItems[index];

              return ListTile(
                title: item[0],
                trailing: item[1],
                selected: _selectedIndex == index,
                onTap: () async {
                  Navigator.of(context).pushNamed(item[2]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
