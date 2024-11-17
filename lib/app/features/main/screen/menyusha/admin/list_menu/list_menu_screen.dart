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
import "package:menyusha/app/features/main/screen/menyusha/theme/sample_screen.dart";
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
      A4PageContainer(
        child: buildBody(state: state),
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
            "Список меню:",
            style: AppStyles.body2Style,
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  final List<Color> usedColors = [];

  Color getRandomUnusedColor() {
    final colors = [
      AppColors.accentSoftBlue,
      AppColors.accentPeach,
      AppColors.accentBlueGrey,
      AppColors.accentLightGrey,
    ];
    final defaultColors = [
      AppColors.accentSoftBlue,
      AppColors.accentPeach,
      AppColors.accentBlueGrey,
      AppColors.accentLightGrey,
    ].map((final item) => item.withOpacity(0.6)).toList();

    final randomColor = AppColors.getRandomColor(
      colors: colors + defaultColors,
      previouslyUsedColors: usedColors,
    );

    // Add the color to the used list
    usedColors.add(randomColor);

    // Return the random unused color
    return randomColor;
  }

  Future<String> getUrlNameString(final String id) async {
    final baseUrl = Uri.base.origin.toString(); // Gets the base URL of your app
    final url = "$baseUrl/$id"; // Appends the id to your base URL
    return url;
  }

  Widget buildMenuItem({required final MenuPayload item}) {
    final randomColor = getRandomUnusedColor();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppDesign.buildFilledButton(
        styleType: ButtonStyleType.custom(
            "name",
            randomColor,
            AppStyles.blueFilledButtonTextStyle,
            AppStyles.blueOutlinedButtonTextStyle),
        wrapContent: true,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        item.title,
                        style: AppStyles.body2Style
                            .copyWith(color: AppColors.primaryBlack),
                      ),
                    ),
                    Container(
                      child: Text(
                        style: AppStyles.bodyStyle.copyWith(
                            color: AppColors.primaryDarkGrey, fontSize: 16),
                        "Public url: ${item.name}",
                      ),
                    ),
                  ],
                ),
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
        },
      ),
    );
  }

  Widget buildAddItem({required VoidCallback onAddItem}) {
    return AppDesign.buildFilledButton(
        styleType: ButtonStyleType.blue,
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 32),
        ),
        onPressed: () {
          onAddItem();
        });
  }

  Widget buildBody({required final ListMenuState state}) {
    final listSize = state.items.length;

    final reachLimit = listSize >= 3;
    final showAddOption = !reachLimit;

    return TemplateScreenAdmin(
        child: Column(
      children: [
        buildDescription(),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0, // Adjust as needed
          ),
          itemCount: listSize + 1, // Add one for the "plus" item
          itemBuilder: (context, index) {
            final isRegularItem = index < listSize;
            if (isRegularItem) {
              // Build regular menu item
              return buildMenuItem(item: state.items[index]);
            } else if (showAddOption) {
              // Build "plus" item
              return buildAddItem(onAddItem: () {
                // Add your logic to handle adding a new item
                setState(() {
                  final router = AutoRouter.of(context);
                  // Use pushAndRemoveUntil with the root route
                  router.navigate(
                    CreateMenuRoute(),
                  );
                });
              });
            } else {
              return Container();
            }
          },
        ),

/*        Column(
          children: state.items.map((item) {
            return buildMenuItem(item: item);
          }).map((item) {
            return item;
          }).toList(),
        ),*/
        SizedBox(height: 64.0),
        AppDesign.buildBlueOutlinedButtonText(
            text: "DESIGN PREVIEW",
            enabled: !reachLimit,
            onPressed: () {
              final router = AutoRouter.of(context);
              // Use pushAndRemoveUntil with the root route
              router.navigate(
                PreviewRoute(),
              );
            }),
        AppDesign.buildBlueOutlinedButtonText(
            text: "DESIGN SAMPLE",
            enabled: !reachLimit,
            onPressed: () {
              final router = AutoRouter.of(context);
              // Use pushAndRemoveUntil with the root route
              router.navigate(
                SampleRoute(),
              );
            })
      ],
    ));
  }
}
