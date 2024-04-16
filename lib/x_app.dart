import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/cache_helper.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/colors.dart';
import 'core/utilits/utility.dart';
import 'features/home/data/repository/home_repo.dart';
import 'features/home/logic/home_cubit.dart';

class XApp extends StatelessWidget {
  final AppRouter appRouter;

  const XApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    var uId;

    if (CacheHelper.getData(key: CacheConstants.uId) != null) {
      print(
          "uId => ${CacheHelper.getData(key: CacheConstants.uId).toString()}");
      uId = CacheHelper.getData(key: CacheConstants.uId);
    } else {
      CacheHelper.saveData(key: CacheConstants.uId, value: null);
      print("uId => ${CacheHelper.getData(key: 'uId').toString()}");
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(HomeRepo())
            ..emitProfileStates()
            ..emitGetProfileStates(),
        ),
      ],
      child: ScreenUtilInit(
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
                uId != null ? Routes.homeScreen : Routes.onBoardingScreen,
            onGenerateRoute: appRouter.generateRoute,
          )),
    );
  }
}
