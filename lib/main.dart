import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";

import "app/BuildConfig.dart";
import "app/env/environment.dart";
import "app/root/root_component.dart";
import "firebase_options.dart";

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

