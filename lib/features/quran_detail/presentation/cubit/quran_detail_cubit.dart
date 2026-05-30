import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/usecases/get_quran_detail_list_usecase.dart';

part 'quran_detail_state.dart';
part 'quran_detail_cubit.freezed.dart';

class QuranDetailCubit extends Cubit<QuranDetailState> {
  QuranDetailCubit(this._getQuranDetailListUseCase)
      : super(const QuranDetailState());

  final GetQuranDetailListUseCase _getQuranDetailListUseCase;

  void increment() {
    emit(state.copyWith(value: state.value + 1));
  }
}
