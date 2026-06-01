import 'dart:async';

import 'package:dio/dio.dart';
import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/shared/services/connectivity_service.dart';
import 'package:read_quran/utils/services/api_service.dart';
import 'package:read_quran/utils/services/hive_service.dart';

/// Abstract class for QuranList remote data source
abstract class QuranListRemoteDataSource {
  Future<List<Map<String, dynamic>>> getSurahList();
  Future<List<Map<String, dynamic>>> getAvailableReciters();
}

/// Implementation of QuranList remote data source
class QuranListRemoteDataSourceImpl implements QuranListRemoteDataSource {
  QuranListRemoteDataSourceImpl();

  final HiveService _hiveService = sl<HiveService>();
  final ConnectivityService _connectivityService = sl<ConnectivityService>();

  // Use global Dio instance from ApiService
  Dio get _dio => sl<ApiService>().dio;

  @override
  Future<List<Map<String, dynamic>>> getSurahList() async {
    try {
      // Try to get cached data first
      final cachedData = _hiveService.getCachedSurahList();
      if (cachedData != null) {
        AppLogger.info('Loaded surah list from cache');

        // If online, refresh cache in background
        if (_connectivityService.isConnected) {
          unawaited(_refreshSurahListCache());
        }

        return cachedData;
      }

      // No cache or expired, fetch from API
      AppLogger.network('GET ${ApiConstant.getSurahList}');
      final response = await _dio.get(ApiConstant.getSurahList);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        final surahList = data.map((e) => e as Map<String, dynamic>).toList();

        // Cache the data
        await _hiveService.cacheSurahList(surahList);
        AppLogger.info('Cached surah list');

        return surahList;
      }

      throw Exception('Failed to get surah list');
    } on DioException catch (e) {
      AppLogger.error('Failed to get surah list', e.message);

      // Try to return cached data even if expired
      final cachedData = _hiveService.getCached<List<dynamic>>('surah_list');
      if (cachedData != null) {
        AppLogger.info('Returning expired cache due to network error');
        return cachedData
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error getting surah list', e, stackTrace);
      rethrow;
    }
  }

  /// Refresh cache in background without blocking
  Future<void> _refreshSurahListCache() async {
    try {
      final response = await _dio.get(ApiConstant.getSurahList);
      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        final surahList = data.map((e) => e as Map<String, dynamic>).toList();
        await _hiveService.cacheSurahList(surahList);
        AppLogger.info('Refreshed surah list cache in background');
      }
    } catch (e) {
      AppLogger.warning('Failed to refresh cache in background: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAvailableReciters() async {
    try {
      // Try to get cached data first
      final cachedData = _hiveService.getCachedReciters();
      if (cachedData != null) {
        AppLogger.info('Loaded reciters from cache');

        // If online, refresh cache in background
        if (_connectivityService.isConnected) {
          _refreshRecitersCache();
        }

        return cachedData;
      }

      // No cache or expired, fetch from API
      AppLogger.network('GET ${ApiConstant.getAudioEditions}');
      final response = await _dio.get(ApiConstant.getAudioEditions);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;

        // Filter only Arabic reciters with audio format
        final arabicReciters = data
            .where(
              (reciter) =>
                  reciter['language'] == 'ar' &&
                  reciter['format'] == 'audio' &&
                  reciter['type'] == 'versebyverse',
            )
            .map((e) => e as Map<String, dynamic>)
            .toList();

        // Cache the data
        await _hiveService.cacheReciters(arabicReciters);
        AppLogger.info('Cached reciters');

        return arabicReciters;
      }

      throw Exception('Failed to get available reciters');
    } on DioException catch (e) {
      AppLogger.error('Failed to get available reciters', e.message);

      // Try to return cached data even if expired
      final cachedData = _hiveService.getCached<List<dynamic>>('reciters');
      if (cachedData != null) {
        AppLogger.info('Returning expired reciters cache due to network error');
        return cachedData
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error getting reciters', e, stackTrace);
      rethrow;
    }
  }

  /// Refresh reciters cache in background without blocking
  Future<void> _refreshRecitersCache() async {
    try {
      final response = await _dio.get(ApiConstant.getAudioEditions);
      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        final arabicReciters = data
            .where(
              (reciter) =>
                  reciter['language'] == 'ar' &&
                  reciter['format'] == 'audio' &&
                  reciter['type'] == 'versebyverse',
            )
            .map((e) => e as Map<String, dynamic>)
            .toList();
        await _hiveService.cacheReciters(arabicReciters);
        AppLogger.info('Refreshed reciters cache in background');
      }
    } catch (e) {
      AppLogger.warning('Failed to refresh reciters cache in background: $e');
    }
  }
}
