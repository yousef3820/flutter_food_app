import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDatasource {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // Store data
  Future<void> storeSecureData(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  // Retrieve data
  Future<String?> retrieveSecureData(String key) async {
    return await secureStorage.read(key: key); // returns null if not found
  }

  // Delete data
  Future<void> deleteSecureData(String key) async {
    await secureStorage.delete(key: key);
  }
}
