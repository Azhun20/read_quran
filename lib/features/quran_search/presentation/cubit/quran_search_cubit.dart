import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/usecases/get_quran_search_list_usecase.dart';

part 'quran_search_state.dart';
part 'quran_search_cubit.freezed.dart';

class QuranSearchCubit extends Cubit<QuranSearchState> {
  QuranSearchCubit(this._getQuranSearchListUseCase)
      : super(const QuranSearchState());

  final GetQuranSearchListUseCase _getQuranSearchListUseCase;

  void increment() {
    emit(state.copyWith(value: state.value + 1));
  }
}
