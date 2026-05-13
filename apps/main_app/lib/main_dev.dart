// lib/main_dev.dart
import 'bootstrap.dart';
import 'core/flavor/app_flavor.dart';

void main() async {
  FlavorConfig.setInstance(Flavors.dev);
  await bootstrap();
}
