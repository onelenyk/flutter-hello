import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/features/main/screen/menyusha/login/auth_cubit.dart";
import "package:menyusha/app/features/main/screen/menyusha/login/login_screen.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/sample_screen.dart";

import "../../../../../data/firebase/auth/auth_state.dart";
import "../../base/responsive_state.dart";
import "../a4_page_container.dart";
import "../theme/app_style.dart";

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  final getIt = GetIt.instance;
  late final AuthenticationCubit cubit = getIt.get<AuthenticationCubit>();

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState(cubit);
}

class _RegistrationScreenState extends ResponsiveState<RegistrationScreen,
    AuthState, AuthenticationCubit> {
  _RegistrationScreenState(super.cubit);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onStateChange(
    final BuildContext context,
    final AuthState state,
  ) {}

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final AuthState state,
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
    final AuthState state,
  ) =>
      buildBody(state: state);

  Widget buildBody({required final AuthState state}) => TemplateScreen(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLoginFormBody(context: context, state: state),
            SizedBox(height: 16),
            DividerWidget(width: 200, height: 1),
            SizedBox(height: 16),
            buildAuthMethods(),
          ],
        ),
      );

  /// Builds the login form with email and password fields
  Widget buildLoginFormBody(
      {required final BuildContext context, required final AuthState state}) {
    final bool isEnabledLogin;
    if (state is AuthInitial) {
      isEnabledLogin = state.email.isNotEmpty && state.password.isNotEmpty;
    } else {
      isEnabledLogin = false;
    }

    final bool isLoginLoading;
    if (state is AuthLoading) {
      isLoginLoading = true;
    } else {
      isLoginLoading = false;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppDesign.buildOutlinedInputField(
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (final value) => {widget.cubit.typeEmail(value)},
              controller: emailController),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppDesign.buildOutlinedInputField(
              hintText: "Password",
              obscureText: true,
              onChanged: (final value) => {widget.cubit.typePassword(value)},
              controller: passwordController),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppDesign.buildBeigeFilledButton(
                onPressed: () {
                  if (state is AuthInitial) {
                    widget.cubit.registerWithEmailAndPassword(
                        state.email, state.password);
                    return;
                  } else {
                    return;
                  }
                },
                child: SizedBox(
                  width: 150,
                  child: Center(
                      child: isLoginLoading
                          ? Center(
                              child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ))
                          : Text("Confirm",
                              style: AppStyles.beigeFilledButtonTextStyle)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  /// Builds social authentication methods, such as Google login
  Widget buildAuthMethods() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppDesign.buildBlueFilledButton(
              onPressed: widget.cubit.signInWithGoogle,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
}
