import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/core/routing/routes.dart';
import 'package:x/features/login/ui/login_screen.dart';

import '../../features/home/data/repository/home_repo.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/sign_up/logic/signup_cubit.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => HomeCubit(HomeRepo())..emitProfileStates(),
              child: HomeScreen()),
        );
      default:
        return null;
    }
  }
}
