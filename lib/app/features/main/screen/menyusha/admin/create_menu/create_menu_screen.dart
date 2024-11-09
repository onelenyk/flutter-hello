import "dart:ui";

import "package:auto_route/annotations.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/common/link_utils.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/list_menu/list_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/admin/list_menu/list_menu_state.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../../../data/firebase/menu/menu_payload.dart";
import "../../../../../../root/app_router.dart";
import "../../../base/responsive_state.dart";
import "../../a4_page_container.dart";
import "../../menu/menyusha_renderer.dart";
import "../../theme/app_style.dart";
import "../create_menu/create_dialog.dart";
import "create_menu_cubit.dart";
import "create_menu_state.dart";

@RoutePage()
class CreateMenuScreen extends StatefulWidget {
  CreateMenuScreen({super.key});

  final getIt = GetIt.instance;
  late final CreateMenuCubit cubit = getIt.get<CreateMenuCubit>();

  @override
  _CreateMenuScreenState createState() => _CreateMenuScreenState(cubit);
}

class _CreateMenuScreenState extends ResponsiveState<CreateMenuScreen,
    CreateMenuState, CreateMenuCubit> {
  _CreateMenuScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final CreateMenuState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final CreateMenuState state,
  ) =>
      Container(
        child: A4PageContainer(
          child: buildBody(state: state),
          color: Colors.white,
        ),
        color: Colors.white,
      );

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final CreateMenuState state,
  ) =>
      buildBody(state: state);

  Widget buildDescription() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            'Створення меню',
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

  Widget buildBody({required final CreateMenuState state}) {
    final reachLimit = (state.items.length >= 3);

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppDesign.buildLogo(context),
              AppDesign.buildUserButton(context),
            ],
          ),
          buildDescription(),
          SizedBox(height: 16.0),
          CreateMenuPayloadWidget(
            onCreate: (newPayload) {
              state.activeMenu != null
                  ? cubit.updateMenu(payload: newPayload)
                  : cubit.createNewMenu(payload: newPayload);
            },
            onPayloadChange: (previewPayload) {
              cubit.onPreviewChanged(payload: previewPayload);
            },
          ),
      
          if (state.activeMenu != null) MenuRendererWidget(
                  menu: state.activeMenu!.menu,
                ) else if (state.previewMenu != null) MenuRendererWidget(
            menu: state.previewMenu!.menu,
          ) else Container(),
        ],
      ),
    );
  }
}
