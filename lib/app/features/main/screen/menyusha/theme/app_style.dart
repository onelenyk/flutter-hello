import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";

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
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _controller,
        child: AppDesign.buildLogo(),
      ),
    );
  }
}

class AppDesign {
  static Widget buildLogoLoader() => Container(
      width: 270,
      height: 130,
      child: ImageLoader());

  static Widget buildLogo() => Image.asset(
        'assets/images/localmenu.png',
        width: 270,
        height: 130,
      );

  static Widget buildUserButton(BuildContext context) {
    final getIt = GetIt.instance;
    final cubit = getIt.get<AuthenticationCubit>();
    final state = cubit.state;

    return AppDesign.buildBlueOutlinedButton(
        child: Text(
          state.login ?? "",
          style: AppStyles.blueOutlinedButtonTextStyle,
        ),
        onPressed: () {
          cubit.signOut();
          final router = AutoRouter.of(context);
          router.navigate(
            MobileEraRoute(),
          );
        });
  }

  static Widget buildBlueFilledButton({
    required final Widget child,
    required final VoidCallback onPressed,
    final bool enabled = true,
    final EdgeInsetsGeometry? padding =
        const EdgeInsets.symmetric(horizontal: 4.0),
  }) =>
      SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled
                ? AppColors.blueAccent
                : AppColors.blueAccent
                    .withOpacity(0.5), // Dimmed color when disabled
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      );

  static Widget buildOutlinedButton({
    required final Widget child,
    required final VoidCallback onPressed,
    final bool enabled = true,
    final EdgeInsetsGeometry? padding =
        const EdgeInsets.symmetric(horizontal: 4.0),
    final Color backgroundColor = AppColors.blueAccent,
    final Color backgroundColorInactive = AppColors.blueAccent,
  }) =>
      SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            side: BorderSide(
                color: enabled
                    ? backgroundColor
                    : backgroundColorInactive.withOpacity(0.5),
                width: 2.0),
            // Beige border color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      );

  static Widget buildBlueOutlinedButton({
    required final Widget child,
    required final VoidCallback onPressed,
    final bool enabled = true,
    final EdgeInsetsGeometry? padding =
        const EdgeInsets.symmetric(horizontal: 4.0),
  }) =>
      SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            side: BorderSide(
                color: enabled
                    ? AppColors.blueAccent
                    : AppColors.blueAccent.withOpacity(0.5),
                width: 2.0),
            // Beige border color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      );

  static Widget buildBeigeFilledButton({
    required final Widget child,
    required final VoidCallback onPressed,
    final bool enabled = true,
    final EdgeInsetsGeometry? padding =
        const EdgeInsets.symmetric(horizontal: 4.0),
  }) =>
      SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled
                ? AppColors.beigeAccent
                : AppColors.beigeAccent.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      );

  static Widget buildBeigeOutlinedButton({
    required final Widget child,
    required final VoidCallback onPressed,
    final EdgeInsetsGeometry? padding =
        const EdgeInsets.symmetric(horizontal: 4.0),
  }) =>
      SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            side: BorderSide(color: AppColors.beigeAccent, width: 2.0),
            // Beige border color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
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
    color: AppColors.white,
  );
  static final TextStyle blueOutlinedButtonTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.blueAccent,
  );

  static final TextStyle titleStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.4,
  );

  static final TextStyle bodyStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
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
    color: Colors.black,
    height: 1.4,
  );

  static final TextStyle copyrightStyle = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.4,
  );

  static final TextStyle labelTextStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
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
  static const Color blueAccent = Color(0xFF4A6FA5);
  static const Color beigeAccent = Color(0xFFE6D2B5);
  static const Color redBeigeAccent = Color(0xFFE2DAD6);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
