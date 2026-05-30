import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/features/quran_detail/data/models/ayah_model.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';
import 'package:read_quran/features/quran_list/data/models/surah_model.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

part 'surah_detail_model.freezed.dart';
part 'surah_detail_model.g.dart';

@freezed
class SurahDetailModel with _$SurahDetailModel {
  const SurahDetailModel._();

  const factory SurahDetailModel({
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'englishName') String? englishName,
    @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
    @JsonKey(name: 'revelationType') String? revelationType,
    @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
    @JsonKey(name: 'ayahs') List<AyahModel>? ayahs,
    @JsonKey(name: 'edition') EditionModel? edition,
  }) = _SurahDetailModel;

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SurahDetailModelFromJson(json);

  /// Convert model to entity
  SurahDetailEntity toEntity() {
    // Convert surah info
    final surahEntity = SurahModel(
      number: number,
      name: name,
      englishName: englishName,
      englishNameTranslation: englishNameTranslation,
      revelationType: revelationType,
      numberOfAyahs: numberOfAyahs,
    ).toEntity();

    // Convert ayahs
    List<AyahEntity>? ayahEntities;
    if (ayahs != null) {
      ayahEntities = ayahs!
          .map((ayah) => ayah.toEntity(
                surahNumber: number ?? 0,
                surahName: name ?? '',
              ))
          .toList();
    }

    return SurahDetailEntity(
      surah: surahEntity,
      ayahs: ayahEntities,
      edition: edition?.identifier,
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
