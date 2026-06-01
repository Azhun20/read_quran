import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';

/// Use case for retrieving the list of available Quran reciters (Qaris).
///
/// This use case fetches all available Quran reciters with their metadata
/// including Arabic names, English names, audio format details, recitation type,
/// and audio quality (bitrate). Users can select a reciter to listen to their
/// recitation of any surah in the Quran.
///
/// **Architecture Pattern**: Clean Architecture Use Case
/// - Single Responsibility: Only fetches the available reciters list
/// - Domain Layer: Independent of UI and data sources
/// - Repository Pattern: Delegates data fetching to repository
///
/// **Data Flow**:
/// 1. Cubit/UI calls this use case when user needs to select a reciter
/// 2. Use case requests data from repository
/// 3. Repository checks cache first (Hive), then fetches from API if needed
/// 4. Data is returned as domain entities
///
/// **Caching Strategy**:
/// The repository implements caching to improve performance:
/// - First call: Fetches from API and caches locally
/// - Subsequent calls: Returns cached data if available and not expired
/// - Cache expiration: 7 days (configurable in repository)
/// - Offline access: Cached data enables offline reciter selection
///
/// **Usage Example**:
/// ```dart
/// final useCase = GetAvailableRecitersUseCase(repository);
/// final result = await useCase();
///
/// result.fold(
///   (failure) => print('Failed to load reciters: ${failure.message}'),
///   (reciters) {
///     print('Loaded ${reciters.length} reciters');
///     for (final reciter in reciters) {
///       print('${reciter.englishName} - ${reciter.bitrate} kbps (${reciter.type})');
///     }
///   },
/// );
/// ```
class GetAvailableRecitersUseCase {
  /// Repository interface for accessing Quran reciter data.
  ///
  /// This repository handles data fetching from both remote (API) and
  /// local (Hive cache) sources, implementing the caching strategy.
  final QuranListRepository repository;

  /// Creates a new instance of [GetAvailableRecitersUseCase].
  ///
  /// Requires a [QuranListRepository] implementation to perform data operations.
  GetAvailableRecitersUseCase(this.repository);

  /// Retrieves the complete list of available Quran reciters.
  ///
  /// Fetches all available reciters with their complete metadata. The data is cached
  /// locally after the first successful fetch to improve performance and enable
  /// offline access for reciter selection.
  ///
  /// **Returns**:
  /// - `Right<List<ReciterEntity>>`: List of all available reciters if successful.
  ///   Each reciter contains:
  ///   - identifier: Unique identifier (e.g., 'ar.alafasy', 'ar.abdulbasitmurattal')
  ///   - name: Arabic name of the reciter
  ///   - englishName: English transliteration of the reciter's name
  ///   - format: Audio format (typically 'audio')
  ///   - type: Recitation type ('versebyverse' or 'full')
  ///   - bitrate: Audio quality in kbps (e.g., '128', '64')
  /// - `Left<Failure>`: Error details if operation fails.
  ///
  /// **Error Handling**:
  /// - [ServerFailure]: Network errors, API failures, or HTTP errors
  /// - [CacheFailure]: Local storage errors when accessing Hive
  /// - If cached data exists, returns it even if network request fails
  ///
  /// **Performance**:
  /// - First call: ~300ms (network request + caching)
  /// - Cached calls: <50ms (local Hive read)
  /// - Data size: ~5KB for typical reciter list
  ///
  /// **Recitation Types**:
  /// - `versebyverse`: Audio file for each individual ayah
  /// - `full`: Complete surah audio in a single file
  ///
  /// **Example**:
  /// ```dart
  /// // Simple usage
  /// final result = await useCase();
  ///
  /// // With error handling and UI integration
  /// result.fold(
  ///   (failure) {
  ///     if (failure is ServerFailure) {
  ///       showErrorDialog('Network error. Check your connection.');
  ///     }
  ///   },
  ///   (reciters) {
  ///     // Filter for high-quality verse-by-verse reciters
  ///     final highQualityReciters = reciters.where(
  ///       (r) => r.type == 'versebyverse' && r.bitrate == '128'
  ///     ).toList();
  ///
  ///     // Display in dropdown or list
  ///     displayReciterSelection(highQualityReciters);
  ///   },
  /// );
  /// ```
  Future<Either<Failure, List<ReciterEntity>>> call() async {
    return await repository.getAvailableReciters();
  }
}
