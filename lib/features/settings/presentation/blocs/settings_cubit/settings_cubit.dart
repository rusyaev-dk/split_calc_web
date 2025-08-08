import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/utils/utils.dart';
import 'package:flutter_app_template/features/settings/data/data.dart';

part 'settings_state.dart';

enum AppTheme { dark, light }

AppTheme appThemeFromString(String name) {
  switch (name.toLowerCase().trim()) {
    case 'dark':
      return AppTheme.dark;
    case 'light':
      return AppTheme.light;
    default:
      return AppTheme.light;
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required ISettingsRepository settingsRepository,
    required ILogger logger,
  }) : _settingsRepository = settingsRepository,
       _logger = logger,
       super(
         const SettingsState(
           locale: Locale(AppConfig.defaultLanguageCode),
           theme: AppTheme.light,
         ),
       ) {
    _restoreLocale();
    _restoreTheme();
  }

  final ISettingsRepository _settingsRepository;
  final ILogger _logger;

  Future<void> changeLocale(Locale newLocale) async {
    try {
      final prevState = state;
      final bool success = await _settingsRepository.changeLocale(
        newLocale.languageCode,
      );

      if (!success) {
        _logger.warning("Couldn't update app locale...");
      }

      if (state.locale != newLocale) {
        emit(SettingsState(locale: newLocale, theme: prevState.theme));
      }
    } catch (exception, stackTrace) {
      _logger.exception(exception, stackTrace);
    }
  }

  Future<void> _restoreLocale() async {
    try {
      final prevState = state;
      final restoredLocale = Locale(
        await _settingsRepository.getCurrentLocale(),
      );

      if (state.locale != restoredLocale) {
        emit(SettingsState(locale: restoredLocale, theme: prevState.theme));
      }
    } catch (exception, stackTrace) {
      _logger.exception(exception, stackTrace);
    }
  }

  Future<void> swithTheme() async {
    try {
      final prevState = state;
      final newTheme = prevState.theme == AppTheme.light
          ? AppTheme.dark
          : AppTheme.light;
      final bool success = await _settingsRepository.changeTheme(newTheme);

      if (!success) {
        _logger.warning("Couldn't update app locale...");
      }

      if (state.theme != newTheme) {
        emit(SettingsState(locale: prevState.locale, theme: newTheme));
      }
    } catch (exception, stackTrace) {
      _logger.exception(exception, stackTrace);
    }
  }

  Future<void> _restoreTheme() async {
    try {
      final prevState = state;
      final restoredTheme = await _settingsRepository.getCurrentTheme();

      if (state.theme != restoredTheme) {
        emit(SettingsState(locale: prevState.locale, theme: restoredTheme));
      }
    } catch (exception, stackTrace) {
      _logger.exception(exception, stackTrace);
    }
  }
}
