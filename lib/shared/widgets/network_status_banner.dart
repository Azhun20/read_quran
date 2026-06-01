import 'package:flutter/material.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/shared/services/connectivity_service.dart';

/// A wrapper widget that displays an animated banner showing network connectivity status.
///
/// This widget listens to network connectivity changes and displays a banner at the
/// top of the screen to inform users about their connection status. The banner appears
/// immediately when connection is lost and dismisses automatically after being restored.
///
/// **Features**:
/// - **Real-time Monitoring**: Listens to [ConnectivityService] for status changes
/// - **Smooth Animations**: Animated appearance/disappearance with 300ms transitions
/// - **Visual Feedback**: Different colors and icons for online/offline states
/// - **Auto-Dismiss**: "Back online" banner dismisses after 2 seconds
/// - **Non-intrusive**: Banner overlays at top without disrupting content
///
/// **Behavior**:
/// 1. **Going Offline**:
///    - Banner appears immediately
///    - Red/error color background
///    - "No internet connection" message
///    - WiFi-off icon
///    - Remains visible until connection restored
///
/// 2. **Coming Online**:
///    - Banner changes to primary color
///    - "Back online" message
///    - WiFi icon
///    - Auto-dismisses after 2 seconds
///
/// **Visual States**:
/// - **Offline**: Red background, wifi_off icon, persistent display
/// - **Online**: Primary color background, wifi icon, 2-second display
/// - **Hidden**: No visual space taken when not shown
///
/// **Usage**:
/// Wrap your app's main scaffold or navigation root with this widget to enable
/// network status monitoring throughout the app.
///
/// ```dart
/// MaterialApp(
///   home: NetworkStatusBanner(
///     child: Scaffold(
///       appBar: AppBar(title: Text('Read Quran')),
///       body: QuranListPage(),
///     ),
///   ),
/// )
/// ```
///
/// **Technical Details**:
/// - Uses StreamBuilder pattern via ConnectivityService
/// - Handles mounted state checks to prevent memory leaks
/// - AnimatedContainer for smooth height transitions
/// - AnimatedOpacity for fade in/out effects
///
/// **Dependencies**:
/// - [ConnectivityService]: Monitors network connectivity changes
/// - Service locator (sl) for dependency injection
class NetworkStatusBanner extends StatefulWidget {
  const NetworkStatusBanner({
    super.key,
    required this.child,
  });

  /// The child widget that this banner wraps.
  ///
  /// Typically the main scaffold or screen content. The banner will appear
  /// above this child when connectivity changes occur.
  final Widget child;

  @override
  State<NetworkStatusBanner> createState() => _NetworkStatusBannerState();
}

/// State class for [NetworkStatusBanner].
///
/// Manages the connectivity stream subscription and banner visibility logic.
class _NetworkStatusBannerState extends State<NetworkStatusBanner> {
  /// Connectivity service for monitoring network status.
  final ConnectivityService _connectivityService = sl<ConnectivityService>();

  /// Current network connectivity state.
  ///
  /// True when device has internet connection, false otherwise.
  bool _isOnline = true;

  /// Whether to show the status banner.
  ///
  /// Controls banner visibility. Set to true when offline, and remains true
  /// for 2 seconds after coming back online before dismissing.
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    _listenToConnectivity();
  }

  /// Sets up a listener for network connectivity changes.
  ///
  /// This method subscribes to the [ConnectivityService] stream and updates
  /// the widget state based on connectivity changes. It implements the following logic:
  ///
  /// **When connection is lost**:
  /// - Sets _isOnline to false
  /// - Shows banner immediately (_showBanner = true)
  /// - Banner remains visible until connection restored
  ///
  /// **When connection is restored**:
  /// - Sets _isOnline to true
  /// - Keeps banner visible for 2 seconds to confirm restoration
  /// - Schedules automatic dismissal after 2 seconds
  /// - Checks mounted state before dismissing to prevent memory leaks
  ///
  /// **Safety checks**:
  /// - Always checks `mounted` before calling setState
  /// - Prevents updates after widget disposal
  /// - Avoids memory leaks from delayed callbacks
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
