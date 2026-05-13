// packages/core_network/lib/src/models/api_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    String? message,
    T? data,
    @Default([]) List<String> errors,
  }) = _ApiResponse;
}
