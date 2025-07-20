import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage();

  final secureStorage = FlutterSecureStorage();

  Future<void> armazenarToken(String tokenKey, String tokenValue) async {
    await secureStorage.write(key: tokenKey, value: tokenValue);
  }

  Future<dynamic> recuperarToken(String tokenKey) async {
    final secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: tokenKey);
    return token;
  }

  Future<void> excluirToken(String tokenKey) async {
    final secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: tokenKey);
  }
}
