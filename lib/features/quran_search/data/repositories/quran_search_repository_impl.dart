import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_search/data/datasources/quran_search_remote_datasource.dart';
import 'package:read_quran/features/quran_search/data/models/search_result_model.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

/// Concrete implementation of [QuranSearchRepository] interface.
///
/// This repository implements the data layer logic for searching Quran verses
/// by keywords. It acts as a mediator between the domain layer (use cases) and
/// the remote data source (API).
///
/// **Architecture Layer**: Data Layer
/// - Implements domain repository interface
/// - Delegates API communication to data source
/// - Transforms search result models to domain entities
/// - Handles error mapping and exception handling
///
/// **Responsibilities**:
/// 1. Execute keyword searches across Quran text
/// 2. Support optional filtering by surah number
/// 3. Parse and transform API responses to domain entities
/// 4. Handle errors and map exceptions to domain failures
/// 5. Log search operations for debugging
///
/// **Data Source Used**:
/// - [QuranSearchRemoteDataSource]: Handles HTTP requests to al-quran.cloud search API
///
/// **Search Features**:
/// - Full-text search across all Quran verses
/// - Optional surah-specific filtering
/// - Edition selection (e.g., 'quran-simple', 'en.sahih')
/// - Returns complete ayah information including:
///   - Arabic text
///   - Surah and ayah numbers
///   - Juz and manzil information
///   - Sajda indicators
///
/// **Error Handling Strategy**:
/// - Catches all exceptions from data source
/// - Maps exceptions to [ServerFailure] domain failures
/// - Logs errors with context via [AppLogger]
/// - Returns user-friendly error messages
///
/// **Data Flow**:
/// ```
/// Use Case
///   ↓
/// Repository (this class)
///   ↓
/// Remote Data Source → API Call → Parse Response
///   ↓
/// Model → Entity Transformation
///   ↓
/// Either<Failure, List<AyahEntity>> returned to Use Case
/// ```
class QuranSearchRepositoryImpl implements QuranSearchRepository {
  /// Creates a new instance of [QuranSearchRepositoryImpl].
  ///
  /// Requires a [QuranSearchRemoteDataSource] to perform API searches.
  QuranSearchRepositoryImpl(this._remoteDataSource);

  /// Remote data source for searching Quran verses.
  ///
  /// This data source handles:
  /// - API communication with al-quran.cloud search endpoint
  /// - Query parameter construction and encoding
  /// - HTTP error handling
  final QuranSearchRemoteDataSource _remoteDataSource;

  /// Searches for Quran verses containing the specified keyword.
  ///
  /// This method performs a full-text search across Quran verses, with optional
  /// filtering by surah number and edition selection. It handles the complete
  /// search workflow including API communication, response parsing, and entity
  /// transformation.
  ///
  /// **Parameters**:
  /// - [keyword]: The search term to find in Quran verses (required)
  /// - [surahNumber]: Optional surah filter to limit results (1-114)
  /// - [edition]: Optional Quran edition/translation identifier
  ///   (default: 'quran-simple' for Arabic text)
  ///
  /// **Search Behavior**:
  /// - Searches across complete Quran text (all 6,236 verses)
  /// - Case-insensitive matching
  /// - Partial word matching supported
  /// - Arabic and transliteration search supported
  ///
  /// **Data Flow**:
  /// 1. Data source makes API call to al-quran.cloud search endpoint
  /// 2. API returns JSON response with matching verses
  /// 3. Response data is extracted and validated
  /// 4. JSON is parsed into [SearchResultModel]
  /// 5. Model is transformed to list of [AyahEntity] domain objects
  /// 6. Result count is logged for monitoring
  ///
  /// **Returns**:
  /// - `Right<List<AyahEntity>>`: List of matching verses with complete metadata
  ///   - Each ayah contains: text, surah/ayah numbers, juz, manzil, sajda info
  /// - `Left<Failure>`: Error details if search fails
  ///   - [ServerFailure]: Network errors, API errors, or parsing failures
  ///
  /// **Error Handling**:
  /// - Network failures: Catches and wraps in [ServerFailure]
  /// - API errors: Converts HTTP errors to failure messages
  /// - Parsing errors: Handles malformed JSON responses
  /// - All errors are logged with context for debugging
  ///
  /// **Performance**:
  /// - Typical search: 200-500ms (network dependent)
  /// - Large result sets: May take longer to parse
  /// - No local caching: Each search hits the API
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Search all surahs
  /// final result = await repository.searchQuran(keyword: 'mercy');
  ///
  /// // Search specific surah
  /// final result = await repository.searchQuran(
  ///   keyword: 'believe',
  ///   surahNumber: 2,
  /// );
  ///
  /// // Search with translation
  /// final result = await repository.searchQuran(
  ///   keyword: 'prayer',
  ///   edition: 'en.sahih',
  /// );
  /// ```
  @override
  Future<Either<Failure, List<AyahEntity>>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    try {
      final response = await _remoteDataSource.searchQuran(
        keyword: keyword,
        surahNumber: surahNumber,
        edition: edition,
      );

      // Parse the response data
      final data = response['data'] as Map<String, dynamic>;
      final searchResult = SearchResultModel.fromJson(data);

      // Convert to entities
      final ayahs = searchResult.toEntities();

      AppLogger.info(
        'Search completed: ${ayahs.length} results',
        'QuranSearchRepository',
      );

      return Right(ayahs);
    } catch (e) {
      AppLogger.error(
        'Error in repository: $e',
        e,
        null,
        'QuranSearchRepository',
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
