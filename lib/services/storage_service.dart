import 'package:get_storage/get_storage.dart';

// singleton class to manage app settings
class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  final _box = GetStorage();

  // call this method on app init
  Future<void> init() async {
    await GetStorage.init();
  }

  // write to storage
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // read from storage
  dynamic read(String key) {
    return _box.read(key);
  }

  // remove from storage
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  // clear all from storage
  Future<void> clear() async {
    await _box.erase();
  }
}
