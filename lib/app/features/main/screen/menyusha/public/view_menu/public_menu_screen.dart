import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:menyusha/app/features/main/screen/menyusha/menu/menyusha_renderer.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/public/view_menu/public_menu_state.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";
import "package:menyusha/app/root/app_router.dart";
import "package:uuid/uuid.dart";

import "../../../base/base_screen.dart";
import "../../../base/responsive_state.dart";
import "../../a4_page_container.dart";
import "../../theme/theme_manager.dart";

import 'dart:html' as html;

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
  ) {
    if (state.menuLoadingFailed) {
      final router = AutoRouter.of(context);
      router.navigate(
        NotFoundRoute(),
      );
    }
  }

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
    if (state.loadedMenu == null) {
      return A4PageContainer(child: AppDesign.buildLogoLoader());
    } else {
      final theme =
          MenuThemeManager.getTheme(state.loadedMenu!.menu.designPreset);

      return SingleChildScrollView(
        child: Column(
          children: [
            A4PageWidthContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    AppDesign.buildLogoSmall(context),
                  ],
                ),
              ),
              color: theme.backgroundColor,
            ),
            Container(
                child: Title(
              title: state.loadedMenu!.title,
              color: Colors.black,
              child: MenuRendererWidget(
                menu: state.loadedMenu!.menu,
              ),
            )),
          ],
        ),
      );
    }
  }
}

class SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Skeleton Logo
                SkeletonWidget(
                  width: 350,
                  height: 100,
                  borderRadius: BorderRadius.circular(8.0),
                  animationType: AnimationType.blink,
                ),
                SizedBox(height: 16),

                // Group 1 Header
                SkeletonWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                SizedBox(height: 15),

                // Skeleton Items
                for (int i = 0; i < 2; i++) ...[
                  SkeletonItem(),
                ],

                // Group 2 Header
                SkeletonWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                SizedBox(height: 15),

                // Skeleton Items
                for (int i = 0; i < 3; i++) ...[
                  SkeletonItem(),
                ],

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
}

class SkeletonWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final AnimationType animationType;

  const SkeletonWidget({
    required this.width,
    required this.height,
    required this.borderRadius,
    this.animationType = AnimationType.loading,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1300),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: animationType == AnimationType.blink
          ? Opacity(
              opacity: 0.8,
              child: Container(color: Colors.grey[200]),
            )
          : null,
    );
  }
}

class SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonWidget(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 20,
            borderRadius: BorderRadius.circular(4.0),
          ),
          SizedBox(height: 10),
          SkeletonWidget(
            width: MediaQuery.of(context).size.width,
            height: 15,
            borderRadius: BorderRadius.circular(4.0),
          ),
          SizedBox(height: 8),
          SkeletonWidget(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 20,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ],
      ),
    );
  }
}

enum AnimationType {
  loading,
  blink,
}
