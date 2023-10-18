import 'package:flutter/material.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/repositories/cart_repository.dart';
import 'package:provider/provider.dart';

import '../providers/user_data.dart';
import 'horiz_products.dart';

class ProductView extends StatefulWidget {
  ProductView({super.key, required this.pic});
  final Product pic;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final cartData = Provider.of<CartData>(context);
    final CartRepository cartRepo = CartRepository();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.75,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                // image: AssetImage(pic),
                image: MemoryImage(widget.pic.images![0].img!),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                widget.pic.name!,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? Visibility(
                                  visible: isLoading,
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    if (userData.user.name != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final crt = await cartRepo.postCart(
                                          userData.user.id!,
                                          widget.pic.id!,
                                          widget.pic.price!);
                                      cartData.addCart(crt);

                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Product added to cart",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          backgroundColor: Color.fromARGB(
                                              255, 189, 254, 207),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  },
                                  child:
                                      // Text('Add to cart'),
                                      Icon(Icons.shopping_cart_outlined),
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).primaryColorDark,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.pic.price!}\$',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            widget.pic.description!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HorizProducts(widget.pic.images!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
