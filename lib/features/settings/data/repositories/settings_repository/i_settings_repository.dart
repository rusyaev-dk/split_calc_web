import 'package:split_calculator/features/settings/presentation/presentation.dart';

abstract interface class ISettingsRepository {
  Future<bool> changeLocale(String newLocale);
  Future<String> getCurrentLocale();

  Future<bool> changeTheme(AppTheme newTheme);
  Future<AppTheme> getCurrentTheme();
}
