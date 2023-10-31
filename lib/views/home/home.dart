import 'package:flutter/material.dart';
import '../../models/category_model.dart';
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
  Future<List<Category>> categoriesFuture = Future<List<Category>>.value([]);

  @override
  void initState() {
    super.initState();
    categoriesFuture = CategoryRepository().getCategories().then((value) {
      setState(() {
        isLoading = false;
      });
      return value;
    }).catchError((error) {
      throw Exception('Failed to load home page');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return FutureBuilder<List<Category>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Category> categories = snapshot.data ?? [];
            List<ShopPage> bodyContents =
                categories.map((cate) => ShopPage(cateId: cate.id!)).toList();
            return DefaultTabController(
              length: categories.length,
              child: Scaffold(
                appBar: AppAppbar(title: 'Shop', tabs: categories),
                drawer: AppDrawer(
                  title: 'Shop',
                ),
                body: FutureBuilder<List<ShopPage>>(
                  future: Future.wait(
                      bodyContents.map((shopPage) => Future.value(shopPage))),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Widget> tabContentList = snapshot.data ?? [];
                      return TabBarView(
                        children: tabContentList,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }
  }
}
