import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

part 'search_result_model.freezed.dart';
part 'search_result_model.g.dart';

@freezed
class SearchResultModel with _$SearchResultModel {
  const SearchResultModel._();

  const factory SearchResultModel({
    @JsonKey(name: 'count') int? count,
    @JsonKey(name: 'matches') List<SearchMatchModel>? matches,
  }) = _SearchResultModel;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  List<AyahEntity> toEntities() {
    return matches?.map((match) => match.toEntity()).toList() ?? [];
  }
}

@freezed
class SearchMatchModel with _$SearchMatchModel {
  const SearchMatchModel._();

  const factory SearchMatchModel({
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'edition') EditionModel? edition,
    @JsonKey(name: 'surah') SurahInfoModel? surah,
    @JsonKey(name: 'numberInSurah') int? numberInSurah,
    @JsonKey(name: 'juz') int? juz,
    @JsonKey(name: 'manzil') int? manzil,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'ruku') int? ruku,
    @JsonKey(name: 'hizbQuarter') int? hizbQuarter,
    @JsonKey(name: 'sajda') bool? sajda,
  }) = _SearchMatchModel;

  factory SearchMatchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchMatchModelFromJson(json);

  AyahEntity toEntity() {
    return AyahEntity(
      number: number,
      text: text,
      // audioUrl omitted (null) - Search API doesn't return audio
      numberInSurah: numberInSurah,
      juz: juz,
      page: page,
      surahNumber: surah?.number,
      surahName: surah?.name,
      surahEnglishName: surah?.englishName,
      ruku: ruku,
      manzil: manzil,
      hizbQuarter: hizbQuarter,
      sajda: sajda,
    );
  }
}

@freezed
class EditionModel with _$EditionModel {
  const factory EditionModel({
    @JsonKey(name: 'identifier') String? identifier,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'englishName') String? englishName,
    @JsonKey(name: 'format') String? format,
    @JsonKey(name: 'type') String? type,
  }) = _EditionModel;

  factory EditionModel.fromJson(Map<String, dynamic> json) =>
      _$EditionModelFromJson(json);
}

@freezed
class SurahInfoModel with _$SurahInfoModel {
  const factory SurahInfoModel({
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'englishName') String? englishName,
    @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
    @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
    @JsonKey(name: 'revelationType') String? revelationType,
  }) = _SurahInfoModel;

  factory SurahInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SurahInfoModelFromJson(json);
}
