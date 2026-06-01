import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_quran/configs/routes/route.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:read_quran/features/auth/presentation/views/login_page.dart';
import 'package:read_quran/features/quran_detail/presentation/cubit/quran_detail_cubit.dart';
import 'package:read_quran/features/quran_detail/presentation/views/quran_detail_page.dart';
import 'package:read_quran/features/quran_list/presentation/cubit/quran_list_cubit.dart';
import 'package:read_quran/features/quran_list/presentation/views/quran_list_page.dart';
import 'package:read_quran/features/quran_search/presentation/cubit/quran_search_cubit.dart';
import 'package:read_quran/features/quran_search/presentation/views/quran_search_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Route.quranList, // Default page: Quran list
    routes: [
      GoRoute(
        path: Route.login,
        name: Route.login,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider.value(
            value: sl<AuthCubit>(),
            child: const LoginPage(),
          ),
        ),
      ),
      GoRoute(
        path: Route.quranList,
        name: Route.quranList,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (context) => sl<QuranListCubit>(),
            child: const QuranListPage(),
          ),
        ),
      ),
      GoRoute(
        path: '${Route.quranDetail}/:surahNumber',
        name: Route.quranDetail,
        pageBuilder: (context, state) {
          final surahNumber =
              int.tryParse(state.pathParameters['surahNumber'] ?? '1') ?? 1;
          final extra = state.extra as Map<String, dynamic>?;
          final reciterIdentifier =
              extra?['reciter']?.identifier ?? 'ar.alafasy';

          return MaterialPage(
            child: BlocProvider(
              create: (context) => sl<QuranDetailCubit>(),
              child: QuranDetailPage(
                surahNumber: surahNumber,
                reciterIdentifier: reciterIdentifier,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: Route.quranSearch,
        name: Route.quranSearch,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (context) => sl<QuranSearchCubit>(),
            child: const QuranSearchPage(),
          ),
        ),
      ),
    ],
  );
}
