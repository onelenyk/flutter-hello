import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    required this.child,
    this.backgroundColor = Colors.white,
    super.key,
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(final BuildContext context) => Container(
    color: backgroundColor,
    child: child,
  );
}


class BaseEntryPointScreen extends StatelessWidget {
  const BaseEntryPointScreen({
    required this.child,
    this.backgroundColor = Colors.white,
    super.key,
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Container(
          child: Center(child: Container(
              child: AppDesign.buildLogo())),
        ),
        Container(
          child: child,
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );
}
