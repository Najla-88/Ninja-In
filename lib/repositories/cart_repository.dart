import 'package:dio/dio.dart';

import '../models/cart_model.dart';

class CartRepository {
  late Dio dio;
  CartRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/carts.php';
  Future<Cart> postCart(int userId, int prodId, String prodPrice) async {
    try {
      var response = await dio.post('$_baseUrl/addCart', data: {
        'prod_id': prodId.toString(),
        'user_id': userId.toString(),
        'quantity': '1',
        'price': prodPrice,
      });
      if (response.statusCode == 200) {
        var data = response.data;
        var crt = Cart.fromJson(data);
        return crt;
      }
      return Cart();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Cart>> getCarts(int userId) async {
    try {
      var response = await dio.get('$_baseUrl/getCarts', queryParameters: {
        'user_id': userId.toString(),
      });
      List<Cart> carts = [];
      if (response.statusCode == 200) {
        if (response.data != null) {
          var data = response.data as List;
          if (data.isNotEmpty) {
            for (var item in data) {
              carts.add(Cart.fromJson(item));
            }
          }
        } else {
          return [];
        }
      }
      return carts;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateCart(int cartId, int qty) async {
    try {
      var response = await dio
          .post('$_baseUrl/updateCart', data: {"id": cartId, "quantity": qty});
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> deleteCart(int cartId) async {
    try {
      var response =
          await dio.post('$_baseUrl/deleteCart', data: {"id": cartId});
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
