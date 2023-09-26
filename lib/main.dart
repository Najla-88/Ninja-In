import 'package:flutter/material.dart';
import 'package:ninjain/cart_list.dart';
import 'package:ninjain/register/login.dart';
import 'package:ninjain/setting.dart';
import 'package:ninjain/shop/my_home_page.dart';
import 'package:ninjain/register/sign_up.dart';
import 'package:ninjain/theme/theme.dart';
import 'package:ninjain/theme/theme_provider.dart';
import 'package:ninjain/user_data.dart';
import 'package:ninjain/user_info_setting.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (_) => UserData(),
        ),
      ],
      // ChangeNotifierProvider(
      //   create: (context) => ThemeProvider(),
      child: MyApp(),
    ),

    // wrap the MaterialApp widget with
    // ChangeNotifierProvider from the provider package.
    // This will provide the ThemeProvider instance throughout the app.
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Ninja-In',
      // theme: themeProvider.themeData,
      theme: themeProvider.isDarkMode ? darkTheme : lightTheme,

      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/cartList': (context) => const CartList(),
        '/setting': (context) => Setting(),
        '/userInfo': (context) => UserInfo(),
      },
      initialRoute: '/',
      // initialRoute: '/login',
      // initialRoute: '/signup',

      // home: CartList(),
    );
  }
}
