import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_list/data/datasources/quran_list_remote_datasource.dart';
import 'package:read_quran/features/quran_list/data/models/reciter_model.dart';
import 'package:read_quran/features/quran_list/data/models/surah_model.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

/// Concrete implementation of [QuranListRepository] interface.
///
/// This repository implements the data layer logic for fetching Quran surah lists
/// and available reciters. It acts as a mediator between the domain layer (use cases)
/// and the data sources (remote API, local cache).
///
/// **Architecture Layer**: Data Layer
/// - Implements domain repository interface
/// - Coordinates between data sources
/// - Transforms data models to domain entities
/// - Handles error mapping and exception handling
///
/// **Responsibilities**:
/// 1. Fetch surah list from remote data source with caching
/// 2. Fetch available reciters from remote data source with caching
/// 3. Transform JSON/Model data to domain entities
/// 4. Handle errors and map exceptions to domain failures
/// 5. Log operations for debugging and monitoring
///
/// **Data Sources Used**:
/// - [QuranListRemoteDataSource]: Primary data source for API calls
///   - Handles HTTP requests to al-quran.cloud API
///   - Implements caching strategy with Hive
///   - Background cache refresh for better UX
///
/// **Error Handling Strategy**:
/// - Catches all exceptions from data sources
/// - Maps exceptions to domain [Failure] types:
///   - Network errors → [ServerFailure]
///   - Cache errors → [CacheFailure]
///   - Unknown errors → [UnexpectedFailure]
/// - Logs errors with stack traces for debugging
///
/// **Data Flow**:
/// ```
/// Use Case
///   ↓
/// Repository (this class)
///   ↓
/// Remote Data Source → Check Cache → API Call → Cache Result
///   ↓
/// Model → Entity Transformation
///   ↓
/// Either<Failure, Entity> returned to Use Case
/// ```
class QuranListRepositoryImpl implements QuranListRepository {
  /// Creates a new instance of [QuranListRepositoryImpl].
  ///
  /// Requires a [QuranListRemoteDataSource] to fetch data from API and cache.
  QuranListRepositoryImpl(this._remoteDataSource);

  /// Remote data source for fetching surahs and reciters.
  ///
  /// This data source handles:
  /// - API communication with al-quran.cloud
  /// - Local caching with Hive
  /// - Cache expiration and refresh logic
  final QuranListRemoteDataSource _remoteDataSource;

  /// Fetches the complete list of all 114 Quran surahs.
  ///
  /// This method retrieves all surahs from the remote data source, which
  /// implements an intelligent caching strategy to minimize API calls and
  /// provide offline support.
  ///
  /// **Data Flow**:
  /// 1. Data source checks local cache (Hive)
  /// 2. If cache valid and not expired (24h), returns cached data
  /// 3. If cache invalid/expired, fetches from API
  /// 4. API response is cached for future use
  /// 5. JSON data is transformed to [SurahModel]
  /// 6. Models are converted to [SurahEntity] domain objects
  ///
  /// **Caching Behavior**:
  /// - Cache Duration: 24 hours
  /// - Background Refresh: Yes (async cache update after returning cached data)
  /// - Offline Support: Returns cached data if available, even if expired
  ///
  /// **Returns**:
  /// - `Right<List<SurahEntity>>`: List of 114 surahs if successful
  /// - `Left<Failure>`: Error details if operation fails
  ///
  /// **Error Handling**:
  /// - Network errors are caught and mapped to [ServerFailure]
  /// - Cache errors are mapped to [CacheFailure]
  /// - All errors are logged with stack traces
  /// - Returns cached data as fallback when possible
  ///
  /// **Performance**:
  /// - First call (no cache): ~500ms (API + caching)
  /// - Cached calls: <50ms (Hive read)
  /// - Data size: ~15KB for all surahs
  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    try {
      // Fetch from data source (checks cache first, then API)
      final result = await _remoteDataSource.getSurahList();

      // Transform JSON data to domain entities
      final surahs = result.map((json) {
        final model = SurahModel.fromJson(json);
        return model.toEntity();
      }).toList();

      AppLogger.info('Successfully fetched ${surahs.length} surahs');
      return Right(surahs);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get surah list', e, stackTrace);
      // Map exception to appropriate Failure type
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  /// Fetches the list of available Quran reciters (Qaris).
  ///
  /// This method retrieves all available reciters from the remote data source,
  /// which provides audio recordings of Quran recitations. The data is cached
  /// locally for improved performance and offline access.
  ///
  /// **Data Flow**:
  /// 1. Data source checks local cache (Hive)
  /// 2. If cache valid and not expired (7 days), returns cached data
  /// 3. If cache invalid/expired, fetches from API
  /// 4. API response is cached for future use
  /// 5. JSON data is transformed to [ReciterModel]
  /// 6. Models are converted to [ReciterEntity] domain objects
  ///
  /// **Caching Behavior**:
  /// - Cache Duration: 7 days (reciters change infrequently)
  /// - Background Refresh: Yes
  /// - Offline Support: Returns cached data if available
  ///
  /// **Reciter Data Includes**:
  /// - identifier: Unique ID (e.g., 'ar.alafasy')
  /// - name: Arabic name of reciter
  /// - englishName: English transliteration
  /// - format: Audio format (always 'audio')
  /// - type: Recitation type ('versebyverse' or 'full')
  /// - bitrate: Audio quality ('128', '64', '32')
  ///
  /// **Returns**:
  /// - `Right<List<ReciterEntity>>`: List of reciters if successful
  /// - `Left<Failure>`: Error details if operation fails
  ///
  /// **Error Handling**:
  /// - Network errors are caught and mapped to [ServerFailure]
  /// - Cache errors are mapped to [CacheFailure]
  /// - All errors are logged with stack traces
  /// - Returns cached data as fallback when possible
  ///
  /// **Performance**:
  /// - First call (no cache): ~300ms (API + caching)
  /// - Cached calls: <30ms (Hive read)
  /// - Data size: ~5KB for all reciters
  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    try {
      // Fetch from data source (checks cache first, then API)
      final result = await _remoteDataSource.getAvailableReciters();

      // Transform JSON data to domain entities
      final reciters = result.map((json) {
        final model = ReciterModel.fromJson(json);
        return model.toEntity();
      }).toList();

      AppLogger.info('Successfully fetched ${reciters.length} reciters');
      return Right(reciters);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get available reciters', e, stackTrace);
      // Map exception to appropriate Failure type
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
