import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/data/firebase/services/firestore_service.dart";
import "package:menyusha/app/data/firebase/user/user_payload_repository.dart";
import "package:menyusha/app/features/main/screen/menyusha/a4_page_container.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/admin_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/create_menu/create_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/list_menu/list_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/view_menu/private_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/login/auth_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";
import "package:menyusha/app/root/app_router.dart";
import "package:menyusha/main.dart";

import "../data/firebase/user_manager.dart";

class RootComponent extends StatelessWidget {

  RootComponent({super.key}) {
    getIt
      ..registerSingleton<AppRouter>(AppRouter())
      ..registerSingleton<UserManager>(UserManager())
      ..registerSingleton<FirestoreService>(FirestoreService())
      ..registerSingleton<AuthenticationCubit>(
          AuthenticationCubit(firebaseAuth))
      ..registerSingleton<ListMenuCubit>(ListMenuCubit())
      ..registerSingleton<AdminCubit>(AdminCubit())
      ..registerSingleton<CreateMenuCubit>(CreateMenuCubit())
      ..registerFactoryParam<PublicMenuCubit, String, void>(
        (id, _) => PublicMenuCubit(id),
      )
      ..registerFactoryParam<PrivateMenuCubit, String, void>(
        (id, _) => PrivateMenuCubit(id),
      )
      ..registerSingleton<UserPayloadRepository>(
        UserPayloadRepository(),
      );
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
        title: "Nazar Lenyk",
        theme: _buildTheme(Brightness.light),
        routerConfig: _router.config(placeholder: (context) => AppDesign.buildLogoLoader()),
        debugShowCheckedModeBanner: !buildConfig.isProduction,
      );
}
