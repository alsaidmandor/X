import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/routing/app_router.dart';
import 'package:x/x_app.dart';

import 'bloc_observer.dart';
import 'core/di/dependency_injection.dart';
import 'core/helper/cache_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(XApp(
    appRouter: AppRouter(),
  ));
}
