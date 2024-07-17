import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _authKey = 'key';
  static const _cookies = 'cookies';
  static const _userId = 'userId';
  static const _changePasswordKey = 'passkey';

  // final String _authToken;

  // String get authToken => _authToken;

  // final String _userId;

  // String get userId => _userId;

  // static UserSecureStorage? _instance;

  // factory UserSecureStorage() => _instance!;

  // UserSecureStorage._init(this._authToken, this._userId);

  static Future setUserCredentials(String authkey, String refreshToken) async {
    await _storage.write(key: _authKey, value: '$authkey;$refreshToken');
    // await _storage.write(key: _userId, value: userId);
  }

 static Future<List<String>> getUserCredentials() async {
    String? authAndToken = await _storage.read(key: _authKey) ?? ";";
    final authAndTokenList = authAndToken.split(';');
    final retrievedAuthToken = authAndTokenList[0];
    final retrievedRefreshToken = authAndTokenList[1];
   
    //final finalRetrievedRefreshToken = retrievedRefreshToken[1];
    return [retrievedAuthToken, retrievedRefreshToken];
  }

  static Future setChangePasswordKey(String token) async {
    await _storage.write(key: _changePasswordKey, value: token);
  }

  static Future<String> getChangePasswordKey() async {
    String? token = await _storage.read(key: _changePasswordKey) ?? '';
    return token.toString();
  }

  static Future setAppCookies(String cookie) async {
    await _storage.write(key: _cookies, value: cookie);
  }

  static Future<String> getAppCookies() async {
    String? cooky = await _storage.read(key: _cookies) ?? '';
    return cooky.toString();
  }

  static Future<List<String>> getUserDetails() async {
    String? tokenId = await _storage.read(key: _authKey) ?? '';
    String? id = await _storage.read(key: _userId) ?? '';
    return [tokenId, id];
  }

  static Future deleteUserDetails() async {
    await _storage.delete(key: _authKey);
    await _storage.delete(key: _cookies);
    await _storage.delete(key: _userId);
  }

  static Future<String?> getAuthKey() async =>
      await _storage.read(key: _authKey);

  static Future<String?> getUserId() async => await _storage.read(key: _userId);
}
