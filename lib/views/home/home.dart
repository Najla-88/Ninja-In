import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../models/user_model.dart';
import '../../repositories/category_repository.dart';
import '../../shared/app_appbar.dart';
import '../../shared/app_drawer.dart';
import 'shop_page.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isLoading = true;
  String userName = '';
  String userEmail = '';
  final CategoryRepository cateRepo = CategoryRepository();
  List<Category> categories = [];
  @override
  void initState() {
    super.initState();
    cateRepo.getCategories().then((value) {
      setState(() {
        categories = value;
        isLoading = false;
      });
    }).catchError((error) {
      throw Exception('Failed to load home page');
    });
  }

  Future<List<Widget>> generateTabContent() async {
    List<Widget> tabContentList = [];

    for (var cate in categories) {
      var returned = await shopPage(cate.id!);
      tabContentList.add(returned);
    }

    return tabContentList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    Users user;
    if (arguments != null && arguments is Users) {
      user = arguments;
      userName = user.name!;
      userEmail = user.email!;
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
    if (isLoading) {
      // Display a loading indicator while data is being fetched
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppAppbar(context, 'Shop', tabs: categories, actions: acti),
          drawer: AppDrawer(
            title: 'Shop',
          ),
          body:
              // TabBarView(
              //   children: generateTabContent;
              FutureBuilder<List<Widget>>(
            future: generateTabContent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return TabBarView(
                  children: snapshot.data ?? [],
                );
              }
            },
          ),
        ),
      );
    }
  }
}
