import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";

import "../../common/hover_button.dart";
import "../../root/app_router.dart";
import "../hello/base/base_screen.dart";
import "../hello/base/mobile_frame.dart";
import "../hello/base/responsive_state.dart";


@RoutePage()
class NotFoundScreen extends StatefulWidget {
  NotFoundScreen({super.key});

  final getIt = GetIt.instance;

  final cubit = NullCubit();

  @override
  _NotFoundScreenState createState() => _NotFoundScreenState(cubit);
}

class _NotFoundScreenState
    extends ResponsiveState<NotFoundScreen, NullState, NullCubit> {
  _NotFoundScreenState(super.cubit);

  @override
  Widget buildDesktopLayout(
          final BuildContext context, final NullState state) =>
      buildBody(state: state);

  @override
  Widget buildMobileLayout(final BuildContext context, final NullState state) =>
      buildBody(state: state);

  Widget buildBody({required final NullState state}) => BaseScreen(
    child: Center(
      child: MobileFrame(
              child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '404',
            style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 16),
          const Text(
            'The page you are looking for does not exist.',
            style: TextStyle(fontSize: 24, color: Colors.black),
            textAlign: TextAlign.center,

          ),
          const SizedBox(height: 32),
          HoverButton(
            onTap: () {
              final router = AutoRouter.of(context);
              router.navigate(HelloRoute());
            },
            onDoubleTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                "home",
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
              ),
            ),
    ),
  );
}

// Define a NullState that doesn't hold any specific data
class NullState {}

// Define a NullCubit that doesn't perform any actions
class NullCubit extends Cubit<NullState> {
  NullCubit() : super(NullState());
}
