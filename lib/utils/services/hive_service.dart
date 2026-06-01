import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_quran/constants/hive_constant.dart';
import 'package:read_quran/core/logging/app_logger.dart';

/// Service for managing local storage using Hive
class HiveService {
  Box? _authBox;
  Box? _settingsBox;
  Box? _cacheBox;

  /// Initialize Hive and open boxes
  Future<void> initHive() async {
    try {
      await Hive.initFlutter();
      _authBox = await Hive.openBox(HiveConstant.authBox);
      _settingsBox = await Hive.openBox(HiveConstant.settingsBox);
      _cacheBox = await Hive.openBox(HiveConstant.cacheBox);
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

  // Cache methods

  /// Get cached data from cache box
  T? getCached<T>(String key) {
    try {
      return _cacheBox?.get(key) as T?;
    } catch (e) {
      AppLogger.error('Failed to get cached key: $key', e);
      return null;
    }
  }

  /// Save data to cache box
  Future<void> putCached(String key, dynamic value) async {
    try {
      await _cacheBox?.put(key, value);
    } catch (e) {
      AppLogger.error('Failed to cache key: $key', e);
    }
  }

  /// Delete cached data
  Future<void> deleteCached(String key) async {
    try {
      await _cacheBox?.delete(key);
    } catch (e) {
      AppLogger.error('Failed to delete cached key: $key', e);
    }
  }

  /// Check if cached data is expired (default: 24 hours)
  bool isCacheExpired(String timestampKey, {Duration maxAge = const Duration(hours: 24)}) {
    try {
      final timestamp = getCached<int>(timestampKey);
      if (timestamp == null) return true;

      final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      return now.difference(cacheDate) > maxAge;
    } catch (e) {
      AppLogger.error('Failed to check cache expiration', e);
      return true;
    }
  }

  /// Save surah list to cache
  Future<void> cacheSurahList(List<Map<String, dynamic>> surahList) async {
    await putCached(HiveConstant.surahListKey, surahList);
    await putCached(HiveConstant.surahListTimestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Get cached surah list
  List<Map<String, dynamic>>? getCachedSurahList() {
    if (isCacheExpired(HiveConstant.surahListTimestampKey)) {
      return null;
    }
    final cached = getCached<List<dynamic>>(HiveConstant.surahListKey);
    return cached?.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  /// Save reciters to cache
  Future<void> cacheReciters(List<Map<String, dynamic>> reciters) async {
    await putCached(HiveConstant.recitersKey, reciters);
    await putCached(HiveConstant.recitersTimestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Get cached reciters
  List<Map<String, dynamic>>? getCachedReciters() {
    if (isCacheExpired(HiveConstant.recitersTimestampKey)) {
      return null;
    }
    final cached = getCached<List<dynamic>>(HiveConstant.recitersKey);
    return cached?.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  /// Clear all cache
  Future<void> clearCache() async {
    try {
      await _cacheBox?.clear();
      AppLogger.info('Cache cleared');
    } catch (e) {
      AppLogger.error('Failed to clear cache', e);
    }
  }

  // Playback state methods

  /// Save playback state
  Future<void> savePlaybackState(Map<String, dynamic> state) async {
    try {
      await putCached(HiveConstant.playbackStateKey, state);
      AppLogger.info('Saved playback state');
    } catch (e) {
      AppLogger.error('Failed to save playback state', e);
    }
  }

  /// Get saved playback state
  Map<String, dynamic>? getPlaybackState() {
    try {
      final state = getCached<Map<dynamic, dynamic>>(HiveConstant.playbackStateKey);
      if (state == null) return null;

      // Convert dynamic map to String keys
      return Map<String, dynamic>.from(state);
    } catch (e) {
      AppLogger.error('Failed to get playback state', e);
      return null;
    }
  }

  /// Clear playback state
  Future<void> clearPlaybackState() async {
    try {
      await deleteCached(HiveConstant.playbackStateKey);
      AppLogger.info('Cleared playback state');
    } catch (e) {
      AppLogger.error('Failed to clear playback state', e);
    }
  }
}
