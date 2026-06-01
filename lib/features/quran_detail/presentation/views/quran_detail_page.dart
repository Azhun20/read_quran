import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/features/quran_detail/data/models/playback_state_model.dart';
import 'package:read_quran/features/quran_detail/presentation/cubit/quran_detail_cubit.dart';
import 'package:read_quran/features/quran_detail/presentation/widgets/audio_controls_widget.dart';
import 'package:read_quran/features/quran_detail/presentation/widgets/ayah_card.dart';
import 'package:read_quran/utils/services/hive_service.dart';

class QuranDetailPage extends StatefulWidget {
  const QuranDetailPage({
    super.key,
    required this.surahNumber,
    required this.reciterIdentifier,
  });

  final int surahNumber;
  final String reciterIdentifier;

  static const String routeName = 'quran_detail';

  @override
  State<QuranDetailPage> createState() => _QuranDetailPageState();
}

class _QuranDetailPageState extends State<QuranDetailPage>
    with WidgetsBindingObserver {
  final Map<int, GlobalKey> _itemKeys = {};
  final ScrollController _scrollController = ScrollController();
  final HiveService _hiveService = sl<HiveService>();
  bool _hasShownRestorePrompt = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranDetailCubit>().loadSurahDetail(
        surahNumber: widget.surahNumber,
        reciterIdentifier: widget.reciterIdentifier,
      );
      _checkForSavedState();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App is back in foreground
        _onAppResumed();
      case AppLifecycleState.paused:
        // App is in background
        _onAppPaused();
      case AppLifecycleState.inactive:
        // App is temporarily inactive (e.g., phone call, system dialog)
        // Don't save state here, wait for paused
      case AppLifecycleState.detached:
        // App is closing
        _onAppPaused();
      case AppLifecycleState.hidden:
        // App is hidden (rarely used)
    }
  }

  /// Save playback state when app goes to background
  void _onAppPaused() {
    final cubitState = context.read<QuranDetailCubit>().state;

    // Only save if we have a loaded surah
    if (cubitState.surah == null || cubitState.ayahs.isEmpty) return;

    final playbackState = PlaybackStateModel(
      surahNumber: widget.surahNumber,
      surahName: cubitState.surah!.name ?? '',
      currentAyahIndex: cubitState.currentAyahIndex,
      totalAyahs: cubitState.ayahs.length,
      reciterIdentifier: widget.reciterIdentifier,
      wasPlaying: cubitState.isPlaying,
      positionInMilliseconds: cubitState.currentPosition?.inMilliseconds ?? 0,
      savedAtTimestamp: DateTime.now().millisecondsSinceEpoch,
    );

    _hiveService.savePlaybackState(playbackState.toJson());
  }

  /// Restore or sync state when app comes to foreground
  void _onAppResumed() {
    // Just sync UI with current audio player state
    // The audio should still be playing/paused as it was
  }

  /// Check for saved playback state and prompt user to restore
  void _checkForSavedState() {
    if (_hasShownRestorePrompt) return;

    final savedStateJson = _hiveService.getPlaybackState();
    if (savedStateJson == null) return;

    try {
      final savedState = PlaybackStateModel.fromJson(savedStateJson);

      // Check if saved state is for current surah
      if (savedState.surahNumber != widget.surahNumber) return;

      // Check if state is not too old (e.g., saved within last 24 hours)
      final savedTime = DateTime.fromMillisecondsSinceEpoch(savedState.savedAtTimestamp);
      final hoursSinceSaved = DateTime.now().difference(savedTime).inHours;

      if (hoursSinceSaved > 24) {
        _hiveService.clearPlaybackState();
        return;
      }

      _hasShownRestorePrompt = true;

      // Show snackbar to restore playback
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Resume from Ayah ${savedState.currentAyahIndex + 1}?',
              ),
              action: SnackBarAction(
                label: 'Resume',
                onPressed: () => _restorePlaybackState(savedState),
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      });
    } catch (e) {
      // If there's an error parsing saved state, clear it
      _hiveService.clearPlaybackState();
    }
  }

  /// Restore playback state from saved data
  void _restorePlaybackState(PlaybackStateModel savedState) {
    // Wait for surah to be loaded
    final cubitState = context.read<QuranDetailCubit>().state;
    if (cubitState.ayahs.isEmpty) {
      // Wait a bit and try again
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _restorePlaybackState(savedState);
      });
      return;
    }

    // Navigate to the saved ayah
    context.read<QuranDetailCubit>().playAyahAt(savedState.currentAyahIndex);

    // If was playing, start playing; otherwise just load the ayah
    if (!savedState.wasPlaying) {
      context.read<QuranDetailCubit>().pause();
    }

    // Clear the saved state after restoring
    _hiveService.clearPlaybackState();

    // Show confirmation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Resumed from Ayah ${savedState.currentAyahIndex + 1}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  GlobalKey _keyForIndex(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  void _scrollToIndex(int index) {
    // For index 0 (first ayah), scroll to top using controller
    if (index == 0) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      return;
    }

    // For other indices, try to use ensureVisible
    final key = _itemKeys[index];
    final ctx = key?.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      alignment: 0.5, // 0.5 = center of viewport
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuranDetailCubit, QuranDetailState>(
      listenWhen: (previous, current) =>
          previous.currentAyahIndex != current.currentAyahIndex,
      listener: (context, state) {
        // Scroll when playing OR when resetting to ayah 1 (index 0)
        if (state.isPlaying || state.currentAyahIndex == 0) {
          _scrollToIndex(state.currentAyahIndex);
        }
      },
      child: BlocBuilder<QuranDetailCubit, QuranDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              centerTitle: false,

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.surah?.englishName ?? 'Loading...',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  if (state.surah != null)
                    Text(
                      '${state.surah!.englishNameTranslation} • ${state.surah!.numberOfAyahs} Ayahs',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                ],
              ),
              actions: [
                Text(
                  state.surah?.name ?? '',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Rajdhani',
                    color: context.colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            body: Column(
              children: [
                // Ayah List
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.errorMessage != null
                      ? _buildErrorWidget(state.errorMessage!)
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: state.ayahs.length,
                          itemBuilder: (context, index) {
                            final ayah = state.ayahs[index];
                            final isPlaying =
                                state.isPlaying &&
                                state.currentAyahIndex == index;

                            return AyahCard(
                              key: _keyForIndex(index),
                              ayah: ayah,
                              isPlaying: isPlaying,
                              onTap: () {
                                context.read<QuranDetailCubit>().playAyahAt(
                                  index,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
            bottomNavigationBar: const AudioControlsWidget(),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Failed to load Surah', style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<QuranDetailCubit>().loadSurahDetail(
                  surahNumber: widget.surahNumber,
                  reciterIdentifier: widget.reciterIdentifier,
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
