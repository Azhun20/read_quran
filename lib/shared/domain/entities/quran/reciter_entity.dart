import 'package:equatable/equatable.dart';

/// Shared entity representing a Quran reciter (Qari)
/// Used in detail and search features
class ReciterEntity extends Equatable {
  const ReciterEntity({
    this.identifier,
    this.name,
    this.englishName,
    this.format,
    this.type,
    this.bitrate,
  });

  /// Unique identifier for the reciter/edition
  final String? identifier;

  /// Arabic name of the reciter
  final String? name;

  /// English name of the reciter
  final String? englishName;

  /// Audio format (e.g., audio)
  final String? format;

  /// Type of recitation (e.g., versebyverse, full)
  final String? type;

  /// Audio bitrate (e.g., 128, 64)
  final String? bitrate;

  @override
  List<Object?> get props => [
        identifier,
        name,
        englishName,
        format,
        type,
        bitrate,
      ];
}