import "dart:math";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../../common/util/svg_manager.dart";
import "../../../../../root/app_router.dart";
import "../login/auth_cubit.dart";

class ImageLoader extends StatefulWidget {
  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: FadeTransition(
          opacity: _controller,
          child: AppDesign.buildLogo(context),
        ),
      );
}

class AppDesign {
  static Color getContrastingColor(final Color color) =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  static Widget buildCopyrightTextYear(final Color? bgColor) => Text(
        "Ⓒ 2024",
        style: AppStyles.copyrightStyle.copyWith(
            color: bgColor == null ? null : getContrastingColor(bgColor)),
      );

  static Widget buildCopyrightSection() => Column(
        children: [
          buildCopyrightTextYear(null),
          SvgManager.bandana(
              width: 8, height: 10, color: AppColors.fontOnBackground),
        ],
      );

  static Widget buildLogoLoader() =>
      Container(width: 270, height: 130, child: ImageLoader());

  static Widget buildLogoSmall(final BuildContext context) => GestureDetector(
        onTap: () {
          final router = AutoRouter.of(context);
          router.navigate(HelloRoute());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 20,
            child: SvgManager.logo(width: 8, height: 10),
          ),
        ),
      );

  static Widget buildLogo(final BuildContext context) => GestureDetector(
        onTap: () {
          final router = AutoRouter.of(context);
          router.navigate(HelloRoute());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: 40,
            width: 100,
            child: SvgManager.logo(width: 100, height: 40),
          ),
        ),
      );

  static Widget buildUserButton(final BuildContext context) {
    final getIt = GetIt.instance;
    final cubit = getIt.get<AuthenticationCubit>();
    final state = cubit.state;

    return AppDesign.buildBlueOutlinedButtonText(
        text: state.login ?? "",
        onPressed: () {
          cubit.signOut();
          final router = AutoRouter.of(context);
          router.navigate(
            MobileEraRoute(),
          );
        });
  }

  static Widget buildBlueOutlinedButtonText(
          {required final String text,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final bool wrapContent = true}) =>
      CustomOutlinedButton(
        text: text,
        onPressed: onPressed,
        styleType: ButtonStyleType.blue,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBlueFilledButtonText(
          {required final String text,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final bool wrapContent = true}) =>
      CustomFilledButton(
        text: text,
        onPressed: onPressed,
        styleType: ButtonStyleType.blue,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBlueFilledButton(
          {required final Widget child,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final EdgeInsetsGeometry? padding =
              const EdgeInsets.symmetric(horizontal: 4.0),
          final bool wrapContent = true}) =>
      CustomFilledButtonWidget(
        child: child,
        onPressed: onPressed,
        styleType: ButtonStyleType.blue,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildFilledButton(
          {required final ButtonStyleType styleType,
          required final Widget child,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final EdgeInsetsGeometry? padding =
              const EdgeInsets.symmetric(horizontal: 4.0),
          final bool wrapContent = true}) =>
      CustomFilledButtonWidget(
        child: child,
        onPressed: onPressed,
        styleType: styleType,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBeigeFilledButtonText(
          {required final String text,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final bool wrapContent = true}) =>
      CustomFilledButton(
        text: text,
        onPressed: onPressed,
        styleType: ButtonStyleType.beige,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBeigeOutlinedButtonText(
          {required final String text,
          required final VoidCallback onPressed,
          final bool wrapContent = true,
          final bool enabled = true}) =>
      CustomOutlinedButton(
        text: text,
        onPressed: onPressed,
        styleType: ButtonStyleType.beige,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBeigeFilledButton(
          {required final Widget child,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final bool wrapContent = true}) =>
      CustomOutlinedButtonWidget(
        child: child,
        onPressed: onPressed,
        styleType: ButtonStyleType.beige,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  static Widget buildBeigeOutlinedButton(
          {required final Widget child,
          required final VoidCallback onPressed,
          final bool enabled = true,
          final bool wrapContent = true}) =>
      CustomOutlinedButtonWidget(
        child: child,
        onPressed: onPressed,
        styleType: ButtonStyleType.beige,
        enabled: enabled,
        wrapContent: wrapContent,
      );

  /// Outlined input field with onChange callback
  static Widget buildOutlinedInputField({
    required final String hintText,
    required final ValueChanged<String> onChanged,
    final bool obscureText = false,
    final VoidCallback? onIconPressed,
    final TextInputType? keyboardType,
    final TextEditingController? controller,
  }) =>
      TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.placeholderStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.blueAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.blueAccent),
          ),
          suffixIcon: onIconPressed != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.blueAccent,
                  ),
                  onPressed: onIconPressed,
                )
              : null,
        ),
        style: AppStyles.inputTextStyle,
      );
}

