import 'dart:html' as html;

import 'package:es3_seller/storage/platform_local_storage_interface.dart';

class PlatformLocalStorage extends IPlatformLocalStorage {

  @override
  void remove(String key) {
    html.window.localStorage.remove(key);
  }

  @override
  void setItem({required String key, required String value}) {
    html.window.localStorage[key] = value;
  }

  @override
  Future<String?> getItem({required String key}) {
    return Future.value(html.window.localStorage[key]);
  }
}