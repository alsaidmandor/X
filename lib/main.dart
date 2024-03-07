import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:x/core/routing/app_router.dart';

import 'package:x/x_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(XApp(
    appRouter: AppRouter(),
  ));

}
