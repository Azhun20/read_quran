import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';

/// Use case for retrieving complete Surah details with verses and audio.
///
/// This use case fetches comprehensive data for a specific surah including:
/// - Surah metadata (name, number of verses, revelation type, etc.)
/// - All ayahs (verses) in the surah with Arabic text
/// - Audio URLs for each ayah from the selected reciter
/// - Edition information for the recitation
///
/// **Architecture Pattern**: Clean Architecture Use Case
/// - Single Responsibility: Fetches complete surah with ayahs and audio
/// - Domain Layer: Independent of UI and data sources
/// - Repository Pattern: Delegates data fetching to repository
/// - Combines multiple data sources (surah info, ayahs, audio)
///
/// **Data Flow**:
/// 1. UI/Cubit calls this use case with surah number and reciter
/// 2. Use case requests combined data from repository
/// 3. Repository orchestrates multiple API calls if needed:
///    - Fetches surah metadata
///    - Fetches all ayahs for the surah
///    - Fetches audio URLs for the selected reciter
/// 4. Data is combined and returned as a single entity
///
/// **Caching Strategy**:
/// The repository implements intelligent caching:
/// - Surah metadata: Cached for 24 hours
/// - Ayahs (Arabic text): Cached permanently (Quran text never changes)
/// - Audio URLs: Cached for 7 days (may change if API structure updates)
/// - Cache key includes both surah number and reciter identifier
///
/// **Performance Considerations**:
/// - First load: Multiple API calls (~1-2 seconds)
/// - Cached load: <100ms from local storage
/// - Large surahs (e.g., Al-Baqarah with 286 verses) may take longer
/// - Audio URLs are not pre-downloaded, only the links are cached
///
/// **Usage Example**:
/// ```dart
/// final useCase = GetSurahDetailUseCase(repository);
/// final result = await useCase(
///   surahNumber: 1, // Al-Fatihah
///   reciterIdentifier: 'ar.alafasy',
/// );
///
/// result.fold(
///   (failure) => print('Failed to load surah: ${failure.message}'),
///   (surahDetail) {
///     print('Surah: ${surahDetail.surah?.englishName}');
///     print('Total verses: ${surahDetail.ayahs?.length}');
///     print('Reciter edition: ${surahDetail.edition}');
///
///     // Access individual ayahs
///     for (final ayah in surahDetail.ayahs ?? []) {
///       print('Ayah ${ayah.numberInSurah}: ${ayah.text}');
///       print('Audio: ${ayah.audio}');
///     }
///   },
/// );
/// ```
class GetSurahDetailUseCase {
  /// Repository interface for accessing Quran surah detail data.
  ///
  /// This repository handles fetching and combining data from multiple sources:
  /// - Surah metadata from the surah list API
  /// - Ayah text from the Quran text API
  /// - Audio URLs from the reciter-specific audio API
  final QuranDetailRepository repository;

  /// Creates a new instance of [GetSurahDetailUseCase].
  ///
  /// Requires a [QuranDetailRepository] implementation to perform data operations.
  GetSurahDetailUseCase(this.repository);

  /// Retrieves complete details for a specific surah including all verses and audio.
  ///
  /// Fetches comprehensive data for the requested surah, combining metadata,
  /// Arabic text, and audio URLs from the selected reciter. The data is cached
  /// locally for offline access and improved performance.
  ///
  /// **Parameters**:
  /// - [surahNumber]: The surah number (1-114) to fetch details for (required).
  ///   Must be a valid surah number within the range.
  ///   Examples:
  ///   - 1 = Al-Fatihah (7 verses)
  ///   - 2 = Al-Baqarah (286 verses - longest surah)
  ///   - 114 = An-Nas (6 verses)
  /// - [reciterIdentifier]: Unique identifier for the reciter (required).
  ///   Must match an identifier from GetAvailableRecitersUseCase.
  ///   Examples:
  ///   - 'ar.alafasy' = Mishary Rashid Alafasy
  ///   - 'ar.abdulbasitmurattal' = Abdul Basit (Murattal)
  ///   - 'ar.husary' = Mahmoud Khalil Al-Husary
  ///
  /// **Returns**:
  /// - `Right<SurahDetailEntity>`: Complete surah data if successful, containing:
  ///   - surah: [SurahEntity] with metadata (name, number of verses, etc.)
  ///   - ayahs: [List<AyahEntity>] with all verses including:
  ///     - number: Global ayah number across entire Quran
  ///     - numberInSurah: Ayah number within this surah
  ///     - text: Arabic text of the ayah
  ///     - audio: URL to the audio file for this ayah
  ///     - surahNumber: Reference back to the surah number
  ///   - edition: Identifier of the recitation edition used
  /// - `Left<Failure>`: Error details if operation fails.
  ///
  /// **Error Handling**:
  /// - [ServerFailure]: Network errors, API failures, or HTTP errors
  /// - [CacheFailure]: Local storage errors when accessing Hive
  /// - Invalid surah number (< 1 or > 114) returns ServerFailure
  /// - Invalid reciter identifier returns ServerFailure with 404 message
  /// - If cached data exists, may return it even if network request fails
  ///
  /// **Performance**:
  /// - First call (uncached): ~1-2s depending on surah length
  /// - Cached calls: <100ms (local Hive read)
  /// - Data size varies by surah:
  ///   - Small surah (Al-Fatihah): ~2KB
  ///   - Large surah (Al-Baqarah): ~50KB
  ///
  /// **Common Use Cases**:
  /// 1. **Surah Reading Page**: Display surah with audio playback
  /// 2. **Verse-by-Verse Navigation**: Allow users to jump between ayahs
  /// 3. **Audio Player Integration**: Play recitation with synchronized text
  /// 4. **Offline Reading**: Access previously cached surahs offline
  ///
  /// **Example**:
  /// ```dart
  /// // Load Surah Al-Fatihah with Alafasy recitation
  /// final result = await useCase(
  ///   surahNumber: 1,
  ///   reciterIdentifier: 'ar.alafasy',
  /// );
  ///
  /// // With error handling and UI integration
  /// result.fold(
  ///   (failure) {
  ///     if (failure is ServerFailure) {
  ///       if (failure.message.contains('404')) {
  ///         showErrorDialog('Reciter not found. Please select another.');
  ///       } else {
  ///         showErrorDialog('Network error. Check your connection.');
  ///       }
  ///     }
  ///   },
  ///   (surahDetail) {
  ///     // Update UI with surah data
  ///     displaySurahHeader(surahDetail.surah);
  ///
  ///     // Initialize audio player with first ayah
  ///     final firstAyah = surahDetail.ayahs?.first;
  ///     if (firstAyah != null) {
  ///       audioPlayer.setUrl(firstAyah.audio);
  ///     }
  ///
  ///     // Display all verses
  ///     displayAyahList(surahDetail.ayahs);
  ///   },
  /// );
  ///
  /// // Load longest surah (Al-Baqarah) with different reciter
  /// final baqarahResult = await useCase(
  ///   surahNumber: 2,
  ///   reciterIdentifier: 'ar.abdulbasitmurattal',
  /// );
  /// ```
  Future<Either<Failure, SurahDetailEntity>> call({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    return await repository.getSurahDetail(
      surahNumber: surahNumber,
      reciterIdentifier: reciterIdentifier,
    );
  }
}
