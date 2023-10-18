import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/repositories/cart_repository.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:provider/provider.dart';

import '../../repositories/order_repository.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  CartRepository cartRepo = CartRepository();
  OrderRepository orderRepo = OrderRepository();
  Timer? updateTimer;
  bool isUpdate = false;
  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    updateTimer?.cancel();
    super.dispose();
  }

  void startTimer(int id, int qty) {
    // Cancel previous timer if it exists
    updateTimer?.cancel();

    // Start a new timer with a duration of 5 seconds
    updateTimer = Timer(Duration(seconds: 5), () {
      cartRepo.updateCart(id, qty);
      isUpdate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartData>(context);

    return WillPopScope(
      onWillPop: () async {
        if (cartData.cart.isNotEmpty && isUpdate == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "please wait untile update your cart",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Color.fromRGBO(250, 255, 159, 1),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent default back button behavior
        } else {
          Navigator.of(context).popUntil((route) => false);
          Navigator.of(context).pushNamed('/');
          return true; // Allow default back button behavior
        }
      },
      child: Scaffold(
        appBar: AppAppbar(context, 'Cart'),
        // drawer: AppDrawer(title: 'Cart'),
        body: ListView(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cartData.product.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image(
                      image:
                          MemoryImage(cartData.product[index].images![0].img!),
                    ),
                    title: Text(
                      cartData.product[index].name ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      cartData.product[index].price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[300],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 13,
                          ),
                          onPressed: () {
                            setState(() {
                              if ((cartData.cart[index].quantity ?? 0) > 0) {
                                cartData.cart[index].quantity =
                                    (cartData.cart[index].quantity ?? 0) - 1;
                                isUpdate = true;
                                startTimer(cartData.cart[index].id!,
                                    cartData.cart[index].quantity!);
                              }
                            });
                          },
                        ),
                        Text(
                          cartData.cart[index].quantity.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 13,
                          ),
                          onPressed: () {
                            setState(() {
                              cartData.cart[index].quantity =
                                  (cartData.cart[index].quantity ?? 0) + 1;
                              isUpdate = true;
                              startTimer(cartData.cart[index].id!,
                                  cartData.cart[index].quantity!);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            final isDeleted = await cartRepo
                                .deleteCart(cartData.cart[index].id!);
                            if (isDeleted == 1) {
                              cartData.deleteCart(index);
                              cartData.deletePrroduct(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "item deleted succefully",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.green[20],
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (isDeleted == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "ERROR: item didn\'t deleted !",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            cartData.cart.length > 0
                ? Container(
                    margin: EdgeInsets.all(20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorDark,
                        backgroundColor: Theme.of(context).primaryColor,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.1,
                          50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('purchase'),
                      onPressed: () async {
                        final isOrderClosed = await orderRepo
                            .purchaseOrder(cartData.cart[0].order_id!);
                        if (isOrderClosed == 1) {
                          cartData.resetObject();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Purchase Succefully",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.green[20],
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (isOrderClosed == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "ERROR: Didn\'t Purchase!",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You haven\'t any product in cart',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Go shopping now :)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => false);
                              Navigator.of(context).pushNamed('/');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
