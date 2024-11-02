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
import "../../theme/app_style.dart";
import "../admin_cubit.dart";
import "../create_menu/create_dialog.dart";

@RoutePage()
class ListMenuScreen extends StatefulWidget {
  ListMenuScreen({super.key});

  final getIt = GetIt.instance;
  late final ListMenuCubit cubit = getIt.get<ListMenuCubit>();

  @override
  _ListMenuScreenState createState() => _ListMenuScreenState(cubit);
}

class _ListMenuScreenState
    extends ResponsiveState<ListMenuScreen, ListMenuState, ListMenuCubit> {
  _ListMenuScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final ListMenuState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final ListMenuState state,
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
    final ListMenuState state,
  ) =>
      buildBody(state: state);

  Widget buildDescription() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            'Список меню:',
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
                  onPressed: () => cubit.deleteMenu(payload: item),
                ),
              ],
            ),
          ),
          onPressed: () {
            final router = AutoRouter.of(context);
            // Use pushAndRemoveUntil with the root route
            router.navigate(
              PrivateMenuRoute(id: item.id),
            );
          }),
    );
  }

  Widget buildBody({required final ListMenuState state}) {
    final reachLimit = (state.items.length >= 3);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppDesign.buildLogo(),
            AppDesign.buildUserButton(context),
          ],
        ),
        buildDescription(),
        Column(
          children: state.items.map((item) {
            return buildMenuItem(item: item);
          }).map((item) {
            return item;
          }).toList(),
        ),
        SizedBox(height: 16.0),
        AppDesign.buildBlueOutlinedButton(
            child: reachLimit
                ? Text(
                    'Ліміт досягнуто',
                    style: AppStyles.blueOutlinedButtonTextStyle
                        .copyWith(color: AppColors.blueAccent.withOpacity(0.5)),
                  )
                : Text(
                    'Створити нове меню',
                    style: AppStyles.blueOutlinedButtonTextStyle,
                  ),
            enabled: !reachLimit,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CreateMenuPayloadDialog(
                  onCreate: (newPayload) {
                    cubit.createNewMenu(payload: newPayload);
                  },
                ),
              );
            })
      ],
    );
  }
}
