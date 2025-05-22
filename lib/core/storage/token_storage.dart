import 'package:pedidos_app/core/storage/secure_storage/secure_storage.dart';

class TokenStorage {
  final SecureStorage _storage;

  TokenStorage(this._storage);
  static const _keyAccess = 'ACCESS_TOKEN';
  static const _keyRefresh = 'REFRESH_TOKEN';

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: _keyAccess, value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _keyRefresh, value: refreshToken);
  }

  Future<String?> getAccessToken() async => await _storage.read(key: _keyAccess);
  Future<String?> getRefreshToken() async => await _storage.read(key: _keyRefresh);

  Future<void> clear() async {
    await _storage.delete(key: _keyAccess);
    await _storage.delete(key: _keyRefresh);
  }
}
