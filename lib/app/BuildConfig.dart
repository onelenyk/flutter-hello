import "dart:convert";
import "package:flutter/services.dart" show rootBundle;

import "env/environment.dart";

class BuildConfig {
  BuildConfig({
    required this.isProduction,
    this.enableLogging = true,
  });

  factory BuildConfig.fromJson(final Map<String, dynamic> json) => BuildConfig(
        isProduction: json["isProduction"],
        enableLogging: json["enableLogging"],
      );
  final bool isProduction;
  final bool enableLogging;
}

Future<BuildConfig> loadBuildConfig() async {
  final isProduction = getIsProduction();
  return BuildConfig(isProduction: isProduction);
}
