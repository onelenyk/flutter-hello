import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:menyusha/app/features/main/screen/menyusha/a4_page_container.dart";
import "package:menyusha/app/features/main/screen/menyusha/hello/hello_screen.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";

import "../../../../../common/util/svg_manager.dart";

@RoutePage()
class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  Widget buildContent() =>
      Container(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Placeholder(),
            SizedBox(height: 16.0),
          ],
        ),
        color: Colors.lightGreen,
      );

  Widget buildBody() =>
      TemplateScreen(child: buildContent());

  @override
  Widget build(final BuildContext context) =>
      A4PageContainer(child: buildBody());
}

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({required this.child, super.key});

  final Widget child;

  Widget buildContent() =>
      Container(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            child,
            const SizedBox(height: 16.0),
          ],
        ),
      );

  Widget buildBody(final BuildContext context) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppDesign.buildLogo(context),
                buildContent(),
                AppDesign.buildCopyrightSection(),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(final BuildContext context) =>
      buildBody(context);
}


class TemplateScreenAdmin extends StatelessWidget {
  const TemplateScreenAdmin({required this.child, super.key});

  final Widget child;

  Widget buildContent() =>
      Container(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            child,
            const SizedBox(height: 16.0),
          ],
        ),
      );

  Widget buildBody(final BuildContext context) =>
      Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppDesign.buildLogo(context),
                    AppDesign.buildUserButton(context),
                  ],
                ),
              ),
              buildContent(),
              AppDesign.buildCopyrightSection(),
            ],
          ),
        ),
      );

  @override
  Widget build(final BuildContext context) =>
      buildBody(context);
}

