# Flutter Boilerplate

> Production-ready Flutter mono-repo boilerplate with Clean Architecture, modular packages, multi-flavor support (Android & iOS), and a complete tech stack.

---

## Tech Stack

| Category               | Package                                                 |
| ---------------------- | ------------------------------------------------------- |
| Networking             | `dio` + `pretty_dio_logger`                             |
| Dependency Injection   | `get_it` + `injectable` + `lean_builder` (build_runner) |
| Routing                | `auto_route`                                            |
| State Management       | `flutter_bloc` + `bloc`                                 |
| Functional Programming | `dartz`                                                 |
| Secure Storage         | `flutter_secure_storage`                                |
| Key-Value Cache        | `hive` + `hive_flutter`                                 |
| Relational DB          | `sqflite`                                               |
| Models / Serialization | `freezed` + `json_serializable`                         |
| Mono-repo Management   | `melos`                                                 |

---

## Project Structure

```
flutter_boilerplate/
├── apps/
│   └── main_app/                   # The Flutter application
│       ├── lib/
│       │   ├── main_dev.dart        # Dev flavor entry point
│       │   ├── main_staging.dart    # Staging flavor entry point
│       │   ├── main_prod.dart       # Prod flavor entry point
│       │   ├── bootstrap.dart       # App initialization (Hive, DI, error zones)
│       │   ├── app/
│       │   │   └── app.dart         # Root MaterialApp widget
│       │   └── core/
│       │       ├── di/              # Injectable DI setup
│       │       ├── flavor/          # FlavorConfig + Flavors constants
│       │       └── router/          # AutoRoute app router
│       ├── android/
│       │   └── app/
│       │       ├── build.gradle     # Flavors: dev / staging / prod
│       │       └── src/
│       │           ├── dev/         # Dev-specific resources
│       │           ├── staging/     # Staging-specific resources
│       │           └── prod/        # Prod-specific resources
│       └── ios/
│           └── Flutter/
│               └── flavors/         # dev.xcconfig / staging.xcconfig / prod.xcconfig
│
├── packages/
│   ├── core_network/               # Dio client, interceptors, Failure types
│   ├── core_storage/               # SecureStorage, Hive, SQLite (BaseDao)
│   ├── core_ui/                    # AppTheme, AppColors, shared widgets
│   ├── shared_models/              # Pagination, Result, shared value objects
│   ├── feature_auth/               # Auth feature (login, register, logout)
│   └── feature_home/               # Home feature (template for new features)
│
├── scripts/
│   └── setup.sh                    # One-time dev environment setup
├── .github/
│   └── workflows/
│       └── ci.yml                  # GitHub Actions CI (analyze, test, build)
├── melos.yaml                      # Mono-repo scripts and workspace config
└── analysis_options.yaml           # Strict lint rules
```

---

## Clean Architecture

Each feature package follows a strict 3-layer architecture:

```
feature_xxx/
└── lib/src/
    ├── domain/                     # Pure Dart — no Flutter, no packages
    │   ├── entities/               # Business objects (immutable, Equatable)
    │   ├── repositories/           # Abstract contracts (interfaces)
    │   └── usecases/               # Single-responsibility use cases
    │
    ├── data/                       # Implementation details
    │   ├── models/                 # Freezed DTOs with .toEntity() / fromJson()
    │   ├── datasources/            # Remote (Dio) + Local (Hive/SQLite) sources
    │   └── repositories/           # Implements domain contracts, maps errors
    │
    └── presentation/               # Flutter widgets
        ├── bloc/                   # BLoC + Freezed events/states
        ├── pages/                  # @RoutePage() annotated pages
        └── widgets/                # Feature-scoped reusable widgets
```

**Dependency flow:** `Presentation → Domain ← Data`  
The domain layer knows nothing about Flutter, Dio, or Hive.

---

## Flavors

### Android

Three product flavors are defined in `apps/main_app/android/app/build.gradle`:

| Flavor    | App ID suffix | App Name  |
| --------- | ------------- | --------- |
| `dev`     | `.dev`        | App [DEV] |
| `staging` | `.staging`    | App [STG] |
| `prod`    | _(none)_      | App       |

### iOS

Three `.xcconfig` files in `apps/main_app/ios/Flutter/flavors/`:

- `dev.xcconfig`
- `staging.xcconfig`
- `prod.xcconfig`

In Xcode, create three **Schemes** (Dev, Staging, Prod) and set each scheme's Build Configuration to use the matching `.xcconfig`. Each scheme's "Run" action should point to the corresponding `main_*.dart` entry point via `FLUTTER_TARGET`.

---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.22.0
- Dart SDK ≥ 3.3.0
- Android Studio / Xcode
- Java 17 (for Android)

### Setup (first time)

```bash
# 1. Clone
git clone https://github.com/yourorg/flutter_boilerplate.git
cd flutter_boilerplate

# 2. Run setup script (installs melos, bootstraps, generates code)
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### Running

```bash
melos run run:dev        # Dev flavor
melos run run:staging    # Staging flavor
melos run run:prod       # Production flavor
```

### Code Generation

```bash
melos run gen            # One-time build
melos run gen:watch      # Watch mode
```

### Tests

```bash
melos run test           # All packages
melos run test:coverage  # With coverage
```

### Building

```bash
melos run build:android:dev    # Android APK (dev)
melos run build:android:prod   # Android APK (prod, requires signing env vars)
melos run build:ios:dev        # iOS (dev, no codesign)
melos run build:ios:prod       # iOS (prod)
```

---

## Adding a New Feature

1. **Create package:**

   ```bash
   flutter create --template=package packages/feature_orders
   ```

2. **Copy the structure** from `feature_home` as a template.

3. **Register routes** in `apps/main_app/lib/core/router/app_router.dart`.

4. **Add dependency** in `apps/main_app/pubspec.yaml`:

   ```yaml
   feature_orders:
     path: ../../packages/feature_orders
   ```

5. **Run `melos bootstrap`** and then `melos run gen`.

---

## Environment Variables (CI)

For Android release builds, set these GitHub secrets:

| Secret              | Description             |
| ------------------- | ----------------------- |
| `KEYSTORE_PATH`     | Path to the `.jks` file |
| `KEYSTORE_PASSWORD` | Keystore password       |
| `KEY_ALIAS`         | Key alias               |
| `KEY_PASSWORD`      | Key password            |

---

## iOS Setup Checklist

After opening `apps/main_app/ios/Runner.xcodeproj` in Xcode:

- [ ] Create 3 schemes: **Dev**, **Staging**, **Prod**
- [ ] For each scheme → Edit Scheme → Run → Build Configuration → point to matching `.xcconfig`
- [ ] Set Bundle Identifier per flavor: `com.example.app` / `.dev` / `.staging`
- [ ] Configure signing & capabilities per scheme
- [ ] Add `GoogleService-Info.plist` per flavor directory (if using Firebase)

---

## License

MIT
