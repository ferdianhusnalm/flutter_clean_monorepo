// lib/main_staging.dart
import 'bootstrap.dart';
import 'core/flavor/app_flavor.dart';

void main() async {
  FlavorConfig.setInstance(Flavors.staging);
  await bootstrap();
}
