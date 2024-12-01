import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class _CacheConstants {
  static const String user = 'user';
  static const String token = 'token';
  static const String refreshToken = 'refresh_token';
  static const String locale = 'lang';
  static const String tenant = 'tenant';
}

class PrefsService {
  static late final SharedPreferences _self;

  Future<void> init() async {
    _self = await SharedPreferences.getInstance();
  }

  final user = const UserCache();
  final locale = const LocaleCache();
  final tenant = const TenantCache();
  final token = const TokenCache();
  final refreshToken = const RefreshTokenCache();
}

class UserCache extends _CacheField<Map<String, dynamic>> {
  const UserCache() : super(_CacheConstants.user);
}

class TenantCache extends _CacheField<String> {
  const TenantCache() : super(_CacheConstants.tenant);
}

class TokenCache extends _CacheField<String> {
  const TokenCache() : super(_CacheConstants.token);
}

class RefreshTokenCache extends _CacheField<String> {
  const RefreshTokenCache() : super(_CacheConstants.refreshToken);
}

class LocaleCache extends _CacheField<String> {
  const LocaleCache() : super(_CacheConstants.locale);

  @override
  String get() {
    return super.get() ?? 'ar';
  }
}

class _CacheField<T> {
  final String key;

  const _CacheField(this.key);

  Future<bool> put(T value) {
    return PrefsService._self.setString(key, jsonEncode(value));
  }

  T? get() {
    try {
      return jsonDecode(PrefsService._self.getString(key)!);
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete() {
    return PrefsService._self.remove(key);
  }

  bool exists() {
    return PrefsService._self.containsKey(key);
  }
}
