import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/features/quran_detail/presentation/cubit/quran_detail_cubit.dart';
import 'package:read_quran/features/quran_detail/presentation/widgets/audio_controls_widget.dart';
import 'package:read_quran/features/quran_detail/presentation/widgets/ayah_card.dart';

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

class _QuranDetailPageState extends State<QuranDetailPage> {
  final Map<int, GlobalKey> _itemKeys = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranDetailCubit>().loadSurahDetail(
        surahNumber: widget.surahNumber,
        reciterIdentifier: widget.reciterIdentifier,
      );
    });
  }

  GlobalKey _keyForIndex(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  void _scrollToIndex(int index) {
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
