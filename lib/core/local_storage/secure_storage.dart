import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  Future<bool> containValue(String key) {
    return storage.containsKey(key: key);
  }

  Future<void> setValue({required String key, required String value}) {
    return storage.write(key: key, value: value);
  }

  Future<String?> getValue(String key) {
    return storage.read(key: key);
  }

  Future<void> deleteValue(String key) {
    return storage.delete(key: key);
  }

  Future<Map<String, String>> getAll() {
    return storage.readAll();
  }

  Future<void> deleteAllValues() {
    return storage.deleteAll();
  }
}
