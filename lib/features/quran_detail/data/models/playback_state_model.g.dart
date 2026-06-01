// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaybackStateModelImpl _$$PlaybackStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlaybackStateModelImpl(
      surahNumber: (json['surahNumber'] as num).toInt(),
      surahName: json['surahName'] as String,
      currentAyahIndex: (json['currentAyahIndex'] as num).toInt(),
      totalAyahs: (json['totalAyahs'] as num).toInt(),
      reciterIdentifier: json['reciterIdentifier'] as String,
      wasPlaying: json['wasPlaying'] as bool,
      positionInMilliseconds: (json['positionInMilliseconds'] as num).toInt(),
      savedAtTimestamp: (json['savedAtTimestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$PlaybackStateModelImplToJson(
        _$PlaybackStateModelImpl instance) =>
    <String, dynamic>{
      'surahNumber': instance.surahNumber,
      'surahName': instance.surahName,
      'currentAyahIndex': instance.currentAyahIndex,
      'totalAyahs': instance.totalAyahs,
      'reciterIdentifier': instance.reciterIdentifier,
      'wasPlaying': instance.wasPlaying,
      'positionInMilliseconds': instance.positionInMilliseconds,
      'savedAtTimestamp': instance.savedAtTimestamp,
    };
