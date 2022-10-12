import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  Future<bool> addBoolToSharedPreference(
      {required String key, required bool value}) async {
    final store = await SharedPreferences.getInstance();
    bool hasAdded = await store.setBool(key, value);
    return hasAdded;
  }

  Future<bool?> getBoolFromStorage({required String key}) async {
    final store = await SharedPreferences.getInstance();
    return store.getBool(key);
  }
}
