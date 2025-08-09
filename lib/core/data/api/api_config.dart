import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:split_calculator/app/app.dart';

final class ApiConfig {
  ApiConfig._(this.env, this.baseUrl);

  factory ApiConfig(AppEnv env) {
    final v = dotenv.maybeGet('BASE_URL');
    if (v == null || v.isEmpty) {
      throw StateError(
        'ENV BASE_URL is missing. '
        'Make sure you loaded the correct .env file for $env '
        'and that BASE_URL is set.',
      );
    }
    return ApiConfig._(env, v);
  }

  final String baseUrl;
  final AppEnv env;
}

abstract class ApiEndpoints {
  static const String users = "/users";
  static String userProfileById(String id) => "/users/$id/profile";
}
