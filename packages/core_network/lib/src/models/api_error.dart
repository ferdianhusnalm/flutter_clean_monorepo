// packages/core_network/lib/src/models/api_error.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
@JsonSerializable()
class ApiError with _$ApiError {
  const factory ApiError({
    required String message,
    int? statusCode,
    @Default([]) List<String> errors,
  }) = _ApiError;
}
