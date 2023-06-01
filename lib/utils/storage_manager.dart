import 'package:get_storage/get_storage.dart';

mixin StorageManager {
  final box = GetStorage();

  Future<String?> getData(String key) async {
    return box.read(key);
  }

  Future<void> setData(String key, String value) async {
    await box.write(key, value);
  }

  Future<void> removeData(String key) async {
    await box.remove(key);
  }

  Future<void> clearData() async {
    await box.erase();
  }
}
