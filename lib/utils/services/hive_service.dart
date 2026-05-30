import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_quran/constants/hive_constant.dart';
import 'package:read_quran/core/logging/app_logger.dart';

/// Service for managing local storage using Hive
class HiveService {
  Box? _authBox;
  Box? _settingsBox;

  /// Initialize Hive and open boxes
  Future<void> initHive() async {
    try {
      await Hive.initFlutter();
      _authBox = await Hive.openBox(HiveConstant.authBox);
      _settingsBox = await Hive.openBox(HiveConstant.settingsBox);
      AppLogger.info('Hive initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize Hive', e, stackTrace);
      rethrow;
    }
  }

  /// Get a value from auth box
  T? get<T>(String key) {
    try {
      return _authBox?.get(key) as T?;
    } catch (e) {
      AppLogger.error('Failed to get key: $key', e);
      return null;
    }
  }

  /// Save a value to auth box
  Future<void> put(String key, dynamic value) async {
    try {
      await _authBox?.put(key, value);
    } catch (e) {
      AppLogger.error('Failed to put key: $key', e);
    }
  }

  /// Delete a value from auth box
  Future<void> delete(String key) async {
    try {
      await _authBox?.delete(key);
    } catch (e) {
      AppLogger.error('Failed to delete key: $key', e);
    }
  }

  /// Clear all data from auth box
  Future<void> clearAuth() async {
    try {
      await _authBox?.clear();
      AppLogger.info('Auth box cleared');
    } catch (e) {
      AppLogger.error('Failed to clear auth box', e);
    }
  }

  /// Get token
  String? get token => get<String>(HiveConstant.tokenKey);

  /// Save token
  Future<void> saveToken(String token) => put(HiveConstant.tokenKey, token);

  /// Get refresh token
  String? get refreshToken => get<String>(HiveConstant.refreshTokenKey);

  /// Save refresh token
  Future<void> saveRefreshToken(String refreshToken) =>
      put(HiveConstant.refreshTokenKey, refreshToken);

  /// Delete tokens
  Future<void> deleteTokens() async {
    await delete(HiveConstant.tokenKey);
    await delete(HiveConstant.refreshTokenKey);
  }
}
