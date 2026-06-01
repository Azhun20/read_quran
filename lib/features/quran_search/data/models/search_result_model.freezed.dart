// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) {
  return _SearchResultModel.fromJson(json);
}

/// @nodoc
mixin _$SearchResultModel {
  @JsonKey(name: 'count')
  int? get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'matches')
  List<SearchMatchModel>? get matches => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchResultModelCopyWith<SearchResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultModelCopyWith<$Res> {
  factory $SearchResultModelCopyWith(
          SearchResultModel value, $Res Function(SearchResultModel) then) =
      _$SearchResultModelCopyWithImpl<$Res, SearchResultModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'count') int? count,
      @JsonKey(name: 'matches') List<SearchMatchModel>? matches});
}

/// @nodoc
class _$SearchResultModelCopyWithImpl<$Res, $Val extends SearchResultModel>
    implements $SearchResultModelCopyWith<$Res> {
  _$SearchResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? matches = freezed,
  }) {
    return _then(_value.copyWith(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      matches: freezed == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<SearchMatchModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchResultModelImplCopyWith<$Res>
    implements $SearchResultModelCopyWith<$Res> {
  factory _$$SearchResultModelImplCopyWith(_$SearchResultModelImpl value,
          $Res Function(_$SearchResultModelImpl) then) =
      __$$SearchResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'count') int? count,
      @JsonKey(name: 'matches') List<SearchMatchModel>? matches});
}

/// @nodoc
class __$$SearchResultModelImplCopyWithImpl<$Res>
    extends _$SearchResultModelCopyWithImpl<$Res, _$SearchResultModelImpl>
    implements _$$SearchResultModelImplCopyWith<$Res> {
  __$$SearchResultModelImplCopyWithImpl(_$SearchResultModelImpl _value,
      $Res Function(_$SearchResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? matches = freezed,
  }) {
    return _then(_$SearchResultModelImpl(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      matches: freezed == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<SearchMatchModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultModelImpl extends _SearchResultModel {
  const _$SearchResultModelImpl(
      {@JsonKey(name: 'count') this.count,
      @JsonKey(name: 'matches') final List<SearchMatchModel>? matches})
      : _matches = matches,
        super._();

  factory _$SearchResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultModelImplFromJson(json);

  @override
  @JsonKey(name: 'count')
  final int? count;
  final List<SearchMatchModel>? _matches;
  @override
  @JsonKey(name: 'matches')
  List<SearchMatchModel>? get matches {
    final value = _matches;
    if (value == null) return null;
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SearchResultModel(count: $count, matches: $matches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultModelImpl &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._matches, _matches));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, count, const DeepCollectionEquality().hash(_matches));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultModelImplCopyWith<_$SearchResultModelImpl> get copyWith =>
      __$$SearchResultModelImplCopyWithImpl<_$SearchResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultModelImplToJson(
      this,
    );
  }
}

abstract class _SearchResultModel extends SearchResultModel {
  const factory _SearchResultModel(
          {@JsonKey(name: 'count') final int? count,
          @JsonKey(name: 'matches') final List<SearchMatchModel>? matches}) =
      _$SearchResultModelImpl;
  const _SearchResultModel._() : super._();

  factory _SearchResultModel.fromJson(Map<String, dynamic> json) =
      _$SearchResultModelImpl.fromJson;

  @override
  @JsonKey(name: 'count')
  int? get count;
  @override
  @JsonKey(name: 'matches')
  List<SearchMatchModel>? get matches;
  @override
  @JsonKey(ignore: true)
  _$$SearchResultModelImplCopyWith<_$SearchResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchMatchModel _$SearchMatchModelFromJson(Map<String, dynamic> json) {
  return _SearchMatchModel.fromJson(json);
}

/// @nodoc
mixin _$SearchMatchModel {
  @JsonKey(name: 'number')
  int? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'edition')
  EditionModel? get edition => throw _privateConstructorUsedError;
  @JsonKey(name: 'surah')
  SurahInfoModel? get surah => throw _privateConstructorUsedError;
  @JsonKey(name: 'numberInSurah')
  int? get numberInSurah => throw _privateConstructorUsedError;
  @JsonKey(name: 'juz')
  int? get juz => throw _privateConstructorUsedError;
  @JsonKey(name: 'manzil')
  int? get manzil => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'ruku')
  int? get ruku => throw _privateConstructorUsedError;
  @JsonKey(name: 'hizbQuarter')
  int? get hizbQuarter => throw _privateConstructorUsedError;
  @JsonKey(name: 'sajda')
  bool? get sajda => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchMatchModelCopyWith<SearchMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchMatchModelCopyWith<$Res> {
  factory $SearchMatchModelCopyWith(
          SearchMatchModel value, $Res Function(SearchMatchModel) then) =
      _$SearchMatchModelCopyWithImpl<$Res, SearchMatchModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'edition') EditionModel? edition,
      @JsonKey(name: 'surah') SurahInfoModel? surah,
      @JsonKey(name: 'numberInSurah') int? numberInSurah,
      @JsonKey(name: 'juz') int? juz,
      @JsonKey(name: 'manzil') int? manzil,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'ruku') int? ruku,
      @JsonKey(name: 'hizbQuarter') int? hizbQuarter,
      @JsonKey(name: 'sajda') bool? sajda});

  $EditionModelCopyWith<$Res>? get edition;
  $SurahInfoModelCopyWith<$Res>? get surah;
}

