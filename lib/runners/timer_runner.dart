import 'package:split_calculator/core/utils/utils.dart';

/// {@template TimerRunner}
/// Класс для подсчета времени запуска приложения
/// {@endtemplate}
class TimerRunner {
  /// {@macro TimerRunner}
  TimerRunner({required ILogger logger}) : _logger = logger {
    _stopwatch.start();
  }

  final ILogger _logger;

  /// Секундомер для подсчета времени инициализации
  final _stopwatch = Stopwatch();

  /// Метод для остановки секундомера и вывода времени
  /// полной инициализации приложения
  void stop() {
    _stopwatch.stop();
    _logger.log(
      'Время инициализации приложения: ${_stopwatch.elapsedMilliseconds} мс',
    );
  }

  /// Метод для обработки прогресса инициализации зависимостей
  void logOnProgress(String name) {
    _logger.log(
      '$name успешная инициализация, прогресс: ${_stopwatch.elapsedMilliseconds} мс',
    );
  }

  /// Метод для обработки прогресса инициализации зависимостей
  void logOnComplete(String message) {
    _logger.log('$message, прогресс: ${_stopwatch.elapsedMilliseconds} мс');
  }

  /// Метод для обработки прогресса инициализации зависимостей
  void logOnError(String message, Object error, [StackTrace? stackTrace]) {
    _logger.error(error, stackTrace);
  }
}
