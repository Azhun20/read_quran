import 'package:read_quran/constants/hive_constant.dart';
import 'package:read_quran/utils/services/hive_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(Map<String, dynamic> user);
  Future<void> saveTokens(String token, String refreshToken);
  Map<String, dynamic>? getUser();
  String? getToken();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    await hiveService.put(HiveConstant.userKey, user);
  }

  @override
  Future<void> saveTokens(String token, String refreshToken) async {
    await hiveService.saveToken(token);
    await hiveService.saveRefreshToken(refreshToken);
  }

  @override
  Map<String, dynamic>? getUser() {
    return hiveService.get<Map<String, dynamic>>(HiveConstant.userKey);
  }

  @override
  String? getToken() {
    return hiveService.token;
  }

  @override
  Future<void> clearAuth() async {
    await hiveService.clearAuth();
  }
}
