import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

/// Use case for retrieving the complete list of Quran chapters (Surahs).
///
/// This use case fetches all 114 surahs of the Quran with their metadata
/// including Arabic names, English names, number of verses, revelation type,
/// and ordering information.
///
/// **Architecture Pattern**: Clean Architecture Use Case
/// - Single Responsibility: Only fetches the surah list
/// - Domain Layer: Independent of UI and data sources
/// - Repository Pattern: Delegates data fetching to repository
///
/// **Data Flow**:
/// 1. Cubit/UI calls this use case
/// 2. Use case requests data from repository
/// 3. Repository checks cache first (Hive), then fetches from API if needed
/// 4. Data is returned as domain entities
///
/// **Caching Strategy**:
/// The repository implements caching to improve performance:
/// - First call: Fetches from API and caches locally
/// - Subsequent calls: Returns cached data if available and not expired
/// - Cache expiration: 24 hours (configurable in repository)
///
/// **Usage Example**:
/// ```dart
/// final useCase = GetSurahListUseCase(repository);
/// final result = await useCase();
///
/// result.fold(
///   (failure) => print('Failed to load surahs: ${failure.message}'),
///   (surahs) {
///     print('Loaded ${surahs.length} surahs');
///     for (final surah in surahs) {
///       print('${surah.number}. ${surah.englishName} (${surah.numberOfAyahs} verses)');
///     }
///   },
/// );
/// ```
class GetSurahListUseCase {
  /// Repository interface for accessing Quran surah data.
  ///
  /// This repository handles data fetching from both remote (API) and
  /// local (Hive cache) sources, implementing the caching strategy.
  final QuranListRepository repository;

  /// Creates a new instance of [GetSurahListUseCase].
  ///
  /// Requires a [QuranListRepository] implementation to perform data operations.
  GetSurahListUseCase(this.repository);

  /// Retrieves the complete list of all Quran surahs (chapters).
  ///
  /// Fetches all 114 surahs with their complete metadata. The data is cached
  /// locally after the first successful fetch to improve performance and enable
  /// offline access.
  ///
  /// **Returns**:
  /// - `Right<List<SurahEntity>>`: List of all 114 surahs with metadata if successful.
  ///   Each surah contains:
  ///   - number: Surah number (1-114)
  ///   - name: Arabic name
  ///   - englishName: English transliteration
  ///   - englishNameTranslation: English meaning
  ///   - numberOfAyahs: Total verses in the surah
  ///   - revelationType: 'Meccan' or 'Medinan'
  /// - `Left<Failure>`: Error details if operation fails.
  ///
  /// **Error Handling**:
  /// - [ServerFailure]: Network errors, API failures, or HTTP errors
  /// - [CacheFailure]: Local storage errors when accessing Hive
  /// - If cached data exists, returns it even if network request fails
  ///
  /// **Performance**:
  /// - First call: ~500ms (network request + caching)
  /// - Cached calls: <50ms (local Hive read)
  /// - Data size: ~15KB for all 114 surahs
  ///
  /// **Example**:
  /// ```dart
  /// // Simple usage
  /// final result = await useCase();
  ///
  /// // With error handling
  /// result.fold(
  ///   (failure) {
  ///     if (failure is ServerFailure) {
  ///       showErrorDialog('Network error. Check your connection.');
  ///     }
  ///   },
  ///   (surahs) {
  ///     // Display surah list in UI
  ///     displaySurahList(surahs);
  ///   },
  /// );
  /// ```
  Future<Either<Failure, List<SurahEntity>>> call() async {
    return await repository.getSurahList();
  }
}