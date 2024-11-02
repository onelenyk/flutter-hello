import "package:auto_route/annotations.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";

@RoutePage()
class AdminContainerScreen extends StatefulWidget {
  const AdminContainerScreen({super.key});

  @override
  State<AdminContainerScreen> createState() => _AdminContainerScreenState();
}

class _AdminContainerScreenState extends State<AdminContainerScreen> {
  @override
  Widget build(final BuildContext context) =>
      const AutoRouter();
}
