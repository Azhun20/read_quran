/// Hive box and key constants
class HiveConstant {
  HiveConstant._();

  // Box names
  static const String authBox = 'auth_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';

  // Auth Keys
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user';

  // Cache Keys
  static const String surahListKey = 'surah_list';
  static const String surahListTimestampKey = 'surah_list_timestamp';
  static const String recitersKey = 'reciters';
  static const String recitersTimestampKey = 'reciters_timestamp';
}
