// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuranDetailState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuranDetailStateCopyWith<QuranDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranDetailStateCopyWith<$Res> {
  factory $QuranDetailStateCopyWith(
          QuranDetailState value, $Res Function(QuranDetailState) then) =
      _$QuranDetailStateCopyWithImpl<$Res, QuranDetailState>;
  @useResult
  $Res call({bool isLoading, String? errorMessage, int value});
}

/// @nodoc
class _$QuranDetailStateCopyWithImpl<$Res, $Val extends QuranDetailState>
    implements $QuranDetailStateCopyWith<$Res> {
  _$QuranDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuranDetailStateImplCopyWith<$Res>
    implements $QuranDetailStateCopyWith<$Res> {
  factory _$$QuranDetailStateImplCopyWith(_$QuranDetailStateImpl value,
          $Res Function(_$QuranDetailStateImpl) then) =
      __$$QuranDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorMessage, int value});
}

/// @nodoc
class __$$QuranDetailStateImplCopyWithImpl<$Res>
    extends _$QuranDetailStateCopyWithImpl<$Res, _$QuranDetailStateImpl>
    implements _$$QuranDetailStateImplCopyWith<$Res> {
  __$$QuranDetailStateImplCopyWithImpl(_$QuranDetailStateImpl _value,
      $Res Function(_$QuranDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? value = null,
  }) {
    return _then(_$QuranDetailStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$QuranDetailStateImpl implements _QuranDetailState {
  const _$QuranDetailStateImpl(
      {this.isLoading = false, this.errorMessage, this.value = 0});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final int value;

  @override
  String toString() {
    return 'QuranDetailState(isLoading: $isLoading, errorMessage: $errorMessage, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuranDetailStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, errorMessage, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuranDetailStateImplCopyWith<_$QuranDetailStateImpl> get copyWith =>
      __$$QuranDetailStateImplCopyWithImpl<_$QuranDetailStateImpl>(
          this, _$identity);
}

abstract class _QuranDetailState implements QuranDetailState {
  const factory _QuranDetailState(
      {final bool isLoading,
      final String? errorMessage,
      final int value}) = _$QuranDetailStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$QuranDetailStateImplCopyWith<_$QuranDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
