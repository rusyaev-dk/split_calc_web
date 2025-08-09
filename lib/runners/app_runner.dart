import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/data/data.dart';
import 'package:flutter_app_template/core/navigation/router.dart';
import 'package:flutter_app_template/core/utils/utils.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/error/error_screen.dart';
import 'package:flutter_app_template/runners/runners.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'errors_handlers.dart';

/// Время ожидания инициализации зависимостей
/// Если время превышено, то будет показан экран ошибки
/// В дальнейшем нужно убрать в env
const _initTimeout = Duration(seconds: 7);

/// Класс, реализующий раннер для конфигурирования приложения при запуске
///
/// Порядок инициализации:
/// 1. _initApp - инициализация конфигурации приложения
/// 2. инициализация репозиториев приложения (будет позже)
/// 3. runApp - запуск приложения
/// 4. _onAppLoaded - после запуска приложения
class AppRunner {
  AppRunner(this.env);

  final AppEnv env;
  late GoRouter router;
  late TimerRunner _timerRunner;

  Future<void> run() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      final talker = TalkerFlutter.init();
      final ILogger logger = AppLogger(talker: talker);

      _timerRunner = TimerRunner(logger: logger);

      Bloc.observer = TalkerBlocObserver(talker: talker);

      await _initApp();
      _initErrorHandlers(logger);

      router = AppRouter.createRouter(
        includePrefixMatches: true,
        navigatorObservers: [TalkerRouteObserver(talker)],
      );

      runApp(
        TemplateApp(
          router: router,
          initDependencies: () {
            return _initDependencies(
              logger: logger,
              talker: talker,
              env: env,
              timerRunner: _timerRunner,
            ).timeout(
              _initTimeout,
              onTimeout: () {
                return Future.error(
                  TimeoutException(
                    'Dependency initialization timeout exceeded',
                  ),
                );
              },
            );
          },
        ),
      );
      await _onAppLoaded();
    } on Object catch (e, stackTrace) {
      await _onAppLoaded();

      /// Если произошла ошибка при инициализации приложения,
      /// то запускаем экран ошибки
      runApp(ErrorScreen(error: e, stackTrace: stackTrace, onRetry: run));
    }
  }

  /// Метод инициализации приложения,
  /// выполняется до запуска приложения
  Future<void> _initApp() async {
    // Запрет на поворот экрана
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Заморозка первого кадра (сплеш)
    WidgetsBinding.instance.deferFirstFrame();
  }

  /// Метод срабатывает после запуска приложения
  Future<void> _onAppLoaded() async {
    // Разморозка первого кадра (splash)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.allowFirstFrame();
    });
  }

  Future<AppScope> _initDependencies({
    required ILogger logger,
    required Talker talker,
    required AppEnv env,
    required TimerRunner timerRunner,
  }) async {
    // TODO: remove the delay
    await Future.delayed(Duration(milliseconds: 1500));
    logger.log('Build type: ${env.name}');

    final file = _fileFor(env);
    try {
      await dotenv.load(fileName: file);
      logger.log('dotenv loaded: $file');
    } catch (e) {
      logger.warning('dotenv not loaded, will use defaults: $e');
    }
    final apiConfig = ApiConfig(env);

    final dio = Dio();

    if (env == AppEnv.dev || env == AppEnv.stage) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    final sharedPrefs = await SharedPreferences.getInstance();
    final flutterSecureStorage = FlutterSecureStorage();

    final secureStorage = SecureStorage(secureStorage: flutterSecureStorage);
    final sharedPrefsStorage = SharedPrefsStorage(
      sharedPreferences: sharedPrefs,
    );
    final storageAggregator = StorageAggregator(
      secureStorage: secureStorage,
      sharedPrefsStorage: sharedPrefsStorage,
    );

    final httpClient = DioHttpClient(dio: dio, apiConfig: apiConfig);
    final authTokenProvider = AuthTokenProvider(
      httpClient: httpClient,
      tokenStorage: storageAggregator.secureStorage,
    );

    dio.interceptors.add(
      JwtRefreshInterceptor(authTokenProvider: authTokenProvider),
    );

    return AppScope(
      env: env,
      appConfig: AppConfig(),
      apiConfig: apiConfig,
      sharedPreferences: sharedPrefs,
      flutterSecureStorage: flutterSecureStorage,
      storageAggregator: storageAggregator,
      talker: talker,
      dio: dio,
      logger: logger,
    );
  }
}

String _fileFor(AppEnv env) => switch (env) {
  AppEnv.dev => 'env/dev.env',
  AppEnv.stage => 'env/stage.env',
  AppEnv.prod => 'env/prod.env',
};
