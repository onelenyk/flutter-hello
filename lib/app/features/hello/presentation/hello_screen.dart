import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:get_it/get_it.dart";
import 'package:google_fonts/google_fonts.dart';

import '../../../common/link_utils.dart';
import "../../../common/ui/powered_flutter.dart";
import "../../notfound/not_found.dart";
import "../base/base_screen.dart";
import "../base/circle_button.dart";
import "../base/mobile_width_frame.dart";
import "../base/responsive_state.dart";
import '../data/hello_state.dart';

@RoutePage()
class HelloScreen extends StatefulWidget {
  HelloScreen({
    super.key,
    this.onNextPage,
    this.onPreviousPage,
  });

  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;
  final getIt = GetIt.instance;
  final NullCubit cubit = NullCubit();

  @override
  _HelloScreenState createState() => _HelloScreenState(cubit);
}

class _HelloScreenState
    extends ResponsiveState<HelloScreen, NullState, NullCubit> {
  _HelloScreenState(super.cubit);

  @override
  void initState() {
    super.initState();
  }

  @override
  void onStateChange(final BuildContext context, final NullState state) {}

  @override
  Widget buildDesktopLayout(
          final BuildContext context, final NullState state) =>
      buildBody();

  @override
  Widget buildMobileLayout(final BuildContext context, final NullState state) =>
      buildBody();

  Widget buildBody() => HelloPage(
        onNextPage: widget.onNextPage,
        onPreviousPage: widget.onPreviousPage,
      );
}

class HelloPage extends StatefulWidget {
  const HelloPage({
    super.key,
    this.onNextPage,
    this.onPreviousPage,
  });

  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final String pageTitle = "Hello | Flutter";
  final HelloState state = HelloState();

  late Timer _timer;
  int _currentTranslationIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (final timer) {
      setState(() {
        _currentTranslationIndex =
            (_currentTranslationIndex + 1) % state.translations.length;
        state.currentTitle = state.translations[_currentTranslationIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BaseScreen(
        child: Container(
          color: Colors.white,
          child: HelloContent(state: state),
        ),
      );
}

class HelloContent extends StatelessWidget {
  HelloContent({super.key, required this.state});

  final HelloState state;

  Widget buildContacts({
    required final Function() telegram,
    required final Function() linkedin,
    required final Function() github,
    required final Function() resume,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleButton(
                size: 20,
                hoverColor: Colors.grey,
                rippleColor: Colors.grey,
                backgroundColor: Colors.transparent,
                onTap: telegram,
                child: const Icon(
                  Icons.telegram_rounded,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                style: GoogleFonts.robotoMono(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                "tg",
              ),
            ],
          ),
          const SizedBox(
            width: 8,
            height: 8,
          ),
          Column(
            children: [
              CircleButton(
                size: 20,
                hoverColor: Colors.grey,
                rippleColor: Colors.grey,
                backgroundColor: Colors.transparent,
                onTap: linkedin,
                child: const Icon(
                  FontAwesomeIcons.linkedinIn,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                style: GoogleFonts.robotoMono(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                "link",
              ),
            ],
          ),
          const SizedBox(
            width: 8,
            height: 8,
          ),
          Column(
            children: [
              CircleButton(
                size: 20,
                hoverColor: Colors.grey,
                rippleColor: Colors.grey,
                backgroundColor: Colors.transparent,
                onTap: github,
                child: const Icon(
                  FontAwesomeIcons.githubAlt,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                style: GoogleFonts.robotoMono(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                "git",
              ),
            ],
          ),
          const SizedBox(
            width: 8,
            height: 8,
          ),
          Column(
            children: [
              CircleButton(
                size: 20,
                hoverColor: Colors.grey,
                rippleColor: Colors.grey,
                backgroundColor: Colors.transparent,
                onTap: resume,
                child: const Icon(
                  FontAwesomeIcons.fileLines,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                style: GoogleFonts.robotoMono(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                "resume",
              ),
            ],
          ),
        ],
      );

  @override
  Widget build(final BuildContext context) => Center(
        child: MobileWidthFrame(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TitleItem(title: state.currentTitle),
                    StoryItem(story: state.shortStory),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: buildContacts(
                  telegram: () {
                    openLink(state.telegram.url);
                  },
                  linkedin: () {
                    openLink(state.linkedIn.url);
                  },
                  github: () {
                    openLink(state.gitHub.url);
                  },
                  resume: () {
                    downloadPdfFromAssets(
                      "assets/lenyk_resume_latest.pdf",
                    );
                  },
                ),
              ),
              PoweredByFlutterWidget(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
}

class TitleItem extends StatelessWidget {
  TitleItem({super.key, required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) => Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
}

class DescriptionItem extends StatelessWidget {
  DescriptionItem({super.key, required this.name, required this.position});

  final String name;
  final String position;

  Widget buildDefaultDescription() => Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: ", an ",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: position,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(final BuildContext context) => buildDefaultDescription();
}

class StoryItem extends StatelessWidget {
  StoryItem({super.key, required this.story});

  final String story;

  Widget buildDefaultShortStory() => Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "Use that as starting point for your Flutter app",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(final BuildContext context) => buildDefaultShortStory();
}
