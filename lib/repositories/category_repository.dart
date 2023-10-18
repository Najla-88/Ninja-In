import 'package:dio/dio.dart';
import '../models/category_model.dart';

class CategoryRepository {
  late Dio dio;
  CategoryRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/category.php';
  Future<List<Category>> getCategories() async {
    try {
      var response = await dio.get(_baseUrl);
      List<Category> cates = [];
      if (response.statusCode == 200) {
        var data = response.data as List;
        if (data.isNotEmpty) {
          for (var item in data) {
            cates.add(Category.fromJson(item));
          }
        }
      }
      return cates;
    } catch (e) {
      rethrow;
    }
  }
}
