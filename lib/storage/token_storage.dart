import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstraction for secure storage of auth tokens and small secrets.
abstract interface class TokenStorage {
  Future<String?> readToken();
  Future<void> writeToken(String token);
  Future<void> deleteToken();
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<void> clearAll();
}

/// Platform secure storage backed by iOS Keychain and Android Keystore.
final class SecureTokenStorage implements TokenStorage {
  const SecureTokenStorage({
    FlutterSecureStorage? storage,
    this.tokenKey = defaultTokenKey,
  }) : _storage = storage ?? const FlutterSecureStorage();

  static const String defaultTokenKey = 'ugym_auth_token';

  final FlutterSecureStorage _storage;
  final String tokenKey;

  @override
  Future<String?> readToken() => _storage.read(key: tokenKey);

  @override
  Future<void> writeToken(String token) =>
      _storage.write(key: tokenKey, value: token);

  @override
  Future<void> deleteToken() => _storage.delete(key: tokenKey);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> clearAll() => _storage.deleteAll();
}

/// In-memory [TokenStorage] implementation for unit and widget tests.
final class InMemoryTokenStorage implements TokenStorage {
  InMemoryTokenStorage({
    String? initialToken,
    this.tokenKey = SecureTokenStorage.defaultTokenKey,
  }) {
    if (initialToken != null) {
      _values[tokenKey] = initialToken;
    }
  }

  final String tokenKey;
  final Map<String, String> _values = <String, String>{};

  @override
  Future<String?> readToken() async => _values[tokenKey];

  @override
  Future<void> writeToken(String token) async {
    _values[tokenKey] = token;
  }

  @override
  Future<void> deleteToken() async {
    _values.remove(tokenKey);
  }

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> clearAll() async {
    _values.clear();
  }
}
