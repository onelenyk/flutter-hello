import "package:flutter/material.dart";

class CircleButton extends StatefulWidget {
  const CircleButton(
      {super.key,
      required this.size,
      required this.hoverColor,
      required this.rippleColor,
      required this.backgroundColor,
      required this.onTap,
      required this.child});

  final Widget child;
  final double size;
  final Color hoverColor;
  final Color rippleColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isHovering = false;

  @override
  Widget build(final BuildContext context) => Stack(
        children: [
          Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                  color: widget.backgroundColor, shape: BoxShape.circle),
              child: widget.child),
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  color: _isHovering
                      ? widget.hoverColor.withOpacity(0.4)
                      : Colors.transparent,
                  shape: BoxShape.circle),
              child: Material(
                type: MaterialType.circle,
                color: Colors.transparent,
                child: InkWell(
                  onHover: (final value) {
                    setState(() {
                      _isHovering = value;
                    });
                  },
                  hoverColor: Colors.transparent,
                  customBorder: const CircleBorder(),
                  splashColor: widget.rippleColor.withOpacity(0.4),
                  // Customize ripple color and opacity
                  onTap: widget.onTap, // Handle tap
                ),
              ),
            ),
          ),
        ],
      );
}
