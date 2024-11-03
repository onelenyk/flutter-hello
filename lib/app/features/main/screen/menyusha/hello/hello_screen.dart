import "dart:convert";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";
import "package:google_fonts/google_fonts.dart";
import "package:menyusha/app/features/main/screen/notfound/not_found.dart";
import "package:menyusha/app/root/app_router.dart";
import "package:uuid/uuid.dart";

import "../../../../../common/hover_button.dart";
import "../../../../../common/util/svg_manager.dart";
import "../../base/responsive_state.dart";
import "../theme/app_style.dart";

@RoutePage()
class HelloScreen extends StatefulWidget {
  HelloScreen({super.key});

  final getIt = GetIt.instance;
  final NullCubit cubit = NullCubit();

  @override
  _HelloScreenState createState() => _HelloScreenState(cubit);
}

class AppStyles {
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
}

class _HelloScreenState
    extends ResponsiveState<HelloScreen, NullState, NullCubit> {
  _HelloScreenState(super.cubit);

  @override
  void onStateChange(BuildContext context, NullState state) {}

  @override
  Widget buildDesktopLayout(BuildContext context, NullState state) => buildBody();

  @override
  Widget buildMobileLayout(BuildContext context, NullState state) => buildBody();

  Widget buildBody() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppDesign.buildLogo(context),
              const SizedBox(height: 16.0),
              _buildTextSection(),
              const SizedBox(height: 16.0),
              _buildRegistrationRow(),
              const SizedBox(height: 66.0),
              _buildFooterText(),
              const SizedBox(height: 32.0),
            //  const Spacer(),

              _buildCopyrightSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/localmenu.png',
      width: 270,
      height: 130,
    );
  }

  Widget _buildTextSection() {
    return Column(
      children: [
        Text(
          'Вітаю на сторінці нашого проєкту — онлайн-меню, створеного для кафе, ресторанів та інших закладів.',
          style: AppStyles.titleStyle,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8.0),
        Text(
          'Ми допомагаємо легко налаштовувати меню, ділитися ним з клієнтами та підтримувати актуальність всього за кілька кроків.',
          style: AppStyles.bodyStyle,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildRegistrationRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            'Щоб почати створення власного меню, пройдіть просту реєстрацію. Натисніть кнопку, щоб розпочати!',
            style: AppStyles.bodyStyle,
          ),
        ),
        const SizedBox(width: 8.0),
        _buildHoverButton(),
      ],
    );
  }

  Widget _buildHoverButton() {
    return HoverButton(
      onDoubleTap: () {},
      hoverColor: Colors.transparent,
      color: Colors.transparent,
      onTap: () {
        final router = AutoRouter.of(context);
        router.navigate(LoginRoute());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.arrow_forward, color: Colors.black),
            const SizedBox(width: 4.0),
            Text(
              'Увійти',
              style: AppStyles.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Text(
      'Застосунок знаходиться у розробці, але скоро ви зможете легко створювати меню, ділитися ним та оновлювати його в зручному інтерфейсі.',
      style: AppStyles.footerStyle,
      textAlign: TextAlign.start,
    );
  }

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
}