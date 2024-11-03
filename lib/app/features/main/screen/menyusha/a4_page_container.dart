import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class A4PageContainer extends StatelessWidget {
  // Background color of the container
  A4PageContainer({required this.child, this.color = Colors.white});

  final Widget child; // Child widget to be placed inside the container
  final Color color;

  @override
  Widget build(final BuildContext context) {
    // Get the total available height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    // A4 aspect ratio: 210 mm (width) : 297 mm (height) => 1 : 1.414
    final aspectRatio = 210 / 297;

    // Calculate the width based on the height and aspect ratio
    final pageWidth = screenHeight * aspectRatio;

    return Center(
      child: Container(
          width: pageWidth,
          height: screenHeight,
          color: color,
          child: Center(child: child)),
    );
  }
}


class A4PageWidthContainer extends StatelessWidget {
  // Background color of the container
  A4PageWidthContainer({required this.child, this.color = Colors.white});

  final Widget child; // Child widget to be placed inside the container
  final Color color;

  @override
  Widget build(final BuildContext context) {
    // Get the total available height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    // A4 aspect ratio: 210 mm (width) : 297 mm (height) => 1 : 1.414
    final aspectRatio = 210 / 297;

    // Calculate the width based on the height and aspect ratio
    final pageWidth = screenHeight * aspectRatio;

    return Center(
      child: Container(
          width: pageWidth,
          color: color,
          child: Center(child: child)),
    );
  }
}
