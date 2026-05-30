// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReciterModelImpl _$$ReciterModelImplFromJson(Map<String, dynamic> json) =>
    _$ReciterModelImpl(
      identifier: json['identifier'] as String?,
      name: json['name'] as String?,
      englishName: json['englishName'] as String?,
      format: json['format'] as String?,
      type: json['type'] as String?,
      bitrate: json['bitrate'] as String?,
    );

Map<String, dynamic> _$$ReciterModelImplToJson(_$ReciterModelImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'name': instance.name,
      'englishName': instance.englishName,
      'format': instance.format,
      'type': instance.type,
      'bitrate': instance.bitrate,
    };
