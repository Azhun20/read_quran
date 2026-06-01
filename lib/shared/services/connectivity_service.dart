import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:read_quran/core/logging/app_logger.dart';

/// Service to monitor network connectivity status
class ConnectivityService {
  ConnectivityService() {
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Stream of connection status (true = connected, false = disconnected)
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  /// Current connection status
  bool get isConnected => _isConnected;

  void _init() {
    // Check initial connectivity
    _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        _updateConnectionStatus(results);
      },
    );
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to check connectivity', e, stackTrace);
      _isConnected = true; // Assume connected on error
      _connectionStatusController.add(_isConnected);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final wasConnected = _isConnected;

    // Consider connected if any result is not 'none'
    _isConnected = results.any((result) => result != ConnectivityResult.none);

    // Log connectivity changes
    if (wasConnected != _isConnected) {
      if (_isConnected) {
        AppLogger.info('Network connection restored');
      } else {
        AppLogger.warning('Network connection lost');
      }
    }

    _connectionStatusController.add(_isConnected);
  }

  /// Manually check current connectivity status
  Future<bool> checkConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.any((result) => result != ConnectivityResult.none);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to check connection', e, stackTrace);
      return true; // Assume connected on error
    }
  }

  /// Dispose the service
  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _connectionStatusController.close();
    AppLogger.info('ConnectivityService disposed');
  }
}
