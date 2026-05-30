// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SurahDetailModel _$SurahDetailModelFromJson(Map<String, dynamic> json) {
  return _SurahDetailModel.fromJson(json);
}

/// @nodoc
mixin _$SurahDetailModel {
  @JsonKey(name: 'number')
  int? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishName')
  String? get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishNameTranslation')
  String? get englishNameTranslation => throw _privateConstructorUsedError;
  @JsonKey(name: 'revelationType')
  String? get revelationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'numberOfAyahs')
  int? get numberOfAyahs => throw _privateConstructorUsedError;
  @JsonKey(name: 'ayahs')
  List<AyahModel>? get ayahs => throw _privateConstructorUsedError;
  @JsonKey(name: 'edition')
  EditionModel? get edition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SurahDetailModelCopyWith<SurahDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurahDetailModelCopyWith<$Res> {
  factory $SurahDetailModelCopyWith(
          SurahDetailModel value, $Res Function(SurahDetailModel) then) =
      _$SurahDetailModelCopyWithImpl<$Res, SurahDetailModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
      @JsonKey(name: 'revelationType') String? revelationType,
      @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
      @JsonKey(name: 'ayahs') List<AyahModel>? ayahs,
      @JsonKey(name: 'edition') EditionModel? edition});

  $EditionModelCopyWith<$Res>? get edition;
}

