import "package:flutter/material.dart";

import "../../../../../main.dart";
import "../../../../common/hover_button.dart";

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: HoverButton(
          onTap: () {
            onTap();
          },
          onDoubleTap: () {  },
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      );
}
