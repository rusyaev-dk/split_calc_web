part of 'app_runner.dart';

void _initErrorHandlers(ILogger logger) {
  // Обработка ошибок в приложении
  FlutterError.onError = (details) {
    _showErrorScreen(details.exception, details.stack);
    logger.error(
      'FlutterError.onError: ${details.exceptionAsString()} ${details.exception}',
      details.stack,
    );
  };
  // Обработка асинхронных ошибок в приложении
  PlatformDispatcher.instance.onError = (error, stack) {
    _showErrorScreen(error, stack);
    logger.error('PlatformDispatcher.instance.onError $error', stack);
    return true;
  };
}

/// Метод для показа экрана ошибки
void _showErrorScreen(Object error, StackTrace? stackTrace) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AppRouter.rootNavigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ErrorScreen(error: error, stackTrace: stackTrace),
      ),
    );
  });
}
