import 'package:dio/dio.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/shared/services/connectivity_service.dart';
import 'package:read_quran/utils/interceptors/error_interceptor.dart';
import 'package:read_quran/utils/services/hive_service.dart';

/// Service for making API requests with automatic token handling
class ApiService {
  late final Dio _dio;
  final HiveService _hiveService;
  Function? _unauthorizedHandler;

  ApiService(this._hiveService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.alquran.cloud/v1',
        ),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add error handling interceptor with retry logic
    _dio.interceptors.add(
      ErrorInterceptor(connectivityService: sl<ConnectivityService>()),
    );

    // Add auth interceptor
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
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  void attachUnauthorizedHandler(Function handler) {
    _unauthorizedHandler = handler;
  }
}