/// @nodoc
class _$SurahDetailModelCopyWithImpl<$Res, $Val extends SurahDetailModel>
    implements $SurahDetailModelCopyWith<$Res> {
  _$SurahDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? englishNameTranslation = freezed,
    Object? revelationType = freezed,
    Object? numberOfAyahs = freezed,
    Object? ayahs = freezed,
    Object? edition = freezed,
  }) {
    return _then(_value.copyWith(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      englishName: freezed == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String?,
      englishNameTranslation: freezed == englishNameTranslation
          ? _value.englishNameTranslation
          : englishNameTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      revelationType: freezed == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfAyahs: freezed == numberOfAyahs
          ? _value.numberOfAyahs
          : numberOfAyahs // ignore: cast_nullable_to_non_nullable
              as int?,
      ayahs: freezed == ayahs
          ? _value.ayahs
          : ayahs // ignore: cast_nullable_to_non_nullable
              as List<AyahModel>?,
      edition: freezed == edition
          ? _value.edition
          : edition // ignore: cast_nullable_to_non_nullable
              as EditionModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EditionModelCopyWith<$Res>? get edition {
    if (_value.edition == null) {
      return null;
    }

    return $EditionModelCopyWith<$Res>(_value.edition!, (value) {
      return _then(_value.copyWith(edition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SurahDetailModelImplCopyWith<$Res>
    implements $SurahDetailModelCopyWith<$Res> {
  factory _$$SurahDetailModelImplCopyWith(_$SurahDetailModelImpl value,
          $Res Function(_$SurahDetailModelImpl) then) =
      __$$SurahDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
      @JsonKey(name: 'revelationType') String? revelationType,
      @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
      @JsonKey(name: 'ayahs') List<AyahModel>? ayahs,
      @JsonKey(name: 'edition') EditionModel? edition});

  @override
  $EditionModelCopyWith<$Res>? get edition;
}

/// @nodoc
class __$$SurahDetailModelImplCopyWithImpl<$Res>
    extends _$SurahDetailModelCopyWithImpl<$Res, _$SurahDetailModelImpl>
    implements _$$SurahDetailModelImplCopyWith<$Res> {
  __$$SurahDetailModelImplCopyWithImpl(_$SurahDetailModelImpl _value,
      $Res Function(_$SurahDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? englishNameTranslation = freezed,
    Object? revelationType = freezed,
    Object? numberOfAyahs = freezed,
    Object? ayahs = freezed,
    Object? edition = freezed,
  }) {
    return _then(_$SurahDetailModelImpl(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      englishName: freezed == englishName
          ? _value.englishName
          : englishName // ignore: cast_nullable_to_non_nullable
              as String?,
      englishNameTranslation: freezed == englishNameTranslation
          ? _value.englishNameTranslation
          : englishNameTranslation // ignore: cast_nullable_to_non_nullable
              as String?,
      revelationType: freezed == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfAyahs: freezed == numberOfAyahs
          ? _value.numberOfAyahs
          : numberOfAyahs // ignore: cast_nullable_to_non_nullable
              as int?,
      ayahs: freezed == ayahs
          ? _value._ayahs
          : ayahs // ignore: cast_nullable_to_non_nullable
              as List<AyahModel>?,
      edition: freezed == edition
          ? _value.edition
          : edition // ignore: cast_nullable_to_non_nullable
              as EditionModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurahDetailModelImpl extends _SurahDetailModel {
  const _$SurahDetailModelImpl(
      {@JsonKey(name: 'number') this.number,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'englishName') this.englishName,
      @JsonKey(name: 'englishNameTranslation') this.englishNameTranslation,
      @JsonKey(name: 'revelationType') this.revelationType,
      @JsonKey(name: 'numberOfAyahs') this.numberOfAyahs,
      @JsonKey(name: 'ayahs') final List<AyahModel>? ayahs,
      @JsonKey(name: 'edition') this.edition})
      : _ayahs = ayahs,
        super._();

  factory _$SurahDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurahDetailModelImplFromJson(json);

  @override
  @JsonKey(name: 'number')
  final int? number;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'englishName')
  final String? englishName;
  @override
  @JsonKey(name: 'englishNameTranslation')
  final String? englishNameTranslation;
  @override
  @JsonKey(name: 'revelationType')
  final String? revelationType;
  @override
  @JsonKey(name: 'numberOfAyahs')
  final int? numberOfAyahs;
  final List<AyahModel>? _ayahs;
  @override
  @JsonKey(name: 'ayahs')
  List<AyahModel>? get ayahs {
    final value = _ayahs;
    if (value == null) return null;
    if (_ayahs is EqualUnmodifiableListView) return _ayahs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'edition')
  final EditionModel? edition;

  @override
  String toString() {
    return 'SurahDetailModel(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, revelationType: $revelationType, numberOfAyahs: $numberOfAyahs, ayahs: $ayahs, edition: $edition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurahDetailModelImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.englishNameTranslation, englishNameTranslation) ||
                other.englishNameTranslation == englishNameTranslation) &&
            (identical(other.revelationType, revelationType) ||
                other.revelationType == revelationType) &&
            (identical(other.numberOfAyahs, numberOfAyahs) ||
                other.numberOfAyahs == numberOfAyahs) &&
            const DeepCollectionEquality().equals(other._ayahs, _ayahs) &&
            (identical(other.edition, edition) || other.edition == edition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      number,
      name,
      englishName,
      englishNameTranslation,
      revelationType,
      numberOfAyahs,
      const DeepCollectionEquality().hash(_ayahs),
      edition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SurahDetailModelImplCopyWith<_$SurahDetailModelImpl> get copyWith =>
      __$$SurahDetailModelImplCopyWithImpl<_$SurahDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurahDetailModelImplToJson(
      this,
    );
  }
}

abstract class _SurahDetailModel extends SurahDetailModel {
  const factory _SurahDetailModel(
          {@JsonKey(name: 'number') final int? number,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'englishName') final String? englishName,
          @JsonKey(name: 'englishNameTranslation')
          final String? englishNameTranslation,
          @JsonKey(name: 'revelationType') final String? revelationType,
          @JsonKey(name: 'numberOfAyahs') final int? numberOfAyahs,
          @JsonKey(name: 'ayahs') final List<AyahModel>? ayahs,
          @JsonKey(name: 'edition') final EditionModel? edition}) =
      _$SurahDetailModelImpl;
  const _SurahDetailModel._() : super._();

  factory _SurahDetailModel.fromJson(Map<String, dynamic> json) =
      _$SurahDetailModelImpl.fromJson;

  @override
  @JsonKey(name: 'number')
  int? get number;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'englishName')
  String? get englishName;
  @override
  @JsonKey(name: 'englishNameTranslation')
  String? get englishNameTranslation;
  @override
  @JsonKey(name: 'revelationType')
  String? get revelationType;
  @override
  @JsonKey(name: 'numberOfAyahs')
  int? get numberOfAyahs;
  @override
  @JsonKey(name: 'ayahs')
  List<AyahModel>? get ayahs;
  @override
  @JsonKey(name: 'edition')
  EditionModel? get edition;
  @override
  @JsonKey(ignore: true)
  _$$SurahDetailModelImplCopyWith<_$SurahDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EditionModel _$EditionModelFromJson(Map<String, dynamic> json) {
  return _EditionModel.fromJson(json);
}

/// @nodoc
mixin _$EditionModel {
  @JsonKey(name: 'identifier')
  String? get identifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'language')
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishName')
  String? get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'format')
  String? get format => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditionModelCopyWith<EditionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditionModelCopyWith<$Res> {
  factory $EditionModelCopyWith(
          EditionModel value, $Res Function(EditionModel) then) =
      _$EditionModelCopyWithImpl<$Res, EditionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier') String? identifier,
      @JsonKey(name: 'language') String? language,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'format') String? format,
      @JsonKey(name: 'type') String? type});
}

/// @nodoc
class _$EditionModelCopyWithImpl<$Res, $Val extends EditionModel>
    implements $EditionModelCopyWith<$Res> {
  _$EditionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
    Object? language = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? format = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditionModelImplCopyWith<$Res>
    implements $EditionModelCopyWith<$Res> {
  factory _$$EditionModelImplCopyWith(
          _$EditionModelImpl value, $Res Function(_$EditionModelImpl) then) =
      __$$EditionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'identifier') String? identifier,
      @JsonKey(name: 'language') String? language,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'format') String? format,
      @JsonKey(name: 'type') String? type});
}

