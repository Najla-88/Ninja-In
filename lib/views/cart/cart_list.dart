import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/repositories/cart_repository.dart';
import 'package:ninjain/shared/app_appbar.dart';
import 'package:provider/provider.dart';

import '../../repositories/order_repository.dart';
import '../../shared/app_drawer.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  Timer? updateTimer;
  bool isUpdate = false;

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    updateTimer?.cancel();
    super.dispose();
  }

  void startTimer(int id, int qty, int orderId, double total) {
    // Cancel previous timer if it exists
    updateTimer?.cancel();

    // Start a new timer with a duration of 3 seconds
    updateTimer = Timer(const Duration(seconds: 3), () {
      CartRepository().updateCart(id, qty);
      OrderRepository().updateTotal(orderId, total);
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
            const SnackBar(
              content: Text(
                "please wait untile update your cart . . .",
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
          return true;
        }
      },
      child: Scaffold(
        appBar: const AppAppbar(title: 'Cart'),
        drawer: AppDrawer(title: 'Cart'),
        body: cartData.cart.isNotEmpty
            ? Stack(
                children: [
                  ListView(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartData.product.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8.0,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image(
                              image: MemoryImage(
                                  cartData.product[index].images![0].img!),
                            ),
                            title: Text(
                              cartData.product[index].name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              cartData.cart[index].price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[300],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 13,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if ((cartData.cart[index].quantity ?? 0) >
                                          0) {
                                        cartData.cart[index].quantity =
                                            (cartData.cart[index].quantity ??
                                                    0) -
                                                1;

                                        cartData.editPrice(cartData.cart[index],
                                            cartData.product[index].price ?? 0);
                                        isUpdate = true;
                                        cartData.updateTotal();
                                        startTimer(
                                            cartData.cart[index].id!,
                                            cartData.cart[index].quantity!,
                                            cartData.cart[index].order_id!,
                                            cartData.total);
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  cartData.cart[index].quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    size: 13,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      cartData.cart[index].quantity =
                                          (cartData.cart[index].quantity ?? 0) +
                                              1;

                                      cartData.editPrice(cartData.cart[index],
                                          cartData.product[index].price ?? 0);

                                      cartData.updateTotal();

                                      isUpdate = true;
                                      startTimer(
                                          cartData.cart[index].id!,
                                          cartData.cart[index].quantity!,
                                          cartData.cart[index].order_id!,
                                          cartData.total);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final isDeleted = await CartRepository()
                                        .deleteCart(cartData.cart[index].id!);
                                    if (isDeleted == 1) {
                                      cartData.deleteCart(index);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "item deleted succefully",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                          backgroundColor: Colors.green[20],
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (isDeleted == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
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
                    ],
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.all(20),
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
                          child: Text(
                            'Total: ${cartData.total} \$',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () async {
                            //  Text('Purchase... '),

                            final isOrderClosed = await OrderRepository()
                                .purchaseOrder(cartData.cart[0].order_id!);
                            if (isOrderClosed == 1) {
                              cartData.resetObject();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Purchase Succefully",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.green[20],
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else if (isOrderClosed == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
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
                      )),
                ],
              )
            : Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You haven\'t any product in cart',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        child: const Text(
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
      ),
    );
  }
}
