// packages/core_network/lib/src/dio_client.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/error_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    ConnectivityInterceptor connectivityInterceptor,
    ErrorInterceptor errorInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        // baseUrl is injected via FlavorConfig at app level
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      connectivityInterceptor,
      authInterceptor,
      errorInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
      ),
    ]);

    return dio;
  }
}

// ─── Base API service ─────────────────────────────────────────────────────────

abstract class BaseApiService {
  final Dio dio;

  BaseApiService(this.dio);
}
