import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";

import "../../main.dart";
import "app_router.dart";

class RootComponent extends StatelessWidget {
  RootComponent({super.key}) {
    getIt
      ..registerSingleton<AppRouter>(AppRouter());
  }
  final getIt = GetIt.instance;

  late final _router = getIt.get<AppRouter>();

  ThemeData _buildTheme(final brightness) {
    final baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
        title: "Hello | Flutter",
        theme: _buildTheme(Brightness.light),
        routerConfig: _router.config(),
        debugShowCheckedModeBanner: !buildConfig.isProduction,
      );
}