/// @nodoc
class _$SearchMatchModelCopyWithImpl<$Res, $Val extends SearchMatchModel>
    implements $SearchMatchModelCopyWith<$Res> {
  _$SearchMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? text = freezed,
    Object? edition = freezed,
    Object? surah = freezed,
    Object? numberInSurah = freezed,
    Object? juz = freezed,
    Object? manzil = freezed,
    Object? page = freezed,
    Object? ruku = freezed,
    Object? hizbQuarter = freezed,
    Object? sajda = freezed,
  }) {
    return _then(_value.copyWith(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      edition: freezed == edition
          ? _value.edition
          : edition // ignore: cast_nullable_to_non_nullable
              as EditionModel?,
      surah: freezed == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as SurahInfoModel?,
      numberInSurah: freezed == numberInSurah
          ? _value.numberInSurah
          : numberInSurah // ignore: cast_nullable_to_non_nullable
              as int?,
      juz: freezed == juz
          ? _value.juz
          : juz // ignore: cast_nullable_to_non_nullable
              as int?,
      manzil: freezed == manzil
          ? _value.manzil
          : manzil // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      ruku: freezed == ruku
          ? _value.ruku
          : ruku // ignore: cast_nullable_to_non_nullable
              as int?,
      hizbQuarter: freezed == hizbQuarter
          ? _value.hizbQuarter
          : hizbQuarter // ignore: cast_nullable_to_non_nullable
              as int?,
      sajda: freezed == sajda
          ? _value.sajda
          : sajda // ignore: cast_nullable_to_non_nullable
              as bool?,
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

  @override
  @pragma('vm:prefer-inline')
  $SurahInfoModelCopyWith<$Res>? get surah {
    if (_value.surah == null) {
      return null;
    }

    return $SurahInfoModelCopyWith<$Res>(_value.surah!, (value) {
      return _then(_value.copyWith(surah: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchMatchModelImplCopyWith<$Res>
    implements $SearchMatchModelCopyWith<$Res> {
  factory _$$SearchMatchModelImplCopyWith(_$SearchMatchModelImpl value,
          $Res Function(_$SearchMatchModelImpl) then) =
      __$$SearchMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'edition') EditionModel? edition,
      @JsonKey(name: 'surah') SurahInfoModel? surah,
      @JsonKey(name: 'numberInSurah') int? numberInSurah,
      @JsonKey(name: 'juz') int? juz,
      @JsonKey(name: 'manzil') int? manzil,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'ruku') int? ruku,
      @JsonKey(name: 'hizbQuarter') int? hizbQuarter,
      @JsonKey(name: 'sajda') bool? sajda});

  @override
  $EditionModelCopyWith<$Res>? get edition;
  @override
  $SurahInfoModelCopyWith<$Res>? get surah;
}

/// @nodoc
class __$$SearchMatchModelImplCopyWithImpl<$Res>
    extends _$SearchMatchModelCopyWithImpl<$Res, _$SearchMatchModelImpl>
    implements _$$SearchMatchModelImplCopyWith<$Res> {
  __$$SearchMatchModelImplCopyWithImpl(_$SearchMatchModelImpl _value,
      $Res Function(_$SearchMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? text = freezed,
    Object? edition = freezed,
    Object? surah = freezed,
    Object? numberInSurah = freezed,
    Object? juz = freezed,
    Object? manzil = freezed,
    Object? page = freezed,
    Object? ruku = freezed,
    Object? hizbQuarter = freezed,
    Object? sajda = freezed,
  }) {
    return _then(_$SearchMatchModelImpl(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      edition: freezed == edition
          ? _value.edition
          : edition // ignore: cast_nullable_to_non_nullable
              as EditionModel?,
      surah: freezed == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as SurahInfoModel?,
      numberInSurah: freezed == numberInSurah
          ? _value.numberInSurah
          : numberInSurah // ignore: cast_nullable_to_non_nullable
              as int?,
      juz: freezed == juz
          ? _value.juz
          : juz // ignore: cast_nullable_to_non_nullable
              as int?,
      manzil: freezed == manzil
          ? _value.manzil
          : manzil // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      ruku: freezed == ruku
          ? _value.ruku
          : ruku // ignore: cast_nullable_to_non_nullable
              as int?,
      hizbQuarter: freezed == hizbQuarter
          ? _value.hizbQuarter
          : hizbQuarter // ignore: cast_nullable_to_non_nullable
              as int?,
      sajda: freezed == sajda
          ? _value.sajda
          : sajda // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchMatchModelImpl extends _SearchMatchModel {
  const _$SearchMatchModelImpl(
      {@JsonKey(name: 'number') this.number,
      @JsonKey(name: 'text') this.text,
      @JsonKey(name: 'edition') this.edition,
      @JsonKey(name: 'surah') this.surah,
      @JsonKey(name: 'numberInSurah') this.numberInSurah,
      @JsonKey(name: 'juz') this.juz,
      @JsonKey(name: 'manzil') this.manzil,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'ruku') this.ruku,
      @JsonKey(name: 'hizbQuarter') this.hizbQuarter,
      @JsonKey(name: 'sajda') this.sajda})
      : super._();

  factory _$SearchMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchMatchModelImplFromJson(json);

  @override
  @JsonKey(name: 'number')
  final int? number;
  @override
  @JsonKey(name: 'text')
  final String? text;
  @override
  @JsonKey(name: 'edition')
  final EditionModel? edition;
  @override
  @JsonKey(name: 'surah')
  final SurahInfoModel? surah;
  @override
  @JsonKey(name: 'numberInSurah')
  final int? numberInSurah;
  @override
  @JsonKey(name: 'juz')
  final int? juz;
  @override
  @JsonKey(name: 'manzil')
  final int? manzil;
  @override
  @JsonKey(name: 'page')
  final int? page;
  @override
  @JsonKey(name: 'ruku')
  final int? ruku;
  @override
  @JsonKey(name: 'hizbQuarter')
  final int? hizbQuarter;
  @override
  @JsonKey(name: 'sajda')
  final bool? sajda;

  @override
  String toString() {
    return 'SearchMatchModel(number: $number, text: $text, edition: $edition, surah: $surah, numberInSurah: $numberInSurah, juz: $juz, manzil: $manzil, page: $page, ruku: $ruku, hizbQuarter: $hizbQuarter, sajda: $sajda)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchMatchModelImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.edition, edition) || other.edition == edition) &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.numberInSurah, numberInSurah) ||
                other.numberInSurah == numberInSurah) &&
            (identical(other.juz, juz) || other.juz == juz) &&
            (identical(other.manzil, manzil) || other.manzil == manzil) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.ruku, ruku) || other.ruku == ruku) &&
            (identical(other.hizbQuarter, hizbQuarter) ||
                other.hizbQuarter == hizbQuarter) &&
            (identical(other.sajda, sajda) || other.sajda == sajda));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, number, text, edition, surah,
      numberInSurah, juz, manzil, page, ruku, hizbQuarter, sajda);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchMatchModelImplCopyWith<_$SearchMatchModelImpl> get copyWith =>
      __$$SearchMatchModelImplCopyWithImpl<_$SearchMatchModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchMatchModelImplToJson(
      this,
    );
  }
}

abstract class _SearchMatchModel extends SearchMatchModel {
  const factory _SearchMatchModel(
      {@JsonKey(name: 'number') final int? number,
      @JsonKey(name: 'text') final String? text,
      @JsonKey(name: 'edition') final EditionModel? edition,
      @JsonKey(name: 'surah') final SurahInfoModel? surah,
      @JsonKey(name: 'numberInSurah') final int? numberInSurah,
      @JsonKey(name: 'juz') final int? juz,
      @JsonKey(name: 'manzil') final int? manzil,
      @JsonKey(name: 'page') final int? page,
      @JsonKey(name: 'ruku') final int? ruku,
      @JsonKey(name: 'hizbQuarter') final int? hizbQuarter,
      @JsonKey(name: 'sajda') final bool? sajda}) = _$SearchMatchModelImpl;
  const _SearchMatchModel._() : super._();

  factory _SearchMatchModel.fromJson(Map<String, dynamic> json) =
      _$SearchMatchModelImpl.fromJson;

  @override
  @JsonKey(name: 'number')
  int? get number;
  @override
  @JsonKey(name: 'text')
  String? get text;
  @override
  @JsonKey(name: 'edition')
  EditionModel? get edition;
  @override
  @JsonKey(name: 'surah')
  SurahInfoModel? get surah;
  @override
  @JsonKey(name: 'numberInSurah')
  int? get numberInSurah;
  @override
  @JsonKey(name: 'juz')
  int? get juz;
  @override
  @JsonKey(name: 'manzil')
  int? get manzil;
  @override
  @JsonKey(name: 'page')
  int? get page;
  @override
  @JsonKey(name: 'ruku')
  int? get ruku;
  @override
  @JsonKey(name: 'hizbQuarter')
  int? get hizbQuarter;
  @override
  @JsonKey(name: 'sajda')
  bool? get sajda;
  @override
  @JsonKey(ignore: true)
  _$$SearchMatchModelImplCopyWith<_$SearchMatchModelImpl> get copyWith =>
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

SurahInfoModel _$SurahInfoModelFromJson(Map<String, dynamic> json) {
  return _SurahInfoModel.fromJson(json);
}

/// @nodoc
mixin _$SurahInfoModel {
  @JsonKey(name: 'number')
  int? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishName')
  String? get englishName => throw _privateConstructorUsedError;
  @JsonKey(name: 'englishNameTranslation')
  String? get englishNameTranslation => throw _privateConstructorUsedError;
  @JsonKey(name: 'numberOfAyahs')
  int? get numberOfAyahs => throw _privateConstructorUsedError;
  @JsonKey(name: 'revelationType')
  String? get revelationType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SurahInfoModelCopyWith<SurahInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurahInfoModelCopyWith<$Res> {
  factory $SurahInfoModelCopyWith(
          SurahInfoModel value, $Res Function(SurahInfoModel) then) =
      _$SurahInfoModelCopyWithImpl<$Res, SurahInfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
      @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
      @JsonKey(name: 'revelationType') String? revelationType});
}

/// @nodoc
class _$SurahInfoModelCopyWithImpl<$Res, $Val extends SurahInfoModel>
    implements $SurahInfoModelCopyWith<$Res> {
  _$SurahInfoModelCopyWithImpl(this._value, this._then);

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
    Object? numberOfAyahs = freezed,
    Object? revelationType = freezed,
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
      numberOfAyahs: freezed == numberOfAyahs
          ? _value.numberOfAyahs
          : numberOfAyahs // ignore: cast_nullable_to_non_nullable
              as int?,
      revelationType: freezed == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SurahInfoModelImplCopyWith<$Res>
    implements $SurahInfoModelCopyWith<$Res> {
  factory _$$SurahInfoModelImplCopyWith(_$SurahInfoModelImpl value,
          $Res Function(_$SurahInfoModelImpl) then) =
      __$$SurahInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'number') int? number,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'englishName') String? englishName,
      @JsonKey(name: 'englishNameTranslation') String? englishNameTranslation,
      @JsonKey(name: 'numberOfAyahs') int? numberOfAyahs,
      @JsonKey(name: 'revelationType') String? revelationType});
}

