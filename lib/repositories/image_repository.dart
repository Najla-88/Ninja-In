import 'package:dio/dio.dart';
import 'package:ninjain/models/image_model.dart';

class ImagesRepository {
  late Dio dio;
  ImagesRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/images.php';

  Future<List<Images>> getImagesByProd(int prodId) async {
    try {
      var response = await dio.get(
        _baseUrl,
        queryParameters: {
          'prodId': prodId.toString(),
        },
      );
      List<Images> imgs = [];
      if (response.statusCode == 200) {
        var data = response.data as List;
        if (data.isNotEmpty) {
          for (var item in data) {
            imgs.add(Images.fromJson(item));
          }
        }
      }
      return imgs;
    } catch (e) {
      rethrow;
    }
  }
}
