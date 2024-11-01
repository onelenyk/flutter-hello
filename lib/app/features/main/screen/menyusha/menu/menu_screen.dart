import "package:auto_route/annotations.dart";
import 'package:flutter/material.dart';
import "package:get_it/get_it.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";

import "../../../../../data/firebase/menu/menu_payload.dart";
import "../../../../../data/firebase/menu/menu_payload_repository.dart";
import "../../base/base_screen.dart";
import "../../base/responsive_state.dart";
import "../theme/theme_manager.dart";
import "menyusha_cubit.dart";
import "menyusha_state.dart";

import 'package:flutter/material.dart';

@RoutePage()
class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  final getIt = GetIt.instance;
  late final MenyushaCubit cubit = getIt<MenyushaCubit>();

  @override
  _MenyushaScreenState createState() => _MenyushaScreenState(cubit);
}
///ui
class _MenyushaScreenState
    extends ResponsiveState<MenuScreen, MenyushaState, MenyushaCubit> {
  _MenyushaScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final MenyushaState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final MenyushaState state,
  ) =>
      buildBody(state: state);

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final MenyushaState state,
  ) =>
      buildBody(state: state);

  Widget buildBody({required final MenyushaState state}) {

    return BaseScreen(
        child: Container(
      color: Colors.white,
      child: Center(child: Container()),
    ));
  }
}
