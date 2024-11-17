import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/features/main/screen/notfound/not_found.dart";

import "base/base_screen.dart";
import "base/responsive_state.dart";
import "menyusha/theme/app_style.dart";

@RoutePage()
class MobileEraScreen extends StatefulWidget {
  MobileEraScreen({super.key});

  @override
  _MobileEraScreenState createState() => _MobileEraScreenState();
}

class _MobileEraScreenState extends State<MobileEraScreen> {
  @override
  Widget build(final BuildContext context) => BaseEntryPointScreen(
        child: Container(
          child: AutoRouter(),
          color: AppColors.background,
        ),
      );
}
