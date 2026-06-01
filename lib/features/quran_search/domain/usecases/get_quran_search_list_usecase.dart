import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

/// Use case for searching Quran verses by keyword.
///
/// This use case implements the business logic for searching through the Quran
/// text to find verses (ayahs) that contain specific keywords. It supports
/// searching across all surahs or filtering by a specific surah number.
///
/// **Architecture Pattern**: Clean Architecture Use Case
/// - Encapsulates a single business operation
/// - Depends only on domain layer (repository interface)
/// - Returns domain entities wrapped in Either for error handling
///
/// **Usage Example**:
/// ```dart
/// final useCase = SearchQuranUseCase(repository);
/// final result = await useCase(
///   keyword: 'Allah',
///   surahNumber: 1, // Optional: search only in Al-Fatihah
///   edition: 'quran-simple',
/// );
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (ayahs) => print('Found ${ayahs.length} results'),
/// );
/// ```
class SearchQuranUseCase {
  /// Creates a new instance of [SearchQuranUseCase].
  ///
  /// Requires a [QuranSearchRepository] implementation to perform the search operation.
  SearchQuranUseCase(this._repository);

  /// Repository interface for accessing Quran search data.
  final QuranSearchRepository _repository;

  /// Searches for Quran verses containing the specified keyword.
  ///
  /// This method performs a full-text search across the Quran text and returns
  /// all matching verses (ayahs). The search can be optionally filtered by surah
  /// number and edition.
  ///
  /// **Parameters**:
  /// - [keyword]: The search term to look for in Quran verses (required).
  ///   Should not be empty. Case-insensitive search is performed.
  /// - [surahNumber]: Optional surah number (1-114) to limit search scope.
  ///   If null, searches across all surahs.
  /// - [edition]: Optional Quran edition identifier (e.g., 'quran-simple').
  ///   Determines which text edition to search in.
  ///
  /// **Returns**:
  /// - `Right<List<AyahEntity>>`: List of matching ayahs if search succeeds.
  ///   Returns empty list if no matches found.
  /// - `Left<Failure>`: Error details if search fails (network error, invalid input, etc).
  ///
  /// **Error Handling**:
  /// - Returns [ServerFailure] for network/API errors
  /// - Returns [CacheFailure] for local storage errors
  /// - Empty keyword should be validated before calling
  ///
  /// **Example**:
  /// ```dart
  /// // Search for 'Rahman' across all surahs
  /// final result = await useCase(keyword: 'Rahman');
  ///
  /// // Search for 'mercy' only in Surah Al-Baqarah (2)
  /// final result = await useCase(
  ///   keyword: 'mercy',
  ///   surahNumber: 2,
  ///   edition: 'en.sahih',
  /// );
  /// ```
  Future<Either<Failure, List<AyahEntity>>> call({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    return await _repository.searchQuran(
      keyword: keyword,
      surahNumber: surahNumber,
      edition: edition,
    );
  }
}
