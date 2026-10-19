import 'package:flutter/material.dart';

import 'app.dart';
import 'core/route/app_router.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(App(router: getIt<AppRouter>()));
}
