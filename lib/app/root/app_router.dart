import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../features/main/screen/menyusha/admin/admin_screen.dart";
import "../features/main/screen/menyusha/admin/container/admin_container.dart";
import "../features/main/screen/menyusha/admin/create_menu/create_menu_screen.dart";
import "../features/main/screen/menyusha/admin/list_menu/list_menu_screen.dart";
import "../features/main/screen/menyusha/admin/view_menu/private_menu_screen.dart";
import "../features/main/screen/menyusha/hello/hello_screen.dart";
import "../features/main/screen/menyusha/login/login_screen.dart";
import "../features/main/screen/menyusha/login/registration_screen.dart";
import "../features/main/screen/menyusha/public/view_menu/public_menu_screen.dart";
import "../features/main/screen/mobileera_screen.dart";
import "../features/main/screen/notfound/not_found.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MobileEraRoute.page,
          path: "/",
          children: [
            AutoRoute(page: HelloRoute.page, path: "", initial: true),
            //
            AutoRoute(page: RegistrationRoute.page, path: "registration"),
            AutoRoute(page: LoginRoute.page, path: "login"),
            //
            AutoRoute(
                page: AdminContainerRoute.page,
                path: "admin",
                children: [
                  AutoRoute(page: ListMenuRoute.page, path: ""),
                  AutoRoute(page: CreateMenuRoute.page, path: "create"),
                  AutoRoute(page: PrivateMenuRoute.page, path: ":id"),
                ]),
            //
            AutoRoute(page: PublicMenuRoute.page, path: ":id"),

            AutoRoute(page: NotFoundRoute.page, path: "not-found"),
            RedirectRoute(path: "*", redirectTo: "not-found"),
          ],
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    return resolver.next();
    if (resolver.route.name == LoginRoute.name) {
      // we continue navigation
      resolver.next();
    } else {
      // else we navigate to the Login page so we get authenticateed
      //  push(LoginRoute(onResult:(didLogin)=> resolver.next(didLogin)))
    }
  }
}
