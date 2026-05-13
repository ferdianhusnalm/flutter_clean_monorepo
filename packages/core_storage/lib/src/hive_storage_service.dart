// packages/core_storage/lib/src/hive_storage_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveStorageService {
  static const String _settingsBox = 'settings';
  static const String _cacheBox = 'cache';

  Future<Box<T>> openBox<T>(String name) => Hive.openBox<T>(name);

  Future<LazyBox<T>> openLazyBox<T>(String name) => Hive.openLazyBox<T>(name);

  // ─── Settings (synchronous KV for user preferences) ─────────────────────────
  Future<Box> get _settings => Hive.openBox(_settingsBox);

  Future<void> putSetting<T>(String key, T value) async {
    final box = await _settings;
    await box.put(key, value);
  }

  Future<T?> getSetting<T>(String key) async {
    final box = await _settings;
    return box.get(key) as T?;
  }

  Future<void> deleteSetting(String key) async {
    final box = await _settings;
    await box.delete(key);
  }

  // ─── Cache (short-lived data) ────────────────────────────────────────────────
  Future<Box> get _cache => Hive.openBox(_cacheBox);

  Future<void> putCache<T>(String key, T value) async {
    final box = await _cache;
    await box.put(key, value);
  }

  Future<T?> getCache<T>(String key) async {
    final box = await _cache;
    return box.get(key) as T?;
  }

  Future<void> clearCache() async {
    final box = await _cache;
    await box.clear();
  }

  Future<void> closeAll() => Hive.close();
}
