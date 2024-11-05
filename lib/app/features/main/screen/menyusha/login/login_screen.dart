import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/common/hover_button.dart";
import "package:menyusha/main.dart";

import "../../../../../common/info_block.dart";
import "../../../../../data/firebase/auth/auth_state.dart";
import "auth_cubit.dart";
import "../../../../../root/app_router.dart";
import "../../base/responsive_state.dart";
import "dart:math" as math;

import "../a4_page_container.dart";
import "../theme/app_style.dart";

@RoutePage()
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final getIt = GetIt.instance;

  late final AuthenticationCubit cubit = getIt<AuthenticationCubit>();

  @override
  _LoginScreenState createState() => _LoginScreenState(cubit);
}

class _LoginScreenState
    extends ResponsiveState<LoginScreen, AuthState, AuthenticationCubit> {
  _LoginScreenState(super.cubit);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // Check initial auth state when the widget starts
    if (widget.cubit.state is AuthSuccess) {
      final router = AutoRouter.of(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        router.navigate(AdminContainerRoute());
      });
    }
  }

  @override
  void onStateChange(
    final BuildContext context,
    final AuthState state,
  ) {
    if (state is AuthSuccess) {
      // Navigate to the home screen or any other screen on successful login
      final router = AutoRouter.of(context);

      router.navigate(AdminContainerRoute());
      print("AuthenticationSuccess: Navigating to home");
    } else if (state is AuthFailed) {
      // Show a snackbar or dialog with the error message
      final snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoBlock(
              width: 350,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black26.withAlpha(80),
              child: Text(state.error ?? 'Authentication Failed',
                  style: GoogleFonts.robotoMono(
                      color: AppColors.blueAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 12)),
            ),
          ],
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("AuthenticationFailure: ${state.error}");
      widget.cubit
          .restoreFailedLogin(emailController.text, passwordController.text);
    } else if (state is AuthSignedOut) {
      context.router.replace(HelloRoute());
    }
  }

  @override
  Widget buildDesktopLayout(
    final BuildContext context,
    final AuthState state,
  ) =>
      Container(
        child: A4PageContainer(
          child: buildBody(context: context, state: state),
          color: Colors.white,
        ),
        color: Colors.white,
      );

  @override
  Widget buildMobileLayout(
    final BuildContext context,
    final AuthState state,
  ) =>
      buildBody(context: context, state: state);

  Widget buildBody(
          {required final BuildContext context,
          required final AuthState state}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDesign.buildLogo(context),
          buildLoginFormBody(context: context, state: state),
          SizedBox(height: 16),
          DividerWidget(width: 200, height: 1),
          SizedBox(height: 16),
          buildAuthMethods(),
        ],
      );

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
              AppDesign.buildBlueFilledButton(
                  onPressed: () {
                    if (state is AuthInitial) {
                      widget.cubit.signInWithEmailAndPassword(
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
                          : Text("Login",
                              style: AppStyles.blueFilledButtonTextStyle),
                    ),
                  ),
                  wrapContent: true,
                  enabled: isEnabledLogin),
              SizedBox(height: 8.0),
              AppDesign.buildBeigeFilledButton(
                  onPressed: () {
                    final router = AutoRouter.of(context);
                    router.navigate(RegistrationRoute());
                  },
                  child: SizedBox(
                    width: 150,
                    child: Center(
                      child: Text("Registration",
                          style: AppStyles.beigeFilledButtonTextStyle),
                    ),
                  ),
                  wrapContent: true),
              if (!buildConfig.isProduction)
                Column(
                  children: [
                    SizedBox(height: 8.0),
                    AppDesign.buildBeigeFilledButton(
                        onPressed: () {
                          if (state is AuthInitial) {
                            widget.cubit
                                .adminSignIn(state.email, state.password);
                            return;
                          } else {
                            return;
                          }
                        },
                        child: SizedBox(
                          width: 150,
                          child: Center(
                            child: Text("Admin sign in",
                                style: AppStyles.beigeFilledButtonTextStyle),
                          ),
                        ),
                        wrapContent: true)
                  ],
                )
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

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
                wrapContent: true),
          ],
        ),
      );
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
    required this.width,
    this.height = 1,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
    );
  }
}

class WidgetSwitcher extends HookWidget {
  final Widget widget1;
  final Widget widget2;
  final bool showWidget;

  WidgetSwitcher(
      {required this.widget1, required this.widget2, required this.showWidget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          widget1,
          Visibility(
            visible: !showWidget,
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                DividerWidget(
                  width: 64,
                ),
                SizedBox(
                  height: 8,
                ),
                widget2
              ],
            ),
          ),
          /*   AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: showWidget
                ? widget1
                : Column(
                    children: [
                      widget1,
                      SizedBox(
                        height: 8,
                      ),
                      DividerWidget(),
                      SizedBox(
                        height: 8,
                      ),
                      widget2
                    ],
                  ),
          ),*/
        ],
      ),
    );
  }
}
