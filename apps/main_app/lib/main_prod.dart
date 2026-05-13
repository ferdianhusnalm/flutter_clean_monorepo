import 'bootstrap.dart';
import 'core/flavor/app_flavor.dart';

void main() async {
  FlavorConfig.setInstance(Flavors.prod);
  await bootstrap();
}
