import 'package:purchase_order/core/constants/app_constants.dart';
import 'package:purchase_order/core/error/exceptions.dart';
import 'package:purchase_order/core/utils/secure_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveCredentials({
    required String email,
    required String password,
  });

  Future<Map<String, String>> getSavedCredentials();

  Future<void> clearCredentials();

  Future<bool> getRememberMe();

  Future<void> setRememberMe(bool value);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageHelper _secureStorage;
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._secureStorage, this._prefs);

  @override
  Future<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await _secureStorage.write(AppConstants.usernameKey, email);
      await _secureStorage.write(AppConstants.passwordKey, password);
    } catch (e) {
      throw CacheException('Failed to save credentials');
    }
  }

  @override
  Future<Map<String, String>> getSavedCredentials() async {
    try {
      final email = await _secureStorage.read(AppConstants.usernameKey);
      final password = await _secureStorage.read(AppConstants.passwordKey);
      return {
        'email': email ?? '',
        'password': password ?? '',
      };
    } catch (e) {
      throw CacheException('Failed to retrieve credentials');
    }
  }

  @override
  Future<void> clearCredentials() async {
    try {
      await _secureStorage.delete(AppConstants.usernameKey);
      await _secureStorage.delete(AppConstants.passwordKey);
    } catch (e) {
      throw CacheException('Failed to clear credentials');
    }
  }

  @override
  Future<bool> getRememberMe() async {
    try {
      return _prefs.getBool(AppConstants.rememberMeKey) ?? false;
    } catch (e) {
      throw CacheException('Failed to get remember me preference');
    }
  }

  @override
  Future<void> setRememberMe(bool value) async {
    try {
      await _prefs.setBool(AppConstants.rememberMeKey, value);
    } catch (e) {
      throw CacheException('Failed to set remember me preference');
    }
  }
}
