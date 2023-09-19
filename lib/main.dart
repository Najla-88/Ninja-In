import 'package:flutter/material.dart';
import 'package:ninjain/login.dart';
import 'package:ninjain/my_home_page.dart';
import 'package:ninjain/sign_up.dart';
import 'package:ninjain/theme.dart';

import 'pic_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ninja-In',
      theme: MyThemes.isDark ? MyThemes.darkTheme : MyThemes.lightTheme,

      routes: {
        '/': (context) => MyHomePage(),
      },
      initialRoute: '/',

      // home: const MyHomePage(title: 'Ninja-In'),
      // home: LoginPage(),
      // home: SignUpPage(),
      // home: ScrollableAvatarList(),
      // home: PicView(),
    );
  }
}
