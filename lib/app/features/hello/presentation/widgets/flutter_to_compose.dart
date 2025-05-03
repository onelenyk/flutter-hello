import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common/hover_button.dart';
import '../../../../common/link_utils.dart';
import '../../data/hello_state.dart';

class FlutterToCompose extends StatelessWidget {
  FlutterToCompose({super.key, required this.state});

  final HelloState state;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: HoverButton(
        onTap: () {
          openLink(state.composeHello.url, isNewTab: false);
        },
        onDoubleTap: () {},
        child: SizedBox(
          width: 40,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/compose.svg",
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
