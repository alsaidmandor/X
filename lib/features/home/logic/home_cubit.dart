import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/features/chat/ui/chat_screen.dart';
import 'package:x/features/home/data/repository/home_repo.dart';

import '../../feed/ui/feed_screen.dart';
import '../../notification/ui/notification_screen.dart';
import '../../search/ui/search_screen.dart';
import '../../sign_up/data/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens(ScrollController scrollController) => [
        FeedScreen(scrollController),
        SearchScreen(scrollController),
        NotificationScreen(scrollController),
        ChatScreen(scrollController),
      ];

  int currentIndex = 0;

  void changeBottom(int index) {
    currentIndex = index;
    emit(BottomChanged());
  }

  UserModel? userModel;

  void emitProfileStates() async {
    emit(HomeLoading());
    final result = await _homeRepo.getProfile();
    result.when(success: (profile) {
      print(profile.profilePic);
      print('========================');
      userModel = profile;
      emit(HomeSuccess(profile));
    }, failure: (error) {
      emit(HomeError(error.message ?? 'Something went wrong'));
    });
  }
}
