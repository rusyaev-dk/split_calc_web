part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({required this.locale, required this.theme});

  final Locale locale;
  final AppTheme theme;

  SettingsState copyWith({Locale? locale, AppTheme? theme}) {
    return SettingsState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object> get props => [locale, theme];
}
