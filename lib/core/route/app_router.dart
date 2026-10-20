import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/preview/preview_screen.dart';
import '../../presentation/process/process_screen.dart';
import '../../presentation/result_list/result_list_screen.dart';
import '../../domain/entities/path_result.dart';
import 'package:collection/collection.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ProcessRoute.page),
    AutoRoute(page: ResultListRoute.page),
    AutoRoute(page: PreviewRoute.page),
  ];
}
