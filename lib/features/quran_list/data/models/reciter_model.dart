import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';

part 'reciter_model.freezed.dart';
part 'reciter_model.g.dart';

@freezed
class ReciterModel with _$ReciterModel {
  const ReciterModel._();

  const factory ReciterModel({
    @JsonKey(name: 'identifier') String? identifier,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'englishName') String? englishName,
    @JsonKey(name: 'format') String? format,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'bitrate') String? bitrate,
  }) = _ReciterModel;

  factory ReciterModel.fromJson(Map<String, dynamic> json) =>
      _$ReciterModelFromJson(json);

  /// Convert model to entity
  ReciterEntity toEntity() {
    return ReciterEntity(
      identifier: identifier,
      name: name,
      englishName: englishName,
      format: format,
      type: type,
      bitrate: bitrate?.toString(),
    );
  }

  /// Create model from entity
  factory ReciterModel.fromEntity(ReciterEntity entity) {
    return ReciterModel(
      identifier: entity.identifier,
      name: entity.name,
      englishName: entity.englishName,
      format: entity.format,
      type: entity.type,
      bitrate: entity.bitrate,
    );
  }
}