// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AdminRoute.name: (routeData) {
      final args = routeData.argsAs<AdminRouteArgs>(
          orElse: () => const AdminRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdminScreen(key: args.key),
      );
    },
    HelloRoute.name: (routeData) {
      final args = routeData.argsAs<HelloRouteArgs>(
          orElse: () => const HelloRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HelloScreen(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
      );
    },
    MenuRoute.name: (routeData) {
      final args =
          routeData.argsAs<MenuRouteArgs>(orElse: () => const MenuRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MenuScreen(key: args.key),
      );
    },
    MenyushaRoute.name: (routeData) {
      final args = routeData.argsAs<MenyushaRouteArgs>(
          orElse: () => const MenyushaRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MenyushaScreen(key: args.key),
      );
    },
    MobileEraRoute.name: (routeData) {
      final args = routeData.argsAs<MobileEraRouteArgs>(
          orElse: () => const MobileEraRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MobileEraScreen(key: args.key),
      );
    },
    NotFoundRoute.name: (routeData) {
      final args = routeData.argsAs<NotFoundRouteArgs>(
          orElse: () => const NotFoundRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotFoundScreen(key: args.key),
      );
    },
    PublicMenuRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PublicMenuRouteArgs>(
          orElse: () => PublicMenuRouteArgs(id: pathParams.getString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PublicMenuScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationRouteArgs>(
          orElse: () => const RegistrationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegistrationScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [AdminScreen]
class AdminRoute extends PageRouteInfo<AdminRouteArgs> {
  AdminRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AdminRoute.name,
          args: AdminRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const PageInfo<AdminRouteArgs> page = PageInfo<AdminRouteArgs>(name);
}

class AdminRouteArgs {
  const AdminRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AdminRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HelloScreen]
class HelloRoute extends PageRouteInfo<HelloRouteArgs> {
  HelloRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HelloRoute.name,
          args: HelloRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HelloRoute';

  static const PageInfo<HelloRouteArgs> page = PageInfo<HelloRouteArgs>(name);
}

class HelloRouteArgs {
  const HelloRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HelloRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MenuScreen]
class MenuRoute extends PageRouteInfo<MenuRouteArgs> {
  MenuRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MenuRoute.name,
          args: MenuRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const PageInfo<MenuRouteArgs> page = PageInfo<MenuRouteArgs>(name);
}

class MenuRouteArgs {
  const MenuRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MenuRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MenyushaScreen]
class MenyushaRoute extends PageRouteInfo<MenyushaRouteArgs> {
  MenyushaRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MenyushaRoute.name,
          args: MenyushaRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MenyushaRoute';

  static const PageInfo<MenyushaRouteArgs> page =
      PageInfo<MenyushaRouteArgs>(name);
}

class MenyushaRouteArgs {
  const MenyushaRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MenyushaRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MobileEraScreen]
class MobileEraRoute extends PageRouteInfo<MobileEraRouteArgs> {
  MobileEraRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MobileEraRoute.name,
          args: MobileEraRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MobileEraRoute';

  static const PageInfo<MobileEraRouteArgs> page =
      PageInfo<MobileEraRouteArgs>(name);
}

class MobileEraRouteArgs {
  const MobileEraRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MobileEraRouteArgs{key: $key}';
  }
}

/// generated route for
/// [NotFoundScreen]
class NotFoundRoute extends PageRouteInfo<NotFoundRouteArgs> {
  NotFoundRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NotFoundRoute.name,
          args: NotFoundRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static const PageInfo<NotFoundRouteArgs> page =
      PageInfo<NotFoundRouteArgs>(name);
}

class NotFoundRouteArgs {
  const NotFoundRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NotFoundRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PublicMenuScreen]
class PublicMenuRoute extends PageRouteInfo<PublicMenuRouteArgs> {
  PublicMenuRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
          PublicMenuRoute.name,
          args: PublicMenuRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'PublicMenuRoute';

  static const PageInfo<PublicMenuRouteArgs> page =
      PageInfo<PublicMenuRouteArgs>(name);
}

class PublicMenuRouteArgs {
  const PublicMenuRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'PublicMenuRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<RegistrationRouteArgs> page =
      PageInfo<RegistrationRouteArgs>(name);
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key}';
  }
}
