import 'package:shared_preferences/shared_preferences.dart';
import 'package:teraflex_mobile/config/theme/bloc/app_theme/app_theme_cubit.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> setTheme(ThemeState theme) async {
    final prefs = await SharedPreferencesService.prefs;
    await prefs.setInt('theme', theme.index);
  }

  static Future<ThemeState> getTheme() async {
    final prefs = await SharedPreferencesService.prefs;
    final themeIndex = prefs.getInt('theme') ?? 0;
    return ThemeState.values[themeIndex];
  }
}
