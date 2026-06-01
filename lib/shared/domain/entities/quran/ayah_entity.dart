import 'package:equatable/equatable.dart';

/// Shared entity representing an Ayah (verse) in the Quran
/// Used across multiple features (detail, search)
class AyahEntity extends Equatable {
  const AyahEntity({
    this.number,
    this.text,
    this.audioUrl,
    this.numberInSurah,
    this.juz,
    this.page,
    this.surahNumber,
    this.surahName,
    this.surahEnglishName,
    this.translation,
    this.transliteration,
    this.sajda,
    this.ruku,
    this.manzil,
    this.hizbQuarter,
  });

  /// Absolute ayah number in the Quran
  final int? number;

  /// The text content of the ayah
  final String? text;

  /// Audio URL for this specific ayah
  final String? audioUrl;

  /// Ayah number within its surah
  final int? numberInSurah;

  /// Juz (part) number
  final int? juz;

  /// Page number in the Mushaf
  final int? page;

  /// The surah number this ayah belongs to
  final int? surahNumber;

  /// The surah name (Arabic) this ayah belongs to
  final String? surahName;

  /// The surah English name this ayah belongs to
  final String? surahEnglishName;

  /// Translation text (optional)
  final String? translation;

  /// Transliteration text (optional)
  final String? transliteration;

  /// Sajda information if this ayah requires prostration
  final bool? sajda;

  /// Ruku number
  final int? ruku;

  /// Manzil number
  final int? manzil;

  /// Hizb quarter number
  final int? hizbQuarter;

  @override
  List<Object?> get props => [
        number,
        text,
        audioUrl,
        numberInSurah,
        juz,
        page,
        surahNumber,
        surahName,
        surahEnglishName,
        translation,
        transliteration,
        sajda,
        ruku,
        manzil,
        hizbQuarter,
      ];
}