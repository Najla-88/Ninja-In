import 'package:flutter/material.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/theme/theme.dart';
import 'package:ninjain/theme/theme_provider.dart';
import 'package:ninjain/providers/user_data.dart';
import 'package:ninjain/views/cart/cart_list.dart';
import 'package:ninjain/views/home/home.dart';
import 'package:ninjain/views/register/login.dart';
import 'package:ninjain/views/register/sign_up.dart';
import 'package:ninjain/views/setting/setting.dart';
import 'package:ninjain/views/setting/user_info_setting.dart';
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
        ChangeNotifierProvider<CartData>(
          create: (_) => CartData(),
        ),
      ],
      // if you have only one provider
      // ChangeNotifierProvider(
      //   create: (context) => ThemeProvider(),
      child: const MyApp(),
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
      // to make condition of the system mode
      // theme: MediaQuery.of(context).platformBrightness ? darkTheme : lightTheme,
      theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/cartList': (context) => const CartList(),
        '/setting': (context) => const Setting(),
        '/userInfo': (context) => const UserInfo(),
      },
    );
  }
}