/// @nodoc
class __$$SurahInfoModelImplCopyWithImpl<$Res>
    extends _$SurahInfoModelCopyWithImpl<$Res, _$SurahInfoModelImpl>
    implements _$$SurahInfoModelImplCopyWith<$Res> {
  __$$SurahInfoModelImplCopyWithImpl(
      _$SurahInfoModelImpl _value, $Res Function(_$SurahInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? name = freezed,
    Object? englishName = freezed,
    Object? englishNameTranslation = freezed,
    Object? numberOfAyahs = freezed,
    Object? revelationType = freezed,
  }) {
    return _then(_$SurahInfoModelImpl(
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
      numberOfAyahs: freezed == numberOfAyahs
          ? _value.numberOfAyahs
          : numberOfAyahs // ignore: cast_nullable_to_non_nullable
              as int?,
      revelationType: freezed == revelationType
          ? _value.revelationType
          : revelationType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurahInfoModelImpl implements _SurahInfoModel {
  const _$SurahInfoModelImpl(
      {@JsonKey(name: 'number') this.number,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'englishName') this.englishName,
      @JsonKey(name: 'englishNameTranslation') this.englishNameTranslation,
      @JsonKey(name: 'numberOfAyahs') this.numberOfAyahs,
      @JsonKey(name: 'revelationType') this.revelationType});

  factory _$SurahInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurahInfoModelImplFromJson(json);

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
  @JsonKey(name: 'numberOfAyahs')
  final int? numberOfAyahs;
  @override
  @JsonKey(name: 'revelationType')
  final String? revelationType;

  @override
  String toString() {
    return 'SurahInfoModel(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, numberOfAyahs: $numberOfAyahs, revelationType: $revelationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurahInfoModelImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.englishName, englishName) ||
                other.englishName == englishName) &&
            (identical(other.englishNameTranslation, englishNameTranslation) ||
                other.englishNameTranslation == englishNameTranslation) &&
            (identical(other.numberOfAyahs, numberOfAyahs) ||
                other.numberOfAyahs == numberOfAyahs) &&
            (identical(other.revelationType, revelationType) ||
                other.revelationType == revelationType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, number, name, englishName,
      englishNameTranslation, numberOfAyahs, revelationType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SurahInfoModelImplCopyWith<_$SurahInfoModelImpl> get copyWith =>
      __$$SurahInfoModelImplCopyWithImpl<_$SurahInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurahInfoModelImplToJson(
      this,
    );
  }
}

abstract class _SurahInfoModel implements SurahInfoModel {
  const factory _SurahInfoModel(
          {@JsonKey(name: 'number') final int? number,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'englishName') final String? englishName,
          @JsonKey(name: 'englishNameTranslation')
          final String? englishNameTranslation,
          @JsonKey(name: 'numberOfAyahs') final int? numberOfAyahs,
          @JsonKey(name: 'revelationType') final String? revelationType}) =
      _$SurahInfoModelImpl;

  factory _SurahInfoModel.fromJson(Map<String, dynamic> json) =
      _$SurahInfoModelImpl.fromJson;

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
  @JsonKey(name: 'numberOfAyahs')
  int? get numberOfAyahs;
  @override
  @JsonKey(name: 'revelationType')
  String? get revelationType;
  @override
  @JsonKey(ignore: true)
  _$$SurahInfoModelImplCopyWith<_$SurahInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
