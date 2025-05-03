import "package:flutter/material.dart";

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    required this.child,
    super.key,
    this.color = Colors.white,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(child: child),
        backgroundColor: color,
      );
}
