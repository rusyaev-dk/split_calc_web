import 'package:flutter/material.dart';
import 'package:flutter_app_template/uikit/uikit.dart';

abstract class AppThemeData {
  static const _lightColorScheme = AppColorScheme.light();
  static const _darkColorScheme = AppColorScheme.dark();
  static final _textScheme = AppTextScheme.base();

  static ThemeData get lightTheme => _buildTheme(
    brightness: Brightness.light,
    colors: _lightColorScheme,
    text: _textScheme,
  );

  static ThemeData get darkTheme => _buildTheme(
    brightness: Brightness.dark,
    colors: _darkColorScheme,
    text: _textScheme,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorScheme colors,
    required AppTextScheme text,
  }) {
    final cs = ColorScheme(
      brightness: brightness,
      // базовые тона
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      secondaryContainer: colors.secondaryContainer,
      onSecondaryContainer: colors.onSecondaryContainer,
      tertiary: colors.tertiary,
      onTertiary: colors.onTertiary,
      tertiaryContainer: colors.tertiaryContainer,
      onTertiaryContainer: colors.onTertiaryContainer,
      error: colors.error,
      onError: colors.onError,
      errorContainer: colors.errorContainer,
      onErrorContainer: colors.onErrorContainer,
      // поверхности
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerHighest: colors.surfaceContainer, // ближний «контейнер»
      onSurfaceVariant: colors.onSurfaceVariant,
      // обводки/эффекты
      outline: colors.outline,
      outlineVariant: colors.outlineVariant,
      shadow: colors.shadow,
      scrim: colors.scrim,
      // инверсии
      inverseSurface: colors.inverseSurface,
      onInverseSurface: colors.onInverseSurface,
      inversePrimary: colors.inversePrimary,
      surfaceTint: colors.surfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: cs,
      // подключаем расширения (чтобы их было видно из Theme.of(context).extension<...>())
      extensions: <ThemeExtension<dynamic>>[colors, text],

      // фон
      scaffoldBackgroundColor: colors.surface,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        elevation: 0,
        foregroundColor: colors.onSurface,
        centerTitle: true,
        titleTextStyle: text.headline.copyWith(
          color: colors.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        surfaceTintColor: Colors.transparent,
      ),

      // Карточки (плоские, читабельные)
      cardTheme: CardThemeData(
        color: colors.sectionBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),

      // Поля ввода
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? colors.surfaceContainerLow
            : colors.surfaceContainer,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        hintStyle: TextStyle(color: colors.onSurfaceVariant.withOpacity(.8)),
      ),

      // Кнопки
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colors.primary),
          foregroundColor: WidgetStateProperty.all(colors.onPrimary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(colors.primary),
        ),
      ),

      // Чипы
      chipTheme: ChipThemeData(
        backgroundColor: brightness == Brightness.light
            ? colors.surfaceContainerLow
            : colors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.outlineVariant),
        ),
        labelStyle: TextStyle(color: colors.onSurface),
        deleteIconColor: colors.onSurfaceVariant,
        iconTheme: IconThemeData(color: colors.onSurfaceVariant),
      ),

      // Divider / ListTile
      dividerTheme: DividerThemeData(color: colors.outlineVariant),
      listTileTheme: ListTileThemeData(
        iconColor: colors.onSurfaceVariant,
        textColor: colors.onSurface,
        tileColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
      ),

      // SnackBar / Dialog
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.primary,
        contentTextStyle: TextStyle(color: colors.onPrimary),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.headline.copyWith(
          fontSize: 22,
          color: colors.onSurface,
        ),
        contentTextStyle: text.label.copyWith(
          fontSize: 18,
          color: colors.onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),

      // Текст (базовые веса/размеры для читаемости)
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colors.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.3,
          color: colors.onSurface,
        ),
      ),
    );
  }
}