class AppStyles {
  static final TextStyle inputTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    color: AppColors.blueAccent,
  );

  static final TextStyle beigeOutlinedButtonTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    color: AppColors.beigeAccent,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle beigeFilledButtonTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle blueFilledButtonTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.fontOnBackground,
  );
  static final TextStyle blueOutlinedButtonTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.blueAccent,
  );

  static final TextStyle titleStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.fontOnBackground,
    height: 1.4,
  );

  static final TextStyle bodyStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.fontOnBackground,
    height: 1.4,
  );

  static final TextStyle body3Style = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.blueAccent,
    height: 1.4,
  );
  static final TextStyle body2Style = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.blueAccent,
    height: 1.4,
  );

  static final TextStyle footerStyle = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    fontStyle: FontStyle.italic,
    color: AppColors.fontOnBackground,
    height: 1.4,
  );

  static final TextStyle copyrightStyle = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.fontOnBackground,
    height: 1.4,
  );

  static final TextStyle labelTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.fontOnBackground,
  );

  static final InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  );

  static final TextStyle placeholderStyle = TextStyle(
    fontSize: 14,
    color: AppColors.blueAccent,
  );
}

class AppColors {
  static const Color background = primaryBlack;

  static const Color blueAccent = Color(0xFF4A6FA5);
  static const Color beigeAccent = Color(0xFFE6D2B5);
  static const Color redBeigeAccent = Color(0xFFE2DAD6);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  //NEW
  static const Color primaryFont =
      Color(0xFF111315); // Dark black for main font
  static const Color secondaryFont =
      Color(0xFF292C2D); // Dark grey for secondary text
  static const Color tertiaryFont =
      Color(0xFF989898); // Light grey for less emphasis
  static const Color fontOnBackground = primaryWhite;

  static const Color primaryDarkGrey = Color(0xFF2A2C2D);
  static const Color primaryBlack = Color(0xFF111315);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color primaryMediumGrey = Color(0xFF676767);
  static const Color primaryLightGrey = Color(0xFFABABAB);

  // Accent Colors
  static const Color accentPeach = Color(0xFFF5D8C8);
  static const Color accentLightGrey = Color(0xFFDFE2E3);
  static const Color accentSoftBlue = Color(0xFFC6CCD9);
  static const Color accentBlueGrey = Color(0xFF709ED0);

  static Color getRandomColor({
    final List<Color> colors = const [
      accentPeach,
      accentLightGrey,
      accentSoftBlue,
      accentBlueGrey,

    ],
    final List<Color> previouslyUsedColors = const [],
  }) {
    // Create a new list excluding previously used colors
    final availableColors = colors
        .where((final color) => !previouslyUsedColors.contains(color))
        .toList();

    // If no available colors are left, reset to the full list
    if (availableColors.isEmpty) {
      return colors[Random().nextInt(colors.length)];
    }

    // Pick a random color from the available colors
    return availableColors[Random().nextInt(availableColors.length)];
  }
}

class ButtonStyleType {
  const ButtonStyleType._(
      this.name, this.color, this.textStyleFilled, this.textStyleOutlined);

  final String name;
  final Color color;

