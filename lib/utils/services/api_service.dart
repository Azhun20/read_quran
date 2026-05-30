import 'package:dio/dio.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/utils/services/hive_service.dart';

/// Service for making API requests with automatic token handling
class ApiService {
  late final Dio _dio;
  final HiveService _hiveService;
  Function? _unauthorizedHandler;
  Function? _refreshTokenCallback;

  ApiService(this._hiveService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.example.com/v1',
        ),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to request
          final token = _hiveService.token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          AppLogger.network('${options.method} ${options.path}');
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle unauthorized
            _unauthorizedHandler?.call();
          }
          AppLogger.error(
            'API Error: ${error.response?.statusCode}',
            error.message,
          );
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  void attachUnauthorizedHandler(Function handler) {
    _unauthorizedHandler = handler;
  }

  void refreshToken(Function callback) {
    _refreshTokenCallback = callback;
  }
}
