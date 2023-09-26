import 'package:flutter/material.dart';
import 'package:ninjain/shared/app_appbar.dart';
import '../shared/app_drawer.dart';
import 'shop_page.dart';
import '../models/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // AppUser? userInfo;
  String userName = '';
  String userEmail = '';

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

  final List<String> tabs = [
    'Weapons',
    'Accessories',
    'Equipments',
    'Masks',
    'Uniforms',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    AppUser user;
    if (arguments != null && arguments is AppUser) {
      user = arguments;
      print('===== >>> ${user.uEmail}');
      userName = user.uName!;
      userEmail = user.uEmail!;
      // print(userInfo?.uEmail);
      print('===== >>> ${userEmail}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final currentTheme = Theme.of(context);

    // Check the brightness of the current theme
    // final isDarkTheme = currentTheme.brightness == Brightness.dark;

    List<IconButton> acti = [
      IconButton(
        icon: const Icon(
          Icons.search,
        ),
        onPressed: () {},
      )
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppAppbar(context, 'Shop', tabs: tabs, actions: acti),
        drawer: AppDrawer(
          title: 'Shop',
        ),
        body: TabBarView(
          children: [
            ShopPage(items),
            ShopPage(items),
            ShopPage(items),
            ShopPage(items),
            ShopPage(items),
          ],
        ),
      ),
    );
  }
}
