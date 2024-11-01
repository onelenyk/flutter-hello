import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_renderer.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_state.dart";
import "package:uuid/uuid.dart";

import "../../base/base_screen.dart";
import "../../base/mobile_frame.dart";
import "../../base/responsive_state.dart";
import "../a4_page_container.dart";
import "../theme/theme_manager.dart";

@RoutePage()
class MenyushaScreen extends StatefulWidget {
  MenyushaScreen({super.key});

  final getIt = GetIt.instance;
  late final MenyushaCubit cubit = getIt<MenyushaCubit>();

  @override
  _MenyushaScreenState createState() => _MenyushaScreenState(cubit);
}
///ui
class _MenyushaScreenState
    extends ResponsiveState<MenyushaScreen, MenyushaState, MenyushaCubit> {
  _MenyushaScreenState(super.cubit);

  @override
  void onStateChange(final BuildContext context,
      final MenyushaState state,) {}

  @override
  Widget buildDesktopLayout(final BuildContext context,
      final MenyushaState state,) =>
      buildBody(state: state);

  @override
  Widget buildMobileLayout(final BuildContext context,
      final MenyushaState state,) =>
      buildBody(state: state);

  Widget buildBody({required final MenyushaState state}) {
    final theme = MenuThemeManager.getTheme(state.activeMenu.menu.designPreset);

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
                          menu: state.activeMenu.menu,
                          addDish: () => {
                            widget.cubit.addDish()
                          },
                        )),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                A4PageContainer(
                  color: theme.backgroundColor,
                  child: MenuEditorWidget(
                    menu: state.activeMenu.menu,
                    onSave: (menu) {
                      widget.cubit.saveMenu(menu: menu);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}