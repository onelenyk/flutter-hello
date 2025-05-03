import 'package:flutter/material.dart';

class MobileWidthFrame extends StatelessWidget {
  const MobileWidthFrame({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: 350,
        child: child,
      );
}
