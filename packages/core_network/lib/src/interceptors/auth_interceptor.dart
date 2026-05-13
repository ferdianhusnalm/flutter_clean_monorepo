// packages/core_network/lib/src/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  AuthInterceptor(this._secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        if (newToken != null) {
          // Retry the original request with new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';
          final response = await Dio().fetch(options);
          handler.resolve(response);
          return;
        }
      } catch (_) {
        // Refresh failed — clear tokens and let error propagate
        await _clearTokens();
      }
    }
    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (refreshToken == null) return null;

    // TODO: call your refresh endpoint here
    // final response = await Dio().post('/auth/refresh', data: {'refresh_token': refreshToken});
    // final newToken = response.data['access_token'];
    // await saveToken(newToken);
    // return newToken;
    return null;
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  Future<void> _clearTokens() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
