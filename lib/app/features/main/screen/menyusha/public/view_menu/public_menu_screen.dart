import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_renderer.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_state.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_state.dart";
import "package:uuid/uuid.dart";

import "../../../base/base_screen.dart";
import "../../../base/responsive_state.dart";
import "../../a4_page_container.dart";
import "../../theme/theme_manager.dart";

@RoutePage()
class PublicMenuScreen extends StatefulWidget {
  PublicMenuScreen({super.key, @PathParam('id') required this.id});

  final String id;

  final getIt = GetIt.instance;

  // Initialize the cubit with the passed id
  late final PublicMenuCubit cubit = getIt<PublicMenuCubit>(param1: id);

  @override
  _PublicMenuScreenState createState() => _PublicMenuScreenState(cubit);
}

///ui
class _PublicMenuScreenState extends ResponsiveState<PublicMenuScreen,
    PublicMenuState, PublicMenuCubit> {
  _PublicMenuScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final PublicMenuState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final PublicMenuState state,
  ) =>
      buildBody(state: state);

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final PublicMenuState state,
  ) =>
      buildBody(state: state);

  Widget buildBody({required final PublicMenuState state}) {
    if (state.activeMenu == null) {
      return CircularProgressIndicator();
    } else {
      final theme =
          MenuThemeManager.getTheme(state.activeMenu!.menu.designPreset);

      return BaseScreen(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              A4PageContainer(
                color: theme.backgroundColor,
                child: SelectionArea(
                  child: SingleChildScrollView(
                    child: MenuRendererWidget(
                      menu: state.activeMenu!.menu,
                      addDish: () => {},
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
  }
}
