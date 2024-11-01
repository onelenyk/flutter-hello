import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/features/main/screen/notfound/not_found.dart";

import "base/base_screen.dart";
import "base/responsive_state.dart";

@RoutePage()
class MobileEraScreen extends StatefulWidget {
  MobileEraScreen({super.key});

  final getIt = GetIt.instance;
  late final NullCubit cubit = NullCubit();

  @override
  _MobileEraScreenState createState() => _MobileEraScreenState(cubit);
}

class _MobileEraScreenState
    extends ResponsiveState<MobileEraScreen, NullState, NullCubit> {
  _MobileEraScreenState(super.cubit);

  @override
  void onStateChange(
    final BuildContext context,
    final NullState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final NullState state,
  ) =>
      buildBody(state: state);

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final NullState state,
  ) =>
      buildBody(state: state);


  Widget buildBody({required final NullState state}) =>
      BaseScreen(child: AutoRouter());
}
