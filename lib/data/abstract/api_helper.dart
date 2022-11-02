import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();

  static Dio? _instance;
  static const String _baseURL = 'https://technichal.prominaagency.com/api/';

  ///A singleton object from the [Dio] object to handle the requests
  static Dio get instance {
    if (_instance == null) {
      _instance = Dio();
      _instance!.options.baseUrl = _baseURL;
    }
    return _instance!;
  }

  static void setToken(String token) {
    instance.options.headers.addAll({"Authorization": "Bearer $token"});
  }

  static void deleteToken() {
    instance.options.headers.remove("Authorization");
  }
}
