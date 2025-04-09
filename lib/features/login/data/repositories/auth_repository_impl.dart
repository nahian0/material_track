import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/services/api_client.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _box = GetStorage();

  @override
  Future<bool> login(String email, String password) async {
    try {
      final response = await ApiClient.dio.post(
        'interview/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final status = response.data['status_code'];
      final token = response.data['access_token'];

      if (status == '1' && token != null) {
        _box.write('token', token);
        ApiClient.setAuthHeader();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
}
