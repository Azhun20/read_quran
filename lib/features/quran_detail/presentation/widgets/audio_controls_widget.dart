import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/features/quran_detail/presentation/cubit/quran_detail_cubit.dart';

class AudioControlsWidget extends StatelessWidget {
  const AudioControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranDetailCubit, QuranDetailState>(
      builder: (context, state) {
        if (state.ayahs.isEmpty) return const SizedBox.shrink();

        final cubit = context.read<QuranDetailCubit>();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Currently playing ayah info
                if (state.currentAyahIndex < state.ayahs.length)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Ayah ${state.ayahs[state.currentAyahIndex].numberInSurah}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                // Progress bar
                ProgressBar(
                  progress: state.currentPosition ?? Duration.zero,
                  total: state.totalDuration ?? const Duration(seconds: 1),
                  buffered: state.totalDuration,
                  onSeek: (duration) {
                    cubit.seek(duration);
                  },
                  barHeight: 3,
                  thumbRadius: 6,
                  timeLabelLocation: TimeLabelLocation.sides,
                  timeLabelTextStyle: context.textTheme.bodySmall,
                ),

                const SizedBox(height: 16),

                // Control buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Speed control
                    PopupMenuButton<double>(
                      icon: Row(
                        children: [
                          const Icon(Icons.speed, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${state.playbackSpeed}x',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      onSelected: (speed) {
                        cubit.setPlaybackSpeed(speed);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 0.5, child: Text('0.5x')),
                        const PopupMenuItem(value: 0.75, child: Text('0.75x')),
                        const PopupMenuItem(value: 1.0, child: Text('1.0x')),
                        const PopupMenuItem(value: 1.25, child: Text('1.25x')),
                        const PopupMenuItem(value: 1.5, child: Text('1.5x')),
                        const PopupMenuItem(value: 2.0, child: Text('2.0x')),
                      ],
                    ),

                    // Previous
                    IconButton(
                      onPressed: state.currentAyahIndex > 0
                          ? () => cubit.playPrevious()
                          : null,
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 36,
                    ),

                    // Play/Pause
                    Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => cubit.togglePlayPause(),
                        icon: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        iconSize: 36,
                      ),
                    ),

                    // Next
                    IconButton(
                      onPressed: state.currentAyahIndex < state.ayahs.length - 1
                          ? () => cubit.playNext()
                          : null,
                      icon: const Icon(Icons.skip_next),
                      iconSize: 36,
                    ),

                    // Stop
                    IconButton(
                      onPressed: () => cubit.stop(),
                      icon: const Icon(Icons.stop),
                      iconSize: 28,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
