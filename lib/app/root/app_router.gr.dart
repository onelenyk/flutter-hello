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
    HelloRoute.name: (routeData) {
      final args = routeData.argsAs<HelloRouteArgs>(
          orElse: () => const HelloRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HelloScreen(key: args.key),
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
  };
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
