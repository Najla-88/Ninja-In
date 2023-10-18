import 'package:dio/dio.dart';
import 'package:ninjain/models/user_model.dart';

class UserRepository {
  late Dio dio;
  UserRepository() {
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
  }
  static const String _baseUrl =
      'http://192.168.221.110:8080/ninjaIn/users.php';

  // signup
  Future<Users> signup(Users user) async {
    try {
      var response = await dio.post('$_baseUrl/signup', data: user.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        var u = Users.fromJson(data);
        if (u.name != null) {
          return u;
        }
      }
      return Users();
    } catch (e) {
      return Users();
    }
  }

  // login
  Future<Users> login(Users user) async {
    try {
      var response = await dio.post('$_baseUrl/login', data: user.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        var u = Users.fromJson(data);
        if (u.name != null) {
          return u;
        }
      }
      return Users();
    } catch (e) {
      return Users();
    }
  }

  Future<int> deleteeUser(Users user) async {
    try {
      var response = await dio.post('$_baseUrl/delete', data: user.toJson());
      if (response.statusCode == 200) {
        var data = response.data as int;
        return data;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateUser(Users user) async {
    try {
      var response = await dio.post('$_baseUrl/update', data: user.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<Users> getUserById(int id) async {
    try {
      var response = await dio.post(
        '$_baseUrl/getUserById',
        data: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var u = Users.fromJson(data);
        if (u.name != null) {
          return u;
        }
      }
      return Users();
    } catch (e) {
      return Users();
    }
  }
}
