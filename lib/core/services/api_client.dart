import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://devapi.propsoft.ai/api/',
    contentType: 'application/json',
  ));

  static void setAuthHeader() {
    final token = GetStorage().read('token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
