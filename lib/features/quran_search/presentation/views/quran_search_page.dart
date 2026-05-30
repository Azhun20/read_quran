import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/quran_search_cubit.dart';

class QuranSearchPage extends StatelessWidget {
  const QuranSearchPage({super.key});

  static const String routeName = 'quran_search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranSearch'),
      ),
      body: BlocBuilder<QuranSearchCubit, QuranSearchState>(
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
                  onPressed: () => context.read<QuranSearchCubit>().increment(),
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
