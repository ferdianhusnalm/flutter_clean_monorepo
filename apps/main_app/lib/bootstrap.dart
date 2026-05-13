// lib/bootstrap.dart
import 'dart:async';
import 'package:core_di/core_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';

// import 'app/app.dart';
// import 'core/di/injection.dart';

Future<void> bootstrap() async {
  // Catch all Flutter errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // TODO: send to crash reporting (Crashlytics / Sentry)
  };

  // Catch async/zone errors
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Lock orientation
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Init Hive
      await Hive.initFlutter();

      // Setup DI
      await configureDependencies();

      runApp(const App());
    },
    (error, stack) {
      // TODO: log to crash reporting
      debugPrint('Uncaught error: $error\n$stack');
    },
  );
}
