import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:menyusha/app/features/main/screen/menyusha/a4_page_container.dart";
import "package:menyusha/app/features/main/screen/menyusha/hello/hello_screen.dart";
import "package:menyusha/app/features/main/screen/menyusha/theme/app_style.dart";

import "../../../../../common/util/svg_manager.dart";

@RoutePage()
class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
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

  Widget wrap({required final Widget child}) => Container(
        child: child,
        constraints: new BoxConstraints(
          minWidth: 400.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      );

  @override
  Widget build(final BuildContext context) => A4PageContainer(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            wrap(child: AppDesign.buildLogo(context)),
            SizedBox(
              height: 16,
            ),
            wrap(child: AppDesign.buildLogoSmall(context)),
            SizedBox(
              height: 16,
            ),
            wrap(
              child: AppDesign.buildBlueOutlinedButton(
                  child: true
                      ? Text(
                          'Ліміт досягнуто',
                          style: AppStyles.blueOutlinedButtonTextStyle.copyWith(
                              color: AppColors.blueAccent.withOpacity(0.5)),
                        )
                      : Text(
                          'Створити нове меню',
                          style: AppStyles.blueOutlinedButtonTextStyle,
                        ),
                  enabled: true,
                  onPressed: () {
                    final router = AutoRouter.of(context);
                    // Use pushAndRemoveUntil with the root route
                  }),
            ),
            SizedBox(
              height: 16,
            ),
            wrap(
              child: AppDesign.buildBlueFilledButton(
                  child: Text(
                    "PREVIEW",
                    style: AppStyles.blueFilledButtonTextStyle,
                  ),
                  enabled: true,
                  onPressed: () {}),
            ),
            SizedBox(
              height: 16,
            ),
            wrap(
              child: AppDesign.buildBeigeFilledButton(
                  onPressed: () {},
                  child: SizedBox(
                    width: 150,
                    child: Center(
                      child: Text("Registration",
                          style: AppStyles.beigeFilledButtonTextStyle),
                    ),
                  ),
                  wrapContent: true),
            ),

            SizedBox(
              height: 16,
            ),
            wrap(
              child: AppDesign.buildBeigeOutlinedButton(
                  child: Text(
                    'Ліміт досягнуто',
                    style: AppStyles.beigeOutlinedButtonTextStyle.copyWith(),
                  ),
                  onPressed: () {
                    final router = AutoRouter.of(context);
                    // Use pushAndRemoveUntil with the root route
                  }),
            ),

            wrap(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppDesign.buildOutlinedInputField(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (final value) => {
                      
                    },
                    controller: TextEditingController()),
              ),
            ),

            wrap(child: _buildCopyrightSection()),
            SizedBox(
              height: 16,
            ),

          ],
        ),
      );
}
