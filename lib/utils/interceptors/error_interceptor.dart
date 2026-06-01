import 'dart:io';

import 'package:dio/dio.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/shared/services/connectivity_service.dart';

/// Interceptor for handling API errors and retries
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({
    required ConnectivityService connectivityService,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  }) : _connectivityService = connectivityService;

  final ConnectivityService _connectivityService;
  final int maxRetries;
  final Duration retryDelay;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check connectivity before making request
    final isConnected = await _connectivityService.checkConnection();
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection. Please check your network.',
        ),
      );
    }

    return handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Get user-friendly error message
    final errorMessage = _getErrorMessage(err);
    AppLogger.error('API Error', errorMessage);

    // Check if we should retry
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    final shouldRetry = _shouldRetry(err) && retryCount < maxRetries;

    if (shouldRetry) {
      // Increment retry count
      err.requestOptions.extra['retryCount'] = retryCount + 1;

      // Calculate exponential backoff delay
      final delay = retryDelay * (retryCount + 1);
      AppLogger.info('Retrying request (attempt ${retryCount + 1}/$maxRetries) after ${delay.inSeconds}s');

      // Wait before retrying
      await Future.delayed(delay);

      // Check connectivity before retrying
      final isConnected = await _connectivityService.checkConnection();
      if (!isConnected) {
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            type: DioExceptionType.connectionError,
            message: 'No internet connection. Please check your network.',
          ),
        );
      }

      // Retry the request
      try {
        final response = await Dio().fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    // Return modified error with user-friendly message
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        response: err.response,
        message: errorMessage,
        error: err.error,
      ),
    );
  }

  /// Check if the request should be retried
  bool _shouldRetry(DioException err) {
    // Don't retry on 4xx client errors (except 408 timeout)
    if (err.response != null) {
      final statusCode = err.response!.statusCode ?? 0;
      if (statusCode >= 400 && statusCode < 500 && statusCode != 408) {
        return false;
      }
    }

    // Retry on network errors, timeouts, and 5xx server errors
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode ?? 0) >= 500;
  }

  /// Get user-friendly error message
  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection and try again.';

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Invalid request. Please try again.';
          case 401:
            return 'Unauthorized. Please login again.';
          case 403:
            return 'Access forbidden.';
          case 404:
            return 'Resource not found.';
          case 408:
            return 'Request timeout. Please try again.';
          case 500:
            return 'Server error. Please try again later.';
          case 502:
          case 503:
            return 'Service temporarily unavailable. Please try again later.';
          case 504:
            return 'Gateway timeout. Please try again.';
          default:
            return 'Something went wrong. Please try again.';
        }

      case DioExceptionType.cancel:
        return 'Request cancelled.';

      case DioExceptionType.connectionError:
        if (err.error is SocketException) {
          return 'No internet connection. Please check your network.';
        }
        return 'Connection failed. Please check your internet connection.';

      case DioExceptionType.badCertificate:
        return 'Security error. Please try again later.';

      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          return 'No internet connection. Please check your network.';
        }
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
