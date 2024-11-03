import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/data/firebase/auth/auth_state.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/view_menu/private_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/view_menu/private_menu_state.dart";
import "package:menyusha/app/features/main/screen/menyusha/login/auth_cubit.dart";

import "../../../../../../data/firebase/menu/menu_payload.dart";
import "../../../../../../root/app_router.dart";
import "../../../base/responsive_state.dart";
import "../../a4_page_container.dart";
import "../../menu/menyusha_renderer.dart";
import "../../theme/app_style.dart";
import "../../theme/theme_manager.dart";
import "../admin_cubit.dart";
import "../admin_screen.dart";
import "../admin_state.dart";
import "../create_menu/create_dialog.dart";

@RoutePage()
class PrivateMenuScreen extends StatefulWidget {
  PrivateMenuScreen({super.key, @PathParam('id') required this.id});

  final String id;

  final getIt = GetIt.instance;

  // Initialize the cubit with the passed id
  late final PrivateMenuCubit cubit = getIt<PrivateMenuCubit>(param1: id);

  @override
  _PrivateMenuScreenState createState() => _PrivateMenuScreenState(cubit);
}

class _PrivateMenuScreenState extends ResponsiveState<PrivateMenuScreen,
    PrivateMenuState, PrivateMenuCubit> {
  _PrivateMenuScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final PrivateMenuState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final PrivateMenuState state,
  ) =>
      Container(
        color: Colors.white,
        child: A4PageContainer(
          color: Colors.white,
          child: buildBody(state: state),
        ),
      );

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final PrivateMenuState state,
  ) =>
      buildBody(state: state);

  Widget buildDescriptionPreview() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            'Превью:',
            style: AppStyles.body3Style,
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget buildDescription() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            'Meню:',
            style: AppStyles.body2Style,
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget buildBlueFilledButton(
          {required final Widget child,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final EdgeInsetsGeometry? padding =
              const EdgeInsets.symmetric(horizontal: 4.0),
          final bool wrapContent = false}) =>
      SizedBox(
        height: wrapContent ? null : 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled
                ? AppColors.blueAccent
                : AppColors.blueAccent
                    .withOpacity(0.5), // Dimmed color when disabled
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      );

  Widget buildMenuItem({required final MenuPayload item}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: buildBlueFilledButton(
          wrapContent: true,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppStyles.blueFilledButtonTextStyle,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: AppStyles.blueFilledButtonTextStyle,
                          "Design Preset: ${item.menu.designPreset.name} Public id: ${item.publicId}",
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    cubit.deleteMenu(payload: item);

                    final router = AutoRouter.of(context);
                    router.back();
                  },
                ),
              ],
            ),
          ),
          onPressed: () {
            launchInternalPage(item.publicId, isNewTab: true);
          }),
    );
  }

  Widget buildItemBody({required final PrivateMenuState state}) {
    Widget widget;

    switch (state.viewMode) {
      case Mode.VIEW:
        {
          widget = MenuRendererWidget(
            menu: state.activeMenu!.menu,
          );
        }
      case Mode.EDIT_JSON:
        {
          widget = MenuEditorWidget(
            menu: state.activeMenu!.menu,
            onSave: (menu) {
              cubit.saveMenu(menu: menu);
            },
          );
        }
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppDesign.buildBlueFilledButton(
                child: Text(
                  "VIEW",
                  style: AppStyles.blueFilledButtonTextStyle,
                ),
                enabled: state.viewMode != Mode.VIEW,
                onPressed: () {
                  cubit.switchMode();
                }),
            const SizedBox(width: 8.0),
            AppDesign.buildBlueFilledButton(
                child: Text(
                  "EDIT JSON",
                  style: AppStyles.blueFilledButtonTextStyle,
                ),
                enabled: state.viewMode != Mode.EDIT_JSON,
                onPressed: () {
                  cubit.switchMode();
                }),
          ],
        ),
        SizedBox(height: 8.0),
        widget,
      ],
    );
  }

  Widget buildBody({required final PrivateMenuState state}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppDesign.buildLogo(),
              AppDesign.buildUserButton(context),
            ],
          ),
          buildDescription(),
          SizedBox(height: 16.0),
          state.activeMenu != null
              ? buildMenuItem(item: state.activeMenu!)
              : Container(),
          SizedBox(height: 8.0),
          state.activeMenu != null ? buildItemBody(state: state) : Container(),
        ],
      ),
    );
  }
}
