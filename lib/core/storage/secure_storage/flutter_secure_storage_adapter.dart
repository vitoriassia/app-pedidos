import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage.dart';

class FlutterSecureStorageAdapter implements SecureStorage {
  final _secure = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) =>
      _secure.write(key: key, value: value);

  @override
  Future<String?> read({required String key}) => _secure.read(key: key);

  @override
  Future<void> delete({required String key}) => _secure.delete(key: key);
}
