import 'package:flutter/material.dart';

/// A Result type for better error handling without exceptions.
///
/// Example usage:
/// ```dart
/// Future<Result<List<Post>>> getPosts() async {
///   try {
///     final posts = await dataSource.fetchPosts();
///     return Success(posts);
///   } catch (e) {
///     return Failure(e.toString());
///   }
/// }
/// ```
@immutable
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
    Success(data: final data) => data,
    Failure() => null,
  };

  String? get errorOrNull => switch (this) {
    Success() => null,
    Failure(error: final error) => error,
  };

  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final data) => Success(transform(data)),
      Failure(error: final error) => Failure(error),
    };
  }

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(String error) onFailure,
  }) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Failure(error: final error) => onFailure(error),
    };
  }

  T getOrDefault(T defaultValue) {
    return switch (this) {
      Success(data: final data) => data,
      Failure() => defaultValue,
    };
  }
}

/// Represents a successful result with data
@immutable
class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success(data: $data)';
}

/// Represents a failed result with an error message
@immutable
class Failure<T> extends Result<T> {
  const Failure(this.error);
  final String error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure(error: $error)';
}

/// Helper function to safely execute an async operation and return a Result
Future<Result<T>> runCatching<T>(Future<T> Function() operation) async {
  try {
    final result = await operation();
    return Success(result);
  } catch (e) {
    return Failure(e.toString());
  }
}