/// @nodoc
class __$$EditionModelImplCopyWithImpl<$Res>
    extends _$EditionModelCopyWithImpl<$Res, _$EditionModelImpl>
    implements _$$EditionModelImplCopyWith<$Res> {
  __$$EditionModelImplCopyWithImpl(
      _$EditionModelImpl _value, $Res Function(_$EditionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = freezed,
    Object? language = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? format = freezed,
    Object? type = freezed,
  }) {
    return _then(_$EditionModelImpl(
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditionModelImpl implements _EditionModel {
  const _$EditionModelImpl(
      {@JsonKey(name: 'identifier') this.identifier,
      @JsonKey(name: 'language') this.language,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'englishName') this.englishName,
      @JsonKey(name: 'format') this.format,
      @JsonKey(name: 'type') this.type});

  factory _$EditionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditionModelImplFromJson(json);

  @override
  @JsonKey(name: 'identifier')
  final String? identifier;
  @override
  @JsonKey(name: 'language')
  final String? language;
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
  String toString() {
    return 'EditionModel(identifier: $identifier, language: $language, name: $name, englishName: $englishName, format: $format, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditionModelImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, identifier, language, name, englishName, format, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditionModelImplCopyWith<_$EditionModelImpl> get copyWith =>
      __$$EditionModelImplCopyWithImpl<_$EditionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditionModelImplToJson(
      this,
    );
  }
}

abstract class _EditionModel implements EditionModel {
  const factory _EditionModel(
      {@JsonKey(name: 'identifier') final String? identifier,
      @JsonKey(name: 'language') final String? language,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'englishName') final String? englishName,
      @JsonKey(name: 'format') final String? format,
      @JsonKey(name: 'type') final String? type}) = _$EditionModelImpl;

  factory _EditionModel.fromJson(Map<String, dynamic> json) =
      _$EditionModelImpl.fromJson;

  @override
  @JsonKey(name: 'identifier')
  String? get identifier;
  @override
  @JsonKey(name: 'language')
  String? get language;
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
  @JsonKey(ignore: true)
  _$$EditionModelImplCopyWith<_$EditionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
