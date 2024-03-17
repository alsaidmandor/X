import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/cache_helper.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/colors.dart';

class XApp extends StatelessWidget {
  final AppRouter appRouter;

  const XApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    var uId = CacheHelper.getData(key: 'uId');
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(
          title: 'X',
          theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute:
              uId.isNotEmpty ? Routes.homeScreen : Routes.onBoardingScreen,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
