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
  Widget _buildCopyrightSection() {
    return Column(
      children: [
        Text(
          "Ⓒ 2024",
          style: AppStyles.copyrightStyle,
        ),
        SvgManager.bandana(width: 8, height: 10),
      ],
    );
  }

  Widget buildBody() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppDesign.buildLogo(context),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      Placeholder(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                  color: Colors.lightGreen,
                ),
                _buildCopyrightSection(),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(final BuildContext context) =>
      A4PageContainer(child: buildBody());
}
