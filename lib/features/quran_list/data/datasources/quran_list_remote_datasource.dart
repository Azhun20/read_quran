import 'package:dio/dio.dart';
import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/core/logging/app_logger.dart';

/// Abstract class for QuranList remote data source
abstract class QuranListRemoteDataSource {
  Future<List<Map<String, dynamic>>> getSurahList();
  Future<List<Map<String, dynamic>>> getAvailableReciters();
}

/// Implementation of QuranList remote data source
class QuranListRemoteDataSourceImpl implements QuranListRemoteDataSource {
  QuranListRemoteDataSourceImpl();

  // Create a separate Dio instance for AlQuran API
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstant.alquranBaseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  @override
  Future<List<Map<String, dynamic>>> getSurahList() async {
    try {
      AppLogger.network('GET ${ApiConstant.getSurahList}');

      final response = await _dio.get(ApiConstant.getSurahList);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data.map((e) => e as Map<String, dynamic>).toList();
      }

      throw Exception('Failed to get surah list');
    } on DioException catch (e) {
      AppLogger.error('Failed to get surah list', e.message);
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error getting surah list', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAvailableReciters() async {
    try {
      AppLogger.network('GET ${ApiConstant.getAudioEditions}');

      final response = await _dio.get(ApiConstant.getAudioEditions);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;

        // Filter only Arabic reciters with audio format
        final arabicReciters = data
            .where((reciter) =>
                reciter['language'] == 'ar' &&
                reciter['format'] == 'audio' &&
                reciter['type'] == 'versebyverse')
            .map((e) => e as Map<String, dynamic>)
            .toList();

        return arabicReciters;
      }

      throw Exception('Failed to get available reciters');
    } on DioException catch (e) {
      AppLogger.error('Failed to get available reciters', e.message);
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error getting reciters', e, stackTrace);
      rethrow;
    }
  }
}
