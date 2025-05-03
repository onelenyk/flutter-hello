import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.label,
    this.iconSize = 20,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String label;
  final double iconSize;

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          IconButton(
            icon: Icon(
              icon,
              color: Colors.black,
              size: iconSize,
            ),
            onPressed: onTap,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.robotoMono(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
}
