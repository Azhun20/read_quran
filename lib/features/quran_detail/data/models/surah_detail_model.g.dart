// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SurahDetailModelImpl _$$SurahDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SurahDetailModelImpl(
      number: (json['number'] as num?)?.toInt(),
      name: json['name'] as String?,
      englishName: json['englishName'] as String?,
      englishNameTranslation: json['englishNameTranslation'] as String?,
      revelationType: json['revelationType'] as String?,
      numberOfAyahs: (json['numberOfAyahs'] as num?)?.toInt(),
      ayahs: (json['ayahs'] as List<dynamic>?)
          ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      edition: json['edition'] == null
          ? null
          : EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SurahDetailModelImplToJson(
        _$SurahDetailModelImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'englishName': instance.englishName,
      'englishNameTranslation': instance.englishNameTranslation,
      'revelationType': instance.revelationType,
      'numberOfAyahs': instance.numberOfAyahs,
      'ayahs': instance.ayahs,
      'edition': instance.edition,
    };

_$EditionModelImpl _$$EditionModelImplFromJson(Map<String, dynamic> json) =>
    _$EditionModelImpl(
      identifier: json['identifier'] as String?,
      language: json['language'] as String?,
      name: json['name'] as String?,
      englishName: json['englishName'] as String?,
      format: json['format'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$EditionModelImplToJson(_$EditionModelImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'language': instance.language,
      'name': instance.name,
      'englishName': instance.englishName,
      'format': instance.format,
      'type': instance.type,
    };
