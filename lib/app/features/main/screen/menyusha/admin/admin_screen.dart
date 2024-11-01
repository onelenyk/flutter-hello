import "dart:ui";

import "package:auto_route/annotations.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/common/link_utils.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../../data/firebase/auth/auth_state.dart";
import "../../../../../data/firebase/menu/menu_payload.dart";
import "../../../../../root/app_router.dart";
import "../login/auth_cubit.dart";
import "../../base/responsive_state.dart";
import "../a4_page_container.dart";
import "../login/login_screen.dart";
import "../menu/menu_screen.dart";
import "../theme/app_style.dart";
import "admin_cubit.dart";
import "admin_state.dart";
import "create_menu/create_dialog.dart";

@RoutePage()
class AdminScreen extends StatefulWidget {
  AdminScreen({super.key});

  final getIt = GetIt.instance;
  late final AdminCubit cubit = getIt.get<AdminCubit>();

  @override
  _AdminScreenState createState() => _AdminScreenState(cubit);
}

class _AdminScreenState
    extends ResponsiveState<AdminScreen, AdminState, AdminCubit> {
  _AdminScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final AdminState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final AdminState state,
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
    final AdminState state,
  ) =>
      buildBody(state: state);

  Widget buildUserButton({required final AdminState state}) {
    return AppDesign.buildBlueOutlinedButton(
        child: Text(
          state.authState?.login ?? "",
          style: AppStyles.blueOutlinedButtonTextStyle,
        ),
        onPressed: () {
          widget.cubit.signOut();
          final router = AutoRouter.of(context);
          // Use pushAndRemoveUntil with the root route
          router.navigate(
            MobileEraRoute(),
          );
        });
  }

  Widget _buildDescription() {
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

  Widget buildBody({required final AdminState state}) {
    final reachLimit = (state.items.length >= 3);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppDesign.buildLogo(),
            buildUserButton(state: state),
          ],
        ),
        _buildDescription(),
        Column(
          children: state.items.map((item) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Design Preset: ${item.menu.designPreset.name} Public id: ${item.publicId}")
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: AppColors.blueAccent,
                ),
                onPressed: () => cubit.deleteMenu(payload: item),
              ),
              onTap: () {
               /* final router = AutoRouter.of(context);
                router.push(
                  PublicMenuRoute(id: item.publicId),
                );*/
                launchInternalPage(
                    item.publicId, isNewTab: true
                );
              //  openLink()
              },
            );
          }).toList(),
        ),
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

Future<void> launchInternalPage(String id, {bool isNewTab = true}) async {
  final baseUrl = Uri.base.origin.toString(); // Gets the base URL of your app
  final url = '$baseUrl/$id'; // Appends the id to your base URL
  await launchUrl(
    Uri.parse(url),
    webOnlyWindowName: isNewTab ? '_blank' : '_self',
  );
}