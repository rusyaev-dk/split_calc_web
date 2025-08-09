import 'package:split_calculator/app/app.dart';
import 'package:split_calculator/core/data/storage/storage.dart';
import 'package:split_calculator/features/settings/data/data.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';

class SettingsRepository implements ISettingsRepository {
  SettingsRepository({required IKeyValueStorage storage}) : _storage = storage;

  final IKeyValueStorage _storage;
  final String _localeKey = "locale";
  final String _themeKey = "theme";

  @override
  Future<bool> changeLocale(String newLocale) async {
    return await _storage.save(key: _localeKey, value: newLocale);
  }

  @override
  Future<String> getCurrentLocale() async {
    return await _storage.get(key: _localeKey) ?? AppConfig.defaultLanguageCode;
  }

  @override
  Future<bool> changeTheme(AppTheme newTheme) async {
    return await _storage.save(key: _themeKey, value: newTheme.toString());
  }

  @override
  Future<AppTheme> getCurrentTheme() async {
    return appThemeFromString(
      await _storage.get<String>(key: _localeKey) ?? "",
    );
  }
}
