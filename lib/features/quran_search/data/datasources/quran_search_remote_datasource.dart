import 'package:dio/dio.dart';
import 'package:read_quran/constants/api_constant.dart';
import 'package:read_quran/core/logging/app_logger.dart';

abstract class QuranSearchRemoteDataSource {
  Future<Map<String, dynamic>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  });
}

class QuranSearchRemoteDataSourceImpl implements QuranSearchRemoteDataSource {
  QuranSearchRemoteDataSourceImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.alquranBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  late final Dio _dio;

  @override
  Future<Map<String, dynamic>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    try {
      final surah = surahNumber?.toString() ?? 'all';
      final editionParam = edition ?? 'quran-simple'; // Default edition for search

      // URL encode the keyword for Arabic characters
      final encodedKeyword = Uri.encodeComponent(keyword);

      final endpoint = ApiConstant.searchQuran
          .replaceAll('{keyword}', encodedKeyword)
          .replaceAll('{surah}', surah)
          .replaceAll('{edition}', editionParam);

      AppLogger.info('Searching Quran: $endpoint (keyword: $keyword)', 'QuranSearchRemoteDataSource');

      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        AppLogger.info(
          'Search successful: ${response.data['data']['count']} results',
          'QuranSearchRemoteDataSource',
        );
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to search Quran: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.error(
        'Error searching Quran: $e',
        e,
        null,
        'QuranSearchRemoteDataSource',
      );
      rethrow;
    }
  }
}
