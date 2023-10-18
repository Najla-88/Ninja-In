import 'package:flutter/material.dart';
import 'package:ninjain/models/cart_model.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class CartData extends ChangeNotifier {
  List<Cart> cart = [];
  List<Product> product = [];

  void setCart(List<Cart> cart) {
    this.cart = cart;
    notifyListeners();
  }

  void addCart(Cart crt) async {
    for (var c in cart) {
      if (c.id == crt.id) {
        c.order_id = crt.order_id;
        c.price = crt.price;
        c.prod_id = crt.prod_id;
        c.quantity = crt.quantity;
        notifyListeners();
        return;
      }
    }
    final ProductRepository prodRepo = ProductRepository();
    final Product prod = await prodRepo.getProdById(crt.prod_id!);
    addProd(prod);
    cart.add(crt);
    notifyListeners();
  }

  void deleteCart(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void addProd(Product prod) {
    product.add(prod);
    notifyListeners();
  }

  void deletePrroduct(int index) {
    product.removeAt(index);
    notifyListeners();
  }

  void resetObject() {
    cart = [];
    product = [];
    notifyListeners();
  }
}
