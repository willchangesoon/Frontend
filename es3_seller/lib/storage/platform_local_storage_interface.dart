abstract class IPlatformLocalStorage {
  void remove(String key);

  Future<void> setItem({required String key, required String value});
  Future<String?> getItem({required String key});
}
