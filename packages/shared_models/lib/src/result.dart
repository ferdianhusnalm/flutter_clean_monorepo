// packages/shared_models/lib/src/result.dart

/// A simple Result type as an alternative to Either when dartz isn't available.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => isSuccess ? (this as Success<T>).value : null;
  String? get errorOrNull => isFailure ? (this as Failure<T>).message : null;

  R when<R>({
    required R Function(T value) success,
    required R Function(String message) failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success(value),
      Failure<T>(:final message) => failure(message),
    };
  }
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

final class Failure<T> extends Result<T> {
  final String message;
  final int? code;
  const Failure(this.message, {this.code});
}
