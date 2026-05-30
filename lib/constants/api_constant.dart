/// API endpoint constants
class ApiConstant {
  ApiConstant._();

  // Auth endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // AlQuran API Base URL
  static const String alquranBaseUrl = 'https://api.alquran.cloud/v1';

  // Quran endpoints
  static const String getSurahList = '/surah';
  static const String getSurah = '/surah/{surah}/{edition}';
  static const String getAyah = '/ayah/{reference}/{edition}';
  static const String searchQuran = '/search/{keyword}/{surah}/{edition}';
  static const String getAudioEditions = '/edition/format/audio';
  static const String getJuz = '/juz/{juz}/{edition}';
  static const String getPage = '/page/{page}/{edition}';

  // Popular reciters (qaris) for audio
  static const String reciterAlafasy = 'ar.alafasy';
  static const String reciterSudais = 'ar.abdurrahmaansudais';
  static const String reciterHusary = 'ar.husary';
  static const String reciterMinshawi = 'ar.minshawi';
  static const String reciterAbdulbasit = 'ar.abdulsamad';
}
