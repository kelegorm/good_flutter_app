/// Persistent storage for user preferences (locale, theme, etc.).
abstract interface class AppPreferences {
  Future<String?> readLocale();
  Future<void> writeLocale(String locale);
}
