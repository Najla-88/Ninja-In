import 'package:flutter/material.dart';
import 'package:ninjain/models/feature_model.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/repositories/feature_repository.dart';
import 'package:ninjain/repositories/product_repository.dart';
import 'package:ninjain/widgets/slider.dart';
import '../../widgets/circule_products.dart';
import '../../widgets/grid_items.dart';

class ShopPage extends StatefulWidget {
  final int cateId;

  const ShopPage({super.key, required this.cateId});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late Future<List<Widget>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<List<Widget>> _fetchData() async {
    try {
      List<Product> prods =
          await ProductRepository().getProdByCate(widget.cateId);
      List<Feature> feats =
          await FeatureRepository().getFeatureByCateId(widget.cateId);

      return [
        MySlider(sliderItems: prods),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Text(
            'Features',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CirculeProducts(feats),
        GridItems(prods),
      ];
    } catch (error) {
      throw Exception('Failed to fetch data for shop page: $error');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataFuture = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Widget> bodyContents = snapshot.data ?? [];
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: bodyContents.length,
              itemBuilder: (context, index) => bodyContents[index],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