  final TextStyle textStyleFilled;
  final TextStyle textStyleOutlined;

  // Predefined styles
  static ButtonStyleType blue = ButtonStyleType._(
      'blue',
      AppColors.blueAccent,
      AppStyles.blueFilledButtonTextStyle,
      AppStyles.blueOutlinedButtonTextStyle);

  static ButtonStyleType beige = ButtonStyleType._(
      'beige',
      AppColors.beigeAccent,
      AppStyles.beigeFilledButtonTextStyle,
      AppStyles.beigeOutlinedButtonTextStyle);

  // Custom style
  factory ButtonStyleType.custom(String name, Color color,
      TextStyle textStyleFilled, TextStyle textStyleOutlined) {
    return ButtonStyleType._(
        'custom_$name', color, textStyleFilled, textStyleOutlined);
  }

  @override
  String toString() => 'ButtonStyleType(name: $name)';
}

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final bool wrapContent;
  final ButtonStyleType styleType;
  final EdgeInsetsGeometry? padding;

  CustomFilledButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.wrapContent = true,
    required this.styleType,
    this.padding,
    final Key? key,
  }) : super(key: key);

  Color get backgroundColor => enabled
      ? (styleType == ButtonStyleType.blue
          ? AppColors.blueAccent
          : AppColors.beigeAccent)
      : (styleType == ButtonStyleType.blue
          ? AppColors.blueAccent.withOpacity(0.5)
          : AppColors.beigeAccent.withOpacity(0.5));

  TextStyle get textStyle => enabled
      ? (styleType == ButtonStyleType.blue
          ? AppStyles.blueFilledButtonTextStyle
          : AppStyles.beigeFilledButtonTextStyle)
      : (styleType == ButtonStyleType.blue
          ? AppStyles.blueFilledButtonTextStyle
          : AppStyles.beigeFilledButtonTextStyle);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: wrapContent ? null : 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      );
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final bool wrapContent;
  final ButtonStyleType styleType;
  final EdgeInsetsGeometry? padding;

  const CustomOutlinedButton({
    required this.text,
    required this.onPressed,
    required this.styleType,
    this.enabled = true,
    this.wrapContent = true,
    this.padding,
    final Key? key,
  }) : super(key: key);

  Color get borderColor => enabled
      ? (styleType.color)
      : (styleType.color.withOpacity(0.5));

  TextStyle get textStyle => styleType.textStyleOutlined;

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: wrapContent ? null : 44,
        child: OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            side: BorderSide(color: borderColor, width: 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text, style: textStyle),
          ),
        ),
      );
}

class CustomFilledButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool enabled;
  final bool wrapContent;
  final ButtonStyleType styleType;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? customStyle;

  const CustomFilledButtonWidget({
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.wrapContent = true,
    required this.styleType,
    this.padding,
    this.customStyle,
    final Key? key,
  }) : super(key: key);

  Color get backgroundColor => enabled
      ? (styleType.color)
      : (styleType.color.withOpacity(0.5));

  TextStyle get textStyle => styleType.textStyleFilled;

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: wrapContent ? null : 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: customStyle ??
              ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
            child: child,
          ),
        ),
      );
}

class CustomOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool enabled;
  final bool wrapContent;
  final ButtonStyleType styleType;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? customStyle;

  const CustomOutlinedButtonWidget({
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.wrapContent = true,
    required this.styleType,
    this.padding,
    this.customStyle,
    final Key? key,
  }) : super(key: key);

  Color get borderColor => enabled
      ? (styleType == ButtonStyleType.blue
          ? AppColors.blueAccent
          : AppColors.beigeAccent)
      : (styleType == ButtonStyleType.blue
          ? AppColors.blueAccent.withOpacity(0.5)
          : AppColors.beigeAccent.withOpacity(0.5));

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: wrapContent ? null : 44,
        child: OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: customStyle ??
              OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                side: BorderSide(color: borderColor, width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0),
            child: child,
          ),
        ),
      );
}
