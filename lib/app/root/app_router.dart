import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

import "../features/hello/presentation/hello_screen.dart";
import "../features/notfound/not_found.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends _$AppRouter {
  final getIt = GetIt.instance;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HelloRoute.page, path: "/", initial: true),
        //
        AutoRoute(page: NotFoundRoute.page, path: "/not-found"),
        RedirectRoute(path: "*", redirectTo: "/not-found"),
      ];
}
