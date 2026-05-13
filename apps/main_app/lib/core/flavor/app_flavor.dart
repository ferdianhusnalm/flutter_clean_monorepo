// lib/core/flavor/app_flavor.dart

enum AppFlavor { dev, staging, prod }

class FlavorConfig {
  final AppFlavor flavor;
  final String name;
  final String baseUrl;
  final String apiKey;
  final bool enableLogging;
  final bool enableCrashlytics;

  const FlavorConfig({
    required this.flavor,
    required this.name,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.enableCrashlytics,
  });

  static late FlavorConfig _instance;

  static FlavorConfig get instance => _instance;

  static void setInstance(FlavorConfig config) {
    _instance = config;
  }

  bool get isDev => flavor == AppFlavor.dev;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProd => flavor == AppFlavor.prod;

  @override
  String toString() =>
      'FlavorConfig(flavor: $flavor, name: $name, baseUrl: $baseUrl)';
}

// Flavor definitions
class Flavors {
  static const dev = FlavorConfig(
    flavor: AppFlavor.dev,
    name: 'Dev',
    baseUrl: 'https://api-dev.example.com',
    apiKey: 'dev-api-key',
    enableLogging: true,
    enableCrashlytics: false,
  );

  static const staging = FlavorConfig(
    flavor: AppFlavor.staging,
    name: 'Staging',
    baseUrl: 'https://api-staging.example.com',
    apiKey: 'staging-api-key',
    enableLogging: true,
    enableCrashlytics: true,
  );

  static const prod = FlavorConfig(
    flavor: AppFlavor.prod,
    name: 'Production',
    baseUrl: 'https://api.example.com',
    apiKey: 'prod-api-key',
    enableLogging: false,
    enableCrashlytics: true,
  );
}
