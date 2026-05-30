import 'package:dio/dio.dart';
import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/core/logging/app_logger.dart';

/// Abstract class for QuranDetail remote data source
abstract class QuranDetailRemoteDataSource {
  Future<Map<String, dynamic>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  });
}

/// Implementation of QuranDetail remote data source
class QuranDetailRemoteDataSourceImpl
    implements QuranDetailRemoteDataSource {
  QuranDetailRemoteDataSourceImpl();

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
  Future<Map<String, dynamic>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    try {
      final endpoint = ApiConstant.getSurah
          .replaceAll('{surah}', surahNumber.toString())
          .replaceAll('{edition}', reciterIdentifier);

      AppLogger.network('GET $endpoint');

      final response = await _dio.get(endpoint);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        return response.data['data'] as Map<String, dynamic>;
      }

      throw Exception('Failed to get surah detail');
    } on DioException catch (e) {
      AppLogger.error('Failed to get surah detail', e.message);
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error getting surah detail', e, stackTrace);
      rethrow;
    }
  }
}
