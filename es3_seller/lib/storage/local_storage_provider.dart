import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:riverpod/riverpod.dart';
import '../storage/platform_local_storage_interface.dart';
import '../storage/platform_local_storage.dart';

final platformLocalStorageProvider = Provider<IPlatformLocalStorage>((ref) {
  return PlatformLocalStorage();
});