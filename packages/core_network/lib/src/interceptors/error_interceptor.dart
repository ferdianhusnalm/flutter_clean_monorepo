// packages/core_network/lib/src/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../failure.dart';

@singleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapError(err);
    // Attach our Failure as extra so repositories can read it
    err = err.copyWith(error: failure);
    handler.next(err);
  }

  Failure _mapError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(message: 'Request timed out');

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = _extractMessage(err.response);
        switch (statusCode) {
          case 400:
            return ServerFailure(message: message, statusCode: 400);
          case 401:
            return const UnauthorizedFailure();
          case 403:
            return ServerFailure(message: 'Forbidden', statusCode: 403);
          case 404:
            return const NotFoundFailure();
          case 422:
            return ValidationFailure(message: message);
          case 500:
          case 502:
          case 503:
            return ServerFailure(
              message: 'Server error. Please try again later.',
              statusCode: statusCode,
            );
          default:
            return ServerFailure(message: message, statusCode: statusCode);
        }

      default:
        return const UnknownFailure();
    }
  }

  String _extractMessage(Response? response) {
    try {
      final data = response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ??
            data['error'] as String? ??
            'Something went wrong';
      }
    } catch (_) {}
    return 'Something went wrong';
  }
}
