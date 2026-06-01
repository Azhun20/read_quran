import 'package:flutter/foundation.dart';

/// Application-wide logger for debugging and error tracking.
class AppLogger {
  AppLogger._();

  /// Log debug information (only in debug mode)
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('🐛 DEBUG: $logTag$message');
    }
  }

  /// Log general information
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('ℹ️ INFO: $logTag$message');
    }
  }

  /// Log warnings
  static void warning(String message, [String? tag]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('⚠️ WARNING: $logTag$message');
    }
  }

  /// Log errors with optional error object and stack trace
  static void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  ]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('❌ ERROR: $logTag$message');
      if (error != null) {
        debugPrint('  Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('  Stack trace:\n$stackTrace');
      }
    }
  }

  /// Log network requests
  static void network(String message, [String? tag]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('🌐 NETWORK: $logTag$message');
    }
  }

  /// Log authentication events
  static void auth(String message, [String? tag]) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      debugPrint('🔐 AUTH: $logTag$message');
    }
  }
}
