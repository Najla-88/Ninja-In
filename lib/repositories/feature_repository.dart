import 'package:dio/dio.dart';
import 'package:ninjain/models/feature_model.dart';

class FeatureRepository {
  late Dio dio;
  FeatureRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/features.php';

  Future<List<Features>> getFeatureByCateId(int cateId) async {
    try {
      var response = await dio.get(_baseUrl, queryParameters: {
        'cateId': cateId.toString(),
      });
      List<Features> feats = [];
      if (response.statusCode == 200) {
        var data = response.data as List;
        if (data.isNotEmpty) {
          for (var item in data) {
            feats.add(Features.fromJson(item));
          }
        }
      }
      return feats;
    } catch (e) {
      rethrow;
    }
  }
}
