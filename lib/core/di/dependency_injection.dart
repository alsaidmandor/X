import 'package:get_it/get_it.dart';

import '../../features/home/data/repository/home_repo.dart';
import '../../features/login/data/repository/login_repository.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/sign_up/data/repository/sign_up_repo.dart';
import '../../features/sign_up/logic/signup_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo());
  getIt.registerFactory<SignupCubit>(() => SignupCubit(
        getIt(),
      ));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo());
}
