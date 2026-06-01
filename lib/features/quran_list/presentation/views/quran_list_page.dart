import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_quran/configs/routes/route.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/features/quran_list/presentation/cubit/quran_list_cubit.dart';
import 'package:read_quran/features/quran_list/presentation/widgets/search_bar_widget.dart';
import 'package:read_quran/features/quran_list/presentation/widgets/surah_card.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';
import 'package:shimmer/shimmer.dart';

class QuranListPage extends StatefulWidget {
  const QuranListPage({super.key});

  static const String routeName = 'quran_list';

  @override
  State<QuranListPage> createState() => _QuranListPageState();
}

class _QuranListPageState extends State<QuranListPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranListCubit>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and reciter selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Read Quran',
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'All 114 Surahs',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push(Route.quranSearch);
                        },
                        icon: Icon(
                          Icons.search,
                          color: context.colorScheme.primary,
                        ),
                        tooltip: 'Search verses',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search bar for filtering surahs
                  SearchBarWidget(
                    onChanged: (query) {
                      context.read<QuranListCubit>().searchSurahs(query);
                    },
                  ),
                ],
              ),
            ),

            // Surah List
            Expanded(
              child: BlocBuilder<QuranListCubit, QuranListState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return _buildShimmerLoading();
                  }

                  if (state.errorMessage != null) {
                    return _buildErrorWidget(state.errorMessage!);
                  }

                  if (state.filteredSurahs.isEmpty) {
                    return _buildEmptyWidget();
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<QuranListCubit>().loadSurahList();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredSurahs.length,
                      itemBuilder: (context, index) {
                        final surah = state.filteredSurahs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SurahCard(
                            surah: surah,
                            onTap: () => _navigateToDetail(surah),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(SurahEntity surah) {
    // Navigate to detail page with selected surah and reciter
    final state = context.read<QuranListCubit>().state;
    context.push(
      '${Route.quranDetail}/${surah.number}',
      extra: {'surah': surah, 'reciter': state.selectedReciter},
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
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
            Text('Failed to load Surahs', style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<QuranListCubit>().loadSurahList();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: context.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text('No Surahs Found', style: context.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Try searching with a different keyword',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
