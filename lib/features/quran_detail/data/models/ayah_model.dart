import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

part 'ayah_model.freezed.dart';
part 'ayah_model.g.dart';

@freezed
class AyahModel with _$AyahModel {
  const AyahModel._();

  const factory AyahModel({
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'audio') String? audio,
    @JsonKey(name: 'audioSecondary') List<String>? audioSecondary,
    @JsonKey(name: 'numberInSurah') int? numberInSurah,
    @JsonKey(name: 'juz') int? juz,
    @JsonKey(name: 'manzil') int? manzil,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'ruku') int? ruku,
    @JsonKey(name: 'hizbQuarter') int? hizbQuarter,
    @JsonKey(name: 'sajda') dynamic sajda,
  }) = _AyahModel;

  factory AyahModel.fromJson(Map<String, dynamic> json) =>
      _$AyahModelFromJson(json);

  /// Convert model to entity
  AyahEntity toEntity({required int surahNumber, required String surahName}) {
    return AyahEntity(
      number: number,
      text: text,
      audioUrl: audio ?? '',
      numberInSurah: numberInSurah,
      juz: juz,
      page: page,
      surahNumber: surahNumber,
      surahName: surahName,
      sajda: sajda is bool ? sajda as bool : false,
    );
  }
}
