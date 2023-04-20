import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _id = 'ID';
const _tokenType = 'TOKEN_TYPE';
const _accessToken = 'ACCESS_TOKEN';
const _expiresIn = 'EXPIRES_IN';
const _refreshToken = 'REFRESH_TOKEN';

abstract class Storage {
  Future<String?> get id;

  Future<String?> get tokenType;

  Future<String?> get accessToken;

  Future<String?> get expiresIn;

  Future<String?> get refreshToken;

  Future<void> saveId(String id);

  Future<void> saveTokenType(String tokenType);

  Future<void> saveAccessToken(String accessToken);

  Future<void> saveExpiresIn(String expiresIn);

  Future<void> saveRefreshToken(String refreshToken);

  Future<void> clearAllStorage();
}

@Singleton(as: Storage)
class StorageImpl extends Storage {
  final FlutterSecureStorage _storage;

  StorageImpl(this._storage);

  @override
  Future<String?> get id => _storage.read(key: _id);

  @override
  Future<String?> get tokenType => _storage.read(key: _tokenType);

  @override
  Future<String?> get accessToken => _storage.read(key: _accessToken);

  @override
  Future<String?> get expiresIn => _storage.read(key: _expiresIn);

  @override
  Future<String?> get refreshToken => _storage.read(key: _refreshToken);

  @override
  Future<void> saveId(String id) {
    return _storage.write(key: _id, value: id);
  }

  @override
  Future<void> saveTokenType(String tokenType) {
    return _storage.write(key: _tokenType, value: tokenType);
  }

  @override
  Future<void> saveAccessToken(String accessToken) {
    return _storage.write(key: _accessToken, value: accessToken);
  }

  @override
  Future<void> saveExpiresIn(String expiresIn) {
    return _storage.write(key: _expiresIn, value: expiresIn);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return _storage.write(key: _refreshToken, value: refreshToken);
  }

  @override
  Future<void> clearAllStorage() {
    return _storage.deleteAll();
  }
}