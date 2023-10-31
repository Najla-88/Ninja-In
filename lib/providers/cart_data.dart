import 'package:flutter/material.dart';
import 'package:ninjain/models/cart_model.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class CartData extends ChangeNotifier {
  List<Cart> cart = [];
  List<Product> product = [];
  double total = 0.0;

  void setCart(List<Cart> cart) {
    this.cart = cart;
    updateTotal();
    notifyListeners();
  }

  // add item to cart
  void addCart(Cart crt) async {
    for (var c in cart) {
      // if the item already exist in the cart_data
      // replace the item
      // bcoz it return the added item from api, and in the api it increase its quantity
      if (c.id == crt.id) {
        c.order_id = crt.order_id;
        c.price = crt.price;
        c.prod_id = crt.prod_id;
        c.quantity = crt.quantity;
        updateTotal();
        notifyListeners();
        return;
      }
    }
    // if it is not in cart_data add it in the cart and product list
    final Product prod = await ProductRepository().getProdById(crt.prod_id!);
    addProd(prod);
    cart.add(crt);
    updateTotal();
    notifyListeners();
  }

  void deleteCart(int index) {
    cart.removeAt(index);
    deleteProduct(index);
    updateTotal();

    notifyListeners();
  }

  void addProd(Product prod) {
    product.add(prod);
    notifyListeners();
  }

  void editPrice(Cart crt, double price) {
    crt.price = price * (crt.quantity ?? 1);
    crt.price = double.parse(crt.price!.toStringAsFixed(3));
    updateTotal();

    notifyListeners();
  }

  void deleteProduct(int index) {
    product.removeAt(index);
    notifyListeners();
  }

  void resetObject() {
    cart = [];
    product = [];
    total = 0.0;
    notifyListeners();
  }

  void updateTotal() {
    total = 0;
    for (final c in cart) {
      total += c.price ?? 0;
    }
    total = double.parse(total.toStringAsFixed(3));
    notifyListeners();
  }
}
