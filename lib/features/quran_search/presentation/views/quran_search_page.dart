import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_quran/configs/routes/route.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/features/quran_search/presentation/cubit/quran_search_cubit.dart';
import 'package:read_quran/features/quran_search/presentation/widgets/search_result_card.dart';
import 'package:shimmer/shimmer.dart';

class QuranSearchPage extends StatefulWidget {
  const QuranSearchPage({super.key});

  static const String routeName = 'quran_search';

  @override
  State<QuranSearchPage> createState() => _QuranSearchPageState();
}

class _QuranSearchPageState extends State<QuranSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Quran'),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              context.read<QuranSearchCubit>().clearSearch();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search verses by keyword...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: context.colorScheme.surface,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<QuranSearchCubit>().searchQuran(keyword: value);
                }
              },
            ),
          ),

          // Results section
          Expanded(
            child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
              builder: (context, state) {
                // Loading state
                if (state.isLoading) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
                }

                // Error state
                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: context.colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.errorMessage!,
                          style: context.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (state.searchKeyword.isNotEmpty) {
                              context.read<QuranSearchCubit>().searchQuran(
                                    keyword: state.searchKeyword,
                                  );
                            }
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Empty search state
                if (state.searchKeyword.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          size: 64,
                          color: context.colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for Quran verses',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter keywords to find verses',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurface.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // No results state
                if (state.searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: context.colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try different keywords',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurface.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Results list
                return Column(
                  children: [
                    // Result count header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            '${state.resultCount} ${state.resultCount == 1 ? 'result' : 'results'}',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Results list
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final ayah = state.searchResults[index];
                          return SearchResultCard(
                            ayah: ayah,
                            searchKeyword: state.searchKeyword,
                            onTap: () {
                              // Navigate to detail page
                              if (ayah.surahNumber != null) {
                                context.pushNamed(
                                  Route.quranDetail,
                                  pathParameters: {
                                    'surahNumber': ayah.surahNumber.toString(),
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
