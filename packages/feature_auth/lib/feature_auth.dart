// packages/feature_auth/lib/feature_auth.dart
library feature_auth;

// Domain
export 'src/domain/entities/user.dart';
export 'src/domain/repositories/auth_repository.dart';
export 'src/domain/usecases/login_usecase.dart';
export 'src/domain/usecases/logout_usecase.dart';
export 'src/domain/usecases/register_usecase.dart';

// Data
export 'src/data/models/user_model.dart';
export 'src/data/respositories/auth_repository_impl.dart';

// Presentation
export 'src/presentation/bloc/auth/auth_bloc.dart';
export 'src/presentation/pages/login_page.dart';

// Router
export 'src/core/route/auth_router.dart';

// DI
export 'src/core/di/injection.dart';
export 'src/core/di/injection.module.dart';
