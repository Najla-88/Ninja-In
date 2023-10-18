import 'package:dio/dio.dart';

class OrderRepository {
  late Dio dio;
  OrderRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/order.php';

  Future<int> purchaseOrder(int orderId) async {
    try {
      var response = await dio.get(_baseUrl, queryParameters: {'id': orderId});
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      }
      return 0;
    } catch (e) {
      rethrow;
    }
  }
}
