import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_state_model.freezed.dart';
part 'playback_state_model.g.dart';

@freezed
class PlaybackStateModel with _$PlaybackStateModel {
  const factory PlaybackStateModel({
    required int surahNumber,
    required String surahName,
    required int currentAyahIndex,
    required int totalAyahs,
    required String reciterIdentifier,
    required bool wasPlaying,
    required int positionInMilliseconds,
    required int savedAtTimestamp,
  }) = _PlaybackStateModel;

  factory PlaybackStateModel.fromJson(Map<String, dynamic> json) =>
      _$PlaybackStateModelFromJson(json);
}
