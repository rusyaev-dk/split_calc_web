import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme._({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.surface,
    required this.onSurface,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    required this.shimmer,
    required this.activatedFilterButtonColor,
    required this.inActivatedFilterButtonColor,
    required this.activatedThemeButtonColor,
    required this.inActivatedThemeButtonColor,
    required this.sectionBackgroundColor,
    required this.settingsBackgroundColor,
    required this.approval,
  });

  const AppColorScheme.light()
    : primary = const Color(0xFF6750A4),
      onPrimary = const Color(0xFFFFFFFF),
      primaryContainer = const Color(0xFFEADDFF),
      onPrimaryContainer = const Color(0xFF21005D),
      secondary = const Color(0xFF625B71),
      onSecondary = const Color(0xFFFFFFFF),
      secondaryContainer = const Color(0xFFE8DEF8),
      onSecondaryContainer = const Color(0xFF1D192B),
      tertiary = const Color(0xFF7D5260),
      onTertiary = const Color(0xFFFFFFFF),
      tertiaryContainer = const Color(0xFFFFD8E4),
      onTertiaryContainer = const Color(0xFF31111D),
      error = const Color(0xFFB3261E),
      onError = const Color(0xFFFFFFFF),
      errorContainer = const Color(0xFFF9DEDC),
      onErrorContainer = const Color(0xFF410E0B),
      surface = const Color(0xFFFFFBFE),
      onSurface = const Color(0xFF1C1B1F),
      surfaceDim = const Color(0xFFE6E0EC),
      surfaceBright = const Color(0xFFFFFBFE),
      surfaceContainerLowest = const Color(0xFFFFFFFF),
      surfaceContainerLow = const Color(0xFFF7F2FA),
      surfaceContainer = const Color(0xFFF3EDF7),
      surfaceContainerHigh = const Color(0xFFECE6F0),
      surfaceContainerHighest = const Color(0xFFE6E0EC),
      onSurfaceVariant = const Color(0xFF49454F),
      outline = const Color(0xFF79747E),
      outlineVariant = const Color(0xFFCAC4D0),
      shadow = const Color(0xFF000000),
      scrim = const Color(0xFF000000),
      inverseSurface = const Color(0xFF313033),
      onInverseSurface = const Color(0xFFF4EFF4),
      inversePrimary = const Color(0xFFD0BCFF),
      surfaceTint = const Color(0xFF6750A4),
      shimmer = const Color(0xFFDAD2E8),
      activatedFilterButtonColor = const Color(0xFFB39DDB),
      inActivatedFilterButtonColor = const Color(0xFFE8DEF8),
      activatedThemeButtonColor = const Color(0xFFFFFFFF),
      inActivatedThemeButtonColor = const Color(0xFFDAD2E8),
      sectionBackgroundColor = const Color(0xFFFFFFFF),
      settingsBackgroundColor = const Color(0xFFF7F2FA),
      approval = const Color(0xFF4CAF50);

  const AppColorScheme.dark()
    : primary = const Color(0xFFD0BCFF),
      onPrimary = const Color(0xFF381E72),
      primaryContainer = const Color(0xFF4F378B),
      onPrimaryContainer = const Color(0xFFEADDFF),
      secondary = const Color(0xFFCCC2DC),
      onSecondary = const Color(0xFF332D41),
      secondaryContainer = const Color(0xFF4A4458),
      onSecondaryContainer = const Color(0xFFE8DEF8),
      tertiary = const Color(0xFFEFB8C8),
      onTertiary = const Color(0xFF492532),
      tertiaryContainer = const Color(0xFF633B48),
      onTertiaryContainer = const Color(0xFFFFD8E4),
      error = const Color(0xFFF2B8B5),
      onError = const Color(0xFF601410),
      errorContainer = const Color(0xFF8C1D18),
      onErrorContainer = const Color(0xFFF9DEDC),
      surface = const Color(0xFF1C1B1F),
      onSurface = const Color(0xFFE6E0E9),
      surfaceDim = const Color(0xFF141218),
      surfaceBright = const Color(0xFF3B383E),
      surfaceContainerLowest = const Color(0xFF0F0D13),
      surfaceContainerLow = const Color(0xFF1D1B20),
      surfaceContainer = const Color(0xFF211F26),
      surfaceContainerHigh = const Color(0xFF2B2930),
      surfaceContainerHighest = const Color(0xFF36343B),
      onSurfaceVariant = const Color(0xFFCAC4D0),
      outline = const Color(0xFF938F99),
      outlineVariant = const Color(0xFF49454F),
      shadow = const Color(0xFF000000),
      scrim = const Color(0xFF000000),
      inverseSurface = const Color(0xFFE6E0E9),
      onInverseSurface = const Color(0xFF313033),
      inversePrimary = const Color(0xFF6750A4),
      surfaceTint = const Color(0xFFD0BCFF),
      shimmer = const Color(0xFF49454F),
      activatedFilterButtonColor = const Color(0xFFD0BCFF),
      inActivatedFilterButtonColor = const Color(0xFF2B2930),
      activatedThemeButtonColor = const Color(0xFF4F378B),
      inActivatedThemeButtonColor = const Color(0xFF49454F),
      sectionBackgroundColor = const Color(0xFF1D1B20),
      settingsBackgroundColor = const Color(0xFF211F26),
      approval = const Color(0xFF4CAF50);

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color surface;
  final Color onSurface;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color surfaceTint;
  final Color shimmer;
  final Color activatedFilterButtonColor;
  final Color inActivatedFilterButtonColor;
  final Color activatedThemeButtonColor;
  final Color inActivatedThemeButtonColor;
  final Color sectionBackgroundColor;
  final Color settingsBackgroundColor;
  final Color approval;

  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? shimmer,
    Color? activatedFilterButtonColor,
    Color? inActivatedFilterButtonColor,
    Color? activatedThemeButtonColor,
    Color? inActivatedThemeButtonColor,
    Color? sectionBackgroundColor,
    Color? settingsBackgroundColor,
    Color? approval,
  }) {
    return AppColorScheme._(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      shimmer: shimmer ?? this.shimmer,
      activatedFilterButtonColor:
          activatedFilterButtonColor ?? this.activatedFilterButtonColor,
      inActivatedFilterButtonColor:
          inActivatedFilterButtonColor ?? this.inActivatedFilterButtonColor,
      activatedThemeButtonColor:
          activatedThemeButtonColor ?? this.activatedThemeButtonColor,
      inActivatedThemeButtonColor:
          inActivatedThemeButtonColor ?? this.inActivatedThemeButtonColor,
      sectionBackgroundColor:
          sectionBackgroundColor ?? this.sectionBackgroundColor,
      settingsBackgroundColor:
          settingsBackgroundColor ?? this.settingsBackgroundColor,
      approval: approval ?? this.approval,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    return AppColorScheme._(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      onSecondaryContainer: Color.lerp(
        onSecondaryContainer,
        other.onSecondaryContainer,
        t,
      )!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      onTertiaryContainer: Color.lerp(
        onTertiaryContainer,
        other.onTertiaryContainer,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(
        onErrorContainer,
        other.onErrorContainer,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceDim: Color.lerp(surfaceDim, other.surfaceDim, t)!,
      surfaceBright: Color.lerp(surfaceBright, other.surfaceBright, t)!,
      surfaceContainerLowest: Color.lerp(
        surfaceContainerLowest,
        other.surfaceContainerLowest,
        t,
      )!,
      surfaceContainerLow: Color.lerp(
        surfaceContainerLow,
        other.surfaceContainerLow,
        t,
      )!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      surfaceContainerHigh: Color.lerp(
        surfaceContainerHigh,
        other.surfaceContainerHigh,
        t,
      )!,
      surfaceContainerHighest: Color.lerp(
        surfaceContainerHighest,
        other.surfaceContainerHighest,
        t,
      )!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface: Color.lerp(
        onInverseSurface,
        other.onInverseSurface,
        t,
      )!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      shimmer: Color.lerp(shimmer, other.shimmer, t)!,
      activatedFilterButtonColor: Color.lerp(
        activatedFilterButtonColor,
        other.activatedFilterButtonColor,
        t,
      )!,
      inActivatedFilterButtonColor: Color.lerp(
        inActivatedFilterButtonColor,
        other.inActivatedFilterButtonColor,
        t,
      )!,
      activatedThemeButtonColor: Color.lerp(
        activatedThemeButtonColor,
        other.activatedThemeButtonColor,
        t,
      )!,
      inActivatedThemeButtonColor: Color.lerp(
        inActivatedThemeButtonColor,
        other.inActivatedThemeButtonColor,
        t,
      )!,
      sectionBackgroundColor: Color.lerp(
        sectionBackgroundColor,
        other.sectionBackgroundColor,
        t,
      )!,
      settingsBackgroundColor: Color.lerp(
        settingsBackgroundColor,
        other.settingsBackgroundColor,
        t,
      )!,
      approval: Color.lerp(approval, other.approval, t)!,
    );
  }

  static AppColorScheme of(BuildContext context) =>
      Theme.of(context).extension<AppColorScheme>() ??
      _throwThemeExceptionFromFunc(context);
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppColorScheme not found in $context');
