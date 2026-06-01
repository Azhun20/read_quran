import 'package:flutter/material.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/shared/services/connectivity_service.dart';

/// Banner widget that shows network connectivity status
class NetworkStatusBanner extends StatefulWidget {
  const NetworkStatusBanner({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<NetworkStatusBanner> createState() => _NetworkStatusBannerState();
}

class _NetworkStatusBannerState extends State<NetworkStatusBanner> {
  final ConnectivityService _connectivityService = sl<ConnectivityService>();
  bool _isOnline = true;
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    _connectivityService.connectionStatusStream.listen((isConnected) {
      if (mounted) {
        setState(() {
          _isOnline = isConnected;
          // Show banner immediately when offline
          // Hide banner after 2 seconds when back online
          if (!isConnected) {
            _showBanner = true;
          } else if (_showBanner) {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted && _isOnline) {
                setState(() {
                  _showBanner = false;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showBanner ? 40 : 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _showBanner ? 1.0 : 0.0,
            child: Container(
              width: double.infinity,
              color: _isOnline
                  ? context.colorScheme.primary
                  : context.colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isOnline ? Icons.wifi : Icons.wifi_off,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isOnline
                        ? 'Back online'
                        : 'No internet connection',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
