import 'package:good_example/domain/storage/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores user preferences using platform SharedPreferences.
class SharedAppPreferences implements AppPreferences {
  static const _localeKey = 'locale';

  @override
  Future<String?> readLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }

  @override
  Future<void> writeLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale);
  }
}
