// packages/feature_auth/lib/src/data/datasources/auth_remote_datasource.dart
import 'package:core_network/core_network.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<({UserModel user, String token, String refreshToken})> login({
    required String email,
    required String password,
  });

  Future<({UserModel user, String token, String refreshToken})> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getMe();
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends BaseApiService
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(super.dio);

  @override
  Future<({UserModel user, String token, String refreshToken})> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return (
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      token: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );
  }

  @override
  Future<({UserModel user, String token, String refreshToken})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return (
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      token: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );
  }

  @override
  Future<void> logout() async {
    await dio.post('/auth/logout');
  }

  @override
  Future<UserModel> getMe() async {
    final response = await dio.get('/auth/me');
    return UserModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
