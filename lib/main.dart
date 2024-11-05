import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";

import "package:menyusha/app/env/environment.dart";
import "package:menyusha/app/root/root_component.dart";
import "package:menyusha/firebase_options.dart";

import "app/BuildConfig.dart";

///Public firebase
late final FirebaseApp firebaseApp;

///Public firebase
late final FirebaseAuth firebaseAuth;
late final BuildConfig buildConfig;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await environmentInit();
  buildConfig = await loadBuildConfig();
  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);

  runApp(RootComponent());
}

