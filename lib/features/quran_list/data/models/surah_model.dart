import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

part 'surah_model.freezed.dart';
part 'surah_model.g.dart';

@freezed
class SurahModel with _$SurahModel {
  const SurahModel._();

  const factory SurahModel({
    @JsonKey(name: 'number') int? number,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'englishName') String? englishName,
    @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
    @JsonKey(name: 'revelationType') String? revelationType,
    @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
  }) = _SurahModel;

  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);

  /// Convert model to entity
  SurahEntity toEntity() {
    return SurahEntity(
      number: number,
      name: name,
      englishName: englishName,
      englishNameTranslation: englishNameTranslation,
      revelationType: revelationType,
      numberOfAyahs: numberOfAyahs,
    );
  }

  /// Create model from entity
  factory SurahModel.fromEntity(SurahEntity entity) {
    return SurahModel(
      number: entity.number,
      name: entity.name,
      englishName: entity.englishName,
      englishNameTranslation: entity.englishNameTranslation,
      revelationType: entity.revelationType,
      numberOfAyahs: entity.numberOfAyahs,
    );
  }
}