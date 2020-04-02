import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
// Create storage

  // Make this a singleton class.
  SecuredStorage._privateConstructor();
  static final SecuredStorage instance = SecuredStorage._privateConstructor();
  final _storage = new FlutterSecureStorage();

  Future<String> readValue(String val) async {
    // Read value
    String value;
    await _storage.read(key: val).then((onValue) {
      value = onValue.toString();
    });
    return value;
  }

  Future<void> deleteValue(String key) async {
    // Read value
    _storage.delete(key: key);
  }

  Future<void> insertValue(String key, String value) async {
    // Read value
    _storage.write(key: key, value: value);
  }
}
