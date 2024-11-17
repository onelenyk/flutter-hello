import "package:auto_route/auto_route.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:menyusha/app/common/info_block.dart";
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
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      );

  @override
  Widget build(final BuildContext context) => A4PageContainer(
        child: SingleChildScrollView(
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
                child: AppDesign.buildBlueOutlinedButtonText(
                    text: "Ліміт досягнуто",
                    enabled: true,
                    onPressed: () {
                      final router = AutoRouter.of(context);
                      // Use pushAndRemoveUntil with the root route
                    }),
              ),
              SizedBox(
                height: 16,
              ),
          /*            wrap(
                child: AppDesign.buildBlueFilledButton(
                    child: Text(
                      "PREVIEW",
                      style: AppStyles.blueFilledButtonTextStyle,
                    ),
                    enabled: true,
                    onPressed: () {}),
              ),*/
              SizedBox(
                height: 16,
              ),
              wrap(
                child: AppDesign.buildBeigeFilledButtonText(
                    onPressed: () {}, text: "Registration", wrapContent: true),
              ),
              SizedBox(
                height: 16,
              ),
              wrap(
                child: AppDesign.buildBeigeOutlinedButtonText(
                    text: "Ліміт досягнуто",
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
                      onChanged: (final value) => {},
                      controller: TextEditingController()),
                ),
              ),
              wrap(child: _buildCopyrightSection()),
              SizedBox(
                height: 16,
              ),
              wrap(
                  child: InfoBlock(
                color: AppColors.beigeAccent,
                child: SizedBox(
                  width: 100,
                  height: 100,
                ),
              )),
          
              SizedBox(
                height: 16,
              ),
              wrap(
                  child: InfoBlock(
                    color: AppColors.blueAccent,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              wrap(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.beigeAccent,
                      )),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              wrap(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.blueAccent,
                      )),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Primary Colors",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: primaryColors.map((color) => ColorBox(color)).toList(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Accent Colors",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: accentColors.map((color) => ColorBox(color)).toList(),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      );
}



class ColorBox extends StatelessWidget {
  final ColorDetails colorDetails;

  ColorBox(this.colorDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: colorDetails.color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 4),
        Text(
          colorDetails.hexCode,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class ColorDetails {
  final Color color;
  final String hexCode;

  ColorDetails(this.color, this.hexCode);
}

List<ColorDetails> primaryColors = [
  ColorDetails(Color(0xFF111315), "#111315"),
  ColorDetails(Color(0xFF292C2D), "#292C2D"),
  ColorDetails(Color(0xFFFFFFFF), "#FFFFFF"),
  ColorDetails(Color(0xFF676767), "#676767"),
  ColorDetails(Color(0xFF767676), "#767676"),
];

List<ColorDetails> accentColors = [
  ColorDetails(Color(0xFFCFDDBB), "#CFDDBB"),
  ColorDetails(Color(0xFFE4CDED), "#E4CDED"),
  ColorDetails(Color(0xFFC2DBE9), "#C2DBE9"),
  ColorDetails(Color(0xFFF1CBD0), "#F1CBD0"),
  ColorDetails(Color(0xFFC9CAEF), "#C9CAEF"),
];
