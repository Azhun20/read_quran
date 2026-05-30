// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AyahModelImpl _$$AyahModelImplFromJson(Map<String, dynamic> json) =>
    _$AyahModelImpl(
      number: (json['number'] as num?)?.toInt(),
      text: json['text'] as String?,
      audio: json['audio'] as String?,
      audioSecondary: (json['audioSecondary'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      numberInSurah: (json['numberInSurah'] as num?)?.toInt(),
      juz: (json['juz'] as num?)?.toInt(),
      manzil: (json['manzil'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      ruku: (json['ruku'] as num?)?.toInt(),
      hizbQuarter: (json['hizbQuarter'] as num?)?.toInt(),
      sajda: json['sajda'],
    );

Map<String, dynamic> _$$AyahModelImplToJson(_$AyahModelImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'text': instance.text,
      'audio': instance.audio,
      'audioSecondary': instance.audioSecondary,
      'numberInSurah': instance.numberInSurah,
      'juz': instance.juz,
      'manzil': instance.manzil,
      'page': instance.page,
      'ruku': instance.ruku,
      'hizbQuarter': instance.hizbQuarter,
      'sajda': instance.sajda,
    };
