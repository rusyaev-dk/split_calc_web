import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_calculator/core/data/storage/storage.dart';
import 'package:split_calculator/core/domain/domain.dart';

class SharedPrefsStorage implements IKeyValueStorage {
  SharedPrefsStorage({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;
  static const _kAppDataKey = 'split_calc_state_v1';

  @override
  Future<bool> save({required String key, required Object value}) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    } else {
      throw ArgumentError("Unsupported type: ${value.runtimeType}");
    }
  }

  @override
  Future<T?> get<T>({required String key}) async {
    final value = _sharedPreferences.get(key);
    if (value is T) {
      return value;
    }
    if (value == null) return null;
    throw ArgumentError("Expected type $T but found ${value.runtimeType}");
  }

  @override
  Future<bool> delete({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  Future<void> saveAppData(AppData data) async {
    await save(key: _kAppDataKey, value: jsonEncode(data.toJson()));
  }

  Future<AppData?> loadAppData() async {
    try {
      final raw = await get<String>(key: _kAppDataKey);
      if (raw == null) return null;
      return AppData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Кривые старые данные – очищаем
      await delete(key: _kAppDataKey);
      return null;
    }
  }

  Future<void> clearAppData() async {
    await delete(key: _kAppDataKey);
  }
}
