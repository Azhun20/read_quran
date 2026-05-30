// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultModelImpl _$$SearchResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchResultModelImpl(
      count: (json['count'] as num?)?.toInt(),
      matches: (json['matches'] as List<dynamic>?)
          ?.map((e) => SearchMatchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchResultModelImplToJson(
        _$SearchResultModelImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'matches': instance.matches,
    };

_$SearchMatchModelImpl _$$SearchMatchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchMatchModelImpl(
      number: (json['number'] as num?)?.toInt(),
      text: json['text'] as String?,
      edition: json['edition'] == null
          ? null
          : EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
      surah: json['surah'] == null
          ? null
          : SurahInfoModel.fromJson(json['surah'] as Map<String, dynamic>),
      numberInSurah: (json['numberInSurah'] as num?)?.toInt(),
      juz: (json['juz'] as num?)?.toInt(),
      manzil: (json['manzil'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      ruku: (json['ruku'] as num?)?.toInt(),
      hizbQuarter: (json['hizbQuarter'] as num?)?.toInt(),
      sajda: json['sajda'] as bool?,
    );

Map<String, dynamic> _$$SearchMatchModelImplToJson(
        _$SearchMatchModelImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'text': instance.text,
      'edition': instance.edition,
      'surah': instance.surah,
      'numberInSurah': instance.numberInSurah,
      'juz': instance.juz,
      'manzil': instance.manzil,
      'page': instance.page,
      'ruku': instance.ruku,
      'hizbQuarter': instance.hizbQuarter,
      'sajda': instance.sajda,
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

_$SurahInfoModelImpl _$$SurahInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$SurahInfoModelImpl(
      number: (json['number'] as num?)?.toInt(),
      name: json['name'] as String?,
      englishName: json['englishName'] as String?,
      englishNameTranslation: json['englishNameTranslation'] as String?,
      numberOfAyahs: (json['numberOfAyahs'] as num?)?.toInt(),
      revelationType: json['revelationType'] as String?,
    );

Map<String, dynamic> _$$SurahInfoModelImplToJson(
        _$SurahInfoModelImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'englishName': instance.englishName,
      'englishNameTranslation': instance.englishNameTranslation,
      'numberOfAyahs': instance.numberOfAyahs,
      'revelationType': instance.revelationType,
    };
