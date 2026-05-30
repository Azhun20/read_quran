import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_quran/configs/routes/route.dart';
import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:read_quran/features/auth/presentation/views/login_page.dart';
import 'package:read_quran/features/quran_list/presentation/cubit/quran_list_cubit.dart';
import 'package:read_quran/features/quran_list/presentation/views/quran_list_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation:
        Route.quranList, // Changed to start with quranList for testing
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
      // TODO: Add quran_detail route
      // TODO: Add quran_search route
    ],
  );
}
