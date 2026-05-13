// packages/core_network/lib/src/interceptors/connectivity_interceptor.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity;

  ConnectivityInterceptor(this._connectivity);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final results = await _connectivity.checkConnectivity();
    final isConnected = results.any((r) => r != ConnectivityResult.none);

    if (!isConnected) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection',
        ),
      );
      return;
    }
    handler.next(options);
  }
}

@module
abstract class ConnectivityModule {
  @singleton
  Connectivity get connectivity => Connectivity();
}
