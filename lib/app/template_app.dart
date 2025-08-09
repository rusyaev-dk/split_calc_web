import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:split_calculator/app/app.dart';
import 'package:split_calculator/di/di.dart';
import 'package:split_calculator/features/error/error_screen.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';
import 'package:split_calculator/features/splash/splash_screen.dart';
import 'package:split_calculator/l10n/generated/l10n.dart';
import 'package:split_calculator/uikit/themes/app_theme_data.dart';
import 'package:split_calculator/uikit/uikit.dart';

class TemplateApp extends StatefulWidget {
  const TemplateApp({
    required this.router,
    required this.initDependencies,
    super.key,
  });

  final GoRouter router;
  final Future<AppScope> Function() initDependencies;

  @override
  State<TemplateApp> createState() => _TemplateAppState();
}

class _TemplateAppState extends State<TemplateApp> {
  late Future<AppScope> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = widget.initDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppScope>(
      future: _initFuture,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            // Пока инициализация показываем Splash
            return const SplashScreen();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return ErrorScreen(
                error: snapshot.error,
                stackTrace: snapshot.stackTrace,
                onRetry: _retryInit,
              );
            }

            final appScope = snapshot.data;
            if (appScope == null) {
              return ErrorScreen(
                error: 'Error initializing dependencies: diContainer = null',
                stackTrace: null,
                onRetry: _retryInit,
              );
            }
            return AppProvidersWrapper(
              appScope: appScope,
              child: _App(router: widget.router),
            );
        }
      },
    );
  }

  void _retryInit() {
    setState(() {
      _initFuture = widget.initDependencies();
    });
  }
}

class _App extends StatelessWidget {
  const _App({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru'), Locale('uz')],
          locale: state.locale,
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: themeModeFromSettings(state.theme),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}

ThemeMode themeModeFromSettings(AppTheme theme) {
  return theme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;
}
