import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Represents a failure that can occur during an operation.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => <Object?>[message, cause];
}

/// Failure that happens when interacting with remote services.
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    this.statusCode,
    super.cause,
    super.stackTrace,
  });

  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[message, cause, statusCode];
}

/// Failure that originates from local cache or persistent storage access.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.cause, super.stackTrace});
}

/// Failure used when the underlying error cannot be categorised.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.cause,
    super.stackTrace,
  });
}

const _defaultFailureMessage = 'Something went wrong. Please try again.';

/// Convert known exceptions into strongly typed [Failure] instances.
Failure mapExceptionToFailure(Object error, [StackTrace? stackTrace]) {
  if (error is Failure) return error;

  if (error is DioException) {
    final responseMessage = _extractDioMessage(error);
    return ServerFailure(
      message: responseMessage ?? _defaultFailureMessage,
      statusCode: error.response?.statusCode,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is SocketException) {
    return ServerFailure(
      message: 'No internet connection. Please check your network and try again.',
      cause: error,
      stackTrace: stackTrace,
    );
  }

  if (error is String) {
    return UnexpectedFailure(
      message: error,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  // Return user-friendly message for unexpected errors
  return UnexpectedFailure(
    message: 'Something went wrong. Please try again.',
    cause: error,
    stackTrace: stackTrace,
  );
}

String? _extractDioMessage(DioException exception) {
  final data = exception.response?.data;

  if (data is Map && data['message'] != null) {
    return data['message'].toString();
  }
  if (data is Map && data['errors'] != null) {
    final errors = data['errors'];
    if (errors is List && errors.isNotEmpty) {
      return errors.first.toString();
    }
    return errors.toString();
  }

  // Return user-friendly messages based on error type
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'Connection timeout. Please check your internet and try again.';

    case DioExceptionType.badResponse:
      final statusCode = exception.response?.statusCode;
      switch (statusCode) {
        case 400:
          return 'Invalid request. Please try again.';
        case 401:
          return 'Unauthorized. Please login again.';
        case 403:
          return 'Access forbidden.';
        case 404:
          return 'Data not found. Please try again.';
        case 500:
        case 502:
        case 503:
          return 'Server is having issues. Please try again later.';
        case 504:
          return 'Server timeout. Please try again.';
        default:
          return 'Something went wrong. Please try again.';
      }

    case DioExceptionType.cancel:
      return 'Request cancelled.';

    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network and try again.';

    case DioExceptionType.badCertificate:
      return 'Security error. Please try again later.';

    case DioExceptionType.unknown:
      if (exception.error is SocketException) {
        return 'No internet connection. Please check your network and try again.';
      }
      return 'Connection failed. Please check your internet and try again.';
  }
}
