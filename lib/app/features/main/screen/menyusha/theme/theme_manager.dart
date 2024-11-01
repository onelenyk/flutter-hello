

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../../data/firebase/menu/menu_payload.dart";
import "../menu/menyusha_state.dart";

class MenuThemeManager {
  static MenuTheme commonLightTheme() {
    final TextStyle textStyle =
    GoogleFonts.openSans(fontSize: 14, color: Colors.white);

    return MenuTheme(
      titleStyle: textStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      groupTitleStyle: textStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      itemTitleStyle: textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      itemDescriptionStyle: textStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w100,
      ),
      itemPriceStyle: textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.black, // Example background color
    );
  }

  static MenuTheme commonDarkTheme() {
    final TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    );

    return MenuTheme(
      titleStyle: textStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      groupTitleStyle: textStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      itemTitleStyle: textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      itemDescriptionStyle: textStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      itemPriceStyle: textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white, // Example background color
    );
  }

  static MenuTheme getTheme(DesignPreset designPreset) {
    switch (designPreset) {
      case DesignPreset.SANTOKU:
        break;
      case DesignPreset.BBQ:
        break;
      case DesignPreset.BOSTON:
        break;
      case DesignPreset.VOLGA:
        break;
      case DesignPreset.CUSTOM:
        break;
      case DesignPreset.BANDANA:
        break;
    }
    return commonLightTheme();
  }
}

class MenuTheme {
  final TextStyle titleStyle;
  final TextStyle groupTitleStyle;
  final TextStyle itemTitleStyle;
  final TextStyle itemDescriptionStyle;
  final TextStyle itemPriceStyle;

  final Color backgroundColor; // Background color (optional)

  MenuTheme({
    required this.titleStyle,
    required this.groupTitleStyle,
    required this.itemTitleStyle,
    required this.itemDescriptionStyle,
    required this.itemPriceStyle,
    required this.backgroundColor,
  });
}