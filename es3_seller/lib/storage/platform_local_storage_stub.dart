import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'platform_local_storage_interface.dart';

class PlatformLocalStorage implements IPlatformLocalStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getItem({required String key}) async {
    return await _secureStorage.read(key: key);
  }
}
