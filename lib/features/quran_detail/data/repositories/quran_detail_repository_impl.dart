import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_detail/data/datasources/quran_detail_remote_datasource.dart';
import 'package:read_quran/features/quran_detail/data/models/surah_detail_model.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';

/// Concrete implementation of [QuranDetailRepository] interface.
///
/// This repository implements the data layer logic for fetching complete surah
/// details including all verses (ayahs) with their Arabic text, translations,
/// and audio recitation URLs. It acts as a mediator between the domain layer
/// and the remote data source.
///
/// **Architecture Layer**: Data Layer
/// - Implements domain repository interface
/// - Coordinates between data sources
/// - Transforms data models to domain entities
/// - Handles error mapping and exception handling
///
/// **Responsibilities**:
/// 1. Fetch complete surah details with all ayahs
/// 2. Combine text and audio data from multiple API endpoints
/// 3. Transform JSON/Model data to domain entities
/// 4. Handle errors and map exceptions to domain failures
/// 5. Log operations for debugging and monitoring
///
/// **Data Source Used**:
/// - [QuranDetailRemoteDataSource]: Coordinates multi-source data fetching
///   - Fetches surah metadata and text from al-quran.cloud
///   - Fetches audio URLs for selected reciter
///   - Combines data into unified response
///
/// **Data Aggregation**:
/// The repository handles complex data aggregation:
/// 1. **Surah Metadata**: Name, revelation type, verse count
/// 2. **Ayah Text**: Arabic text for all verses in the surah
/// 3. **Audio URLs**: Recitation audio for each ayah by selected reciter
/// 4. **Reference Data**: Juz, manzil, page numbers, sajda indicators
///
/// **Error Handling Strategy**:
/// - Catches all exceptions from data source
/// - Maps exceptions to appropriate [Failure] types:
///   - Network errors → [ServerFailure]
///   - API errors → [ServerFailure]
///   - Parsing errors → [UnexpectedFailure]
/// - Logs errors with stack traces for debugging
/// - Returns user-friendly error messages
///
/// **Data Flow**:
/// ```
/// Use Case
///   ↓
/// Repository (this class)
///   ↓
/// Remote Data Source
///   ├→ API 1: Fetch surah text (/surah/{number})
///   ├→ API 2: Fetch audio URLs (/surah/{number}/{reciter})
///   └→ Combine responses
///   ↓
/// Model → Entity Transformation
///   ↓
/// Either<Failure, SurahDetailEntity> returned to Use Case
/// ```
class QuranDetailRepositoryImpl implements QuranDetailRepository {
  /// Creates a new instance of [QuranDetailRepositoryImpl].
  ///
  /// Requires a [QuranDetailRemoteDataSource] to fetch surah details.
  QuranDetailRepositoryImpl(this._remoteDataSource);

  /// Remote data source for fetching complete surah details.
  ///
  /// This data source handles:
  /// - Multi-endpoint API coordination
  /// - Data aggregation from text and audio sources
  /// - HTTP error handling
  /// - Response validation
  final QuranDetailRemoteDataSource _remoteDataSource;

  /// Fetches complete details for a specific surah including all verses and audio.
  ///
  /// This method retrieves comprehensive surah information including metadata,
  /// all ayah texts, and audio recitation URLs for the selected reciter. It
  /// coordinates multiple API calls and combines the data into a single unified
  /// response.
  ///
  /// **Parameters**:
  /// - [surahNumber]: The surah number to fetch (1-114)
  ///   - 1-114: Valid surah numbers
  ///   - Invalid numbers will result in API error
  /// - [reciterIdentifier]: The reciter's identifier for audio (e.g., 'ar.alafasy')
  ///   - Determines which recitation audio URLs are fetched
  ///   - Must match a valid reciter from /reciters endpoint
  ///
  /// **Data Fetching Process**:
  /// The data source performs coordinated fetching:
  /// 1. **Surah Text API Call**: GET /surah/{surahNumber}
  ///    - Fetches surah metadata (name, revelation type, verse count)
  ///    - Retrieves all ayah texts in Arabic
  ///    - Gets reference data (juz, manzil, page, sajda)
  ///
  /// 2. **Audio API Call**: GET /surah/{surahNumber}/{reciterIdentifier}
  ///    - Fetches audio URLs for each ayah
  ///    - Returns streaming audio file URLs
  ///    - Quality based on reciter's bitrate setting
  ///
  /// 3. **Data Combination**:
  ///    - Merges text and audio data by ayah number
  ///    - Creates unified ayah objects with text + audio
  ///    - Preserves all metadata and reference information
  ///
  /// **Returns**:
  /// - `Right<SurahDetailEntity>`: Complete surah details if successful
  ///   - Surah metadata: names, revelation type, verse count
  ///   - List of ayahs: Each containing text, audio URL, and metadata
  ///   - Reference data: Juz, manzil, page numbers, sajda indicators
  /// - `Left<Failure>`: Error details if operation fails
  ///   - [ServerFailure]: Network or API errors
  ///   - [UnexpectedFailure]: Data parsing or unexpected errors
  ///
  /// **Error Handling**:
  /// - Network failures: Mapped to appropriate Failure type
  /// - API errors: HTTP error codes converted to failures
  /// - Parsing errors: Invalid JSON handled gracefully
  /// - All errors logged with stack traces for debugging
  /// - Uses [mapExceptionToFailure] for consistent error mapping
  ///
  /// **Performance**:
  /// - Two sequential API calls: ~500-800ms total
  /// - Data size: ~30-100KB depending on surah length
  /// - No caching: Each call fetches fresh data
  /// - Long surahs (e.g., Al-Baqarah): May take longer
  ///
  /// **Data Structure Returned**:
  /// ```dart
  /// SurahDetailEntity {
  ///   number: 2,
  ///   name: "سُورَةُ البَقَرَةِ",
  ///   englishName: "Al-Baqara",
  ///   numberOfAyahs: 286,
  ///   revelationType: "Medinan",
  ///   ayahs: [
  ///     AyahEntity {
  ///       number: 1,
  ///       text: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
  ///       audio: "https://cdn.alquran.cloud/media/audio/...",
  ///       numberInSurah: 1,
  ///       juz: 1,
  ///     },
  ///     // ... more ayahs
  ///   ]
  /// }
  /// ```
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Fetch Al-Fatiha (Surah 1) with Alafasy recitation
  /// final result = await repository.getSurahDetail(
  ///   surahNumber: 1,
  ///   reciterIdentifier: 'ar.alafasy',
  /// );
  ///
  /// result.fold(
  ///   (failure) => print('Error: ${failure.message}'),
  ///   (surahDetail) {
  ///     print('${surahDetail.englishName}: ${surahDetail.numberOfAyahs} verses');
  ///     for (final ayah in surahDetail.ayahs ?? []) {
  ///       print('Ayah ${ayah.numberInSurah}: ${ayah.audio}');
  ///     }
  ///   },
  /// );
  /// ```
  @override
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    try {
      final result = await _remoteDataSource.getSurahDetail(
        surahNumber: surahNumber,
        reciterIdentifier: reciterIdentifier,
      );

      final model = SurahDetailModel.fromJson(result);
      final entity = model.toEntity();

      AppLogger.info(
        'Successfully fetched surah $surahNumber with ${entity.ayahs?.length ?? 0} ayahs',
      );

      return Right(entity);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get surah detail', e, stackTrace);
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}

