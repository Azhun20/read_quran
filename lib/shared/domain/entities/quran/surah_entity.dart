import 'package:equatable/equatable.dart';

/// Shared entity representing a Surah (chapter) in the Quran
/// Used across multiple features (list, detail, search)
class SurahEntity extends Equatable {
  const SurahEntity({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.numberOfAyahs,
  });

  /// Surah number (1-114)
  final int? number;

  /// Arabic name of the surah
  final String? name;

  /// English name/transliteration
  final String? englishName;

  /// English translation of the name
  final String? englishNameTranslation;

  /// Type of revelation (Meccan or Medinan)
  final String? revelationType;

  /// Total number of ayahs (verses) in the surah
  final int? numberOfAyahs;

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        numberOfAyahs,
      ];
}