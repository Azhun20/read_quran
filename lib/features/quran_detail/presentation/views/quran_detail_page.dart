import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/quran_detail_cubit.dart';

class QuranDetailPage extends StatelessWidget {
  const QuranDetailPage({super.key});

  static const String routeName = 'quran_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranDetail'),
      ),
      body: BlocBuilder<QuranDetailCubit, QuranDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Value: ${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<QuranDetailCubit>().increment(),
                  child: const Text('Increment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
