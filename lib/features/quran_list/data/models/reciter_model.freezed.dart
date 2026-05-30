// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReciterModel _$ReciterModelFromJson(Map<String, dynamic> json) {
  return _ReciterModel.fromJson(json);
}

/// @nodoc
mixin _$ReciterModel {
  @JsonKey(name: 'identifier')
  String? get identifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishName')
  String? get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'format')
  String? get format => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'bitrate')
  String? get bitrate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReciterModelCopyWith<ReciterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReciterModelCopyWith<$Res> {
  factory $ReciterModelCopyWith(
          ReciterModel value, $Res Function(ReciterModel) then) =
      _$ReciterModelCopyWithImpl<$Res, ReciterModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier') String? identifier,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'format') String? format,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'bitrate') String? bitrate});
}

/// @nodoc
class _$ReciterModelCopyWithImpl<$Res, $Val extends ReciterModel>
    implements $ReciterModelCopyWith<$Res> {
  _$ReciterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? format = freezed,
    Object? type = freezed,
    Object? bitrate = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      englishName: freezed == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReciterModelImplCopyWith<$Res>
    implements $ReciterModelCopyWith<$Res> {
  factory _$$ReciterModelImplCopyWith(
          _$ReciterModelImpl value, $Res Function(_$ReciterModelImpl) then) =
      __$$ReciterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier') String? identifier,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'format') String? format,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'bitrate') String? bitrate});
}

/// @nodoc
class __$$ReciterModelImplCopyWithImpl<$Res>
    extends _$ReciterModelCopyWithImpl<$Res, _$ReciterModelImpl>
    implements _$$ReciterModelImplCopyWith<$Res> {
  __$$ReciterModelImplCopyWithImpl(
      _$ReciterModelImpl _value, $Res Function(_$ReciterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? format = freezed,
    Object? type = freezed,
    Object? bitrate = freezed,
  }) {
    return _then(_$ReciterModelImpl(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      englishName: freezed == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      bitrate: freezed == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReciterModelImpl extends _ReciterModel {
  const _$ReciterModelImpl(
      {@JsonKey(name: 'identifier') this.identifier,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'englishName') this.englishName,
      @JsonKey(name: 'format') this.format,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'bitrate') this.bitrate})
      : super._();

  factory _$ReciterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReciterModelImplFromJson(json);

  @override
  @JsonKey(name: 'identifier')
  final String? identifier;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'englishName')
  final String? englishName;
  @override
  @JsonKey(name: 'format')
  final String? format;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'bitrate')
  final String? bitrate;

  @override
  String toString() {
    return 'ReciterModel(identifier: $identifier, name: $name, englishName: $englishName, format: $format, type: $type, bitrate: $bitrate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReciterModelImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, identifier, name, englishName, format, type, bitrate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReciterModelImplCopyWith<_$ReciterModelImpl> get copyWith =>
      __$$ReciterModelImplCopyWithImpl<_$ReciterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReciterModelImplToJson(
      this,
    );
  }
}

abstract class _ReciterModel extends ReciterModel {
  const factory _ReciterModel(
      {@JsonKey(name: 'identifier') final String? identifier,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'englishName') final String? englishName,
      @JsonKey(name: 'format') final String? format,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'bitrate') final String? bitrate}) = _$ReciterModelImpl;
  const _ReciterModel._() : super._();

  factory _ReciterModel.fromJson(Map<String, dynamic> json) =
      _$ReciterModelImpl.fromJson;

  @override
  @JsonKey(name: 'identifier')
  String? get identifier;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'englishName')
  String? get englishName;
  @override
  @JsonKey(name: 'format')
  String? get format;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'bitrate')
  String? get bitrate;
  @override
  @JsonKey(ignore: true)
  _$$ReciterModelImplCopyWith<_$ReciterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
