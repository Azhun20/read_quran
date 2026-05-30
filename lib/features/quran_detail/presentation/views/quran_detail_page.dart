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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: BlocBuilder<QuranDetailCubit, QuranDetailState>(
        builder: (context, state) {
          return Column(
            children: [
              // Header
              SafeArea(
                bottom: false,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.surah?.englishName ?? 'Loading...',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state.surah != null)
                              Text(
                                '${state.surah!.englishNameTranslation} • ${state.surah!.numberOfAyahs} Ayahs',
                                style: context.textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                      Text(
                        state.surah?.name ?? '',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Rajdhani',
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
          );
        },
      ),
      bottomNavigationBar: const AudioControlsWidget(),
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
