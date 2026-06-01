import 'package:dio/dio.dart';
import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/utils/services/api_service.dart';

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

  // Use global Dio instance from ApiService
  Dio get _dio => sl<ApiService>().dio;

  @override
  Future<Map<String, dynamic>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    try {
      // Fetch both audio and translation editions
      final editions = '$reciterIdentifier,${ApiConstant.translationIndonesian}';
      final endpoint = ApiConstant.getSurahMultiEditions
          .replaceAll('{surah}', surahNumber.toString())
          .replaceAll('{editions}', editions);

      AppLogger.network('GET $endpoint');

      final response = await _dio.get(endpoint);

      if (response.data['status'] == 'OK' && response.data['data'] != null) {
        final data = response.data['data'] as List<dynamic>;

        // Data is an array with two elements: [audioEdition, translationEdition]
        if (data.length >= 2) {
          final audioData = data[0] as Map<String, dynamic>;
          final translationData = data[1] as Map<String, dynamic>;

          // Merge audio ayahs with translation
          final audioAyahs = audioData['ayahs'] as List<dynamic>;
          final translationAyahs = translationData['ayahs'] as List<dynamic>;

          // Add translation to each ayah
          for (int i = 0; i < audioAyahs.length && i < translationAyahs.length; i++) {
            audioAyahs[i]['translation'] = translationAyahs[i]['text'];
          }

          return audioData;
        }

        // Fallback to audio only if translation not available
        return data[0] as Map<String, dynamic>;
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
