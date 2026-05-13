// packages/core_network/lib/core_network.dart
library core_network;

export 'src/dio_client.dart';
export 'src/models/api_error.dart';
export 'src/models/api_response.dart';
export 'src/interceptors/auth_interceptor.dart';
export 'src/interceptors/connectivity_interceptor.dart';
export 'src/interceptors/error_interceptor.dart';
export 'src/network_info.dart';
export 'src/failure.dart';

// DI
export 'src/core/di/injection.dart';
export 'src/core/di/injection.module.dart';
