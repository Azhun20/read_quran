import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/utils/services/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiService.dio.post(
      ApiConstant.login,
      data: {'email': email, 'password': password},
    );

    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> logout() async {
    await apiService.dio.post(ApiConstant.logout);
  }
}
