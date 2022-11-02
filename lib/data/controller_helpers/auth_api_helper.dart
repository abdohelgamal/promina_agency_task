import 'package:dio/dio.dart';
import 'package:task/data/abstract/api_helper.dart';

class AuthApiHelper {
  AuthApiHelper._();
  static Dio? _instance;
  static Dio get instance {
    _instance ??= ApiHelper.instance;
    return _instance!;
  }

  static Future<Response> login(String email, String password) async {
    try {
      return await instance
          .post('auth/login', data: {'email': email, 'password': password});
    } on DioError catch (exception) {
      return exception.response!;
    }
  }
}
