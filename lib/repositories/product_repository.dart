import 'package:dio/dio.dart';
import 'package:ninjain/models/product_model.dart';

import 'image_repository.dart';

class ProductRepository {
  late Dio dio;
  ProductRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }

  final ImagesRepository imgRepo = ImagesRepository();

  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/products.php';

  Future<List<Product>> getProdByCate(int cateId) async {
    try {
      var response = await dio.get('$_baseUrl/getByCate',
          queryParameters: {'cateId': cateId.toString()});
      List<Product> prods = [];
      if (response.statusCode == 200) {
        var data = response.data as List;
        if (data.isNotEmpty) {
          for (var item in data) {
            final prod = Product.fromJson(item);
            prod.images = await imgRepo.getImagesByProd(prod.id!);
            prods.add(prod);
          }
        }
      }
      return prods;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProdByFeat(int featId) async {
    try {
      var response = await dio.get('$_baseUrl/getByFeate',
          queryParameters: {'featId': featId.toString()});
      List<Product> prods = [];
      if (response.statusCode == 200) {
        var data = response.data as List;
        if (data.isNotEmpty) {
          for (var item in data) {
            final prod = Product.fromJson(item);
            prod.images = await imgRepo.getImagesByProd(prod.id!);
            prods.add(prod);
          }
        }
      }
      return prods;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProdById(int id) async {
    try {
      var response = await dio
          .get('$_baseUrl/getById', queryParameters: {'id': id.toString()});

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          var prod = Product.fromJson(data);
          prod.images = await imgRepo.getImagesByProd(prod.id!);
          return prod;
        }
      }
      return Product();
    } catch (e) {
      rethrow;
    }
  }
}
