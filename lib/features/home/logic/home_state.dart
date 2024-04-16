part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class BottomChanged extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserModel user;

  HomeSuccess(this.user);
}

class HomeSuccessListUser extends HomeState {
  final List<UserModel> user;

  HomeSuccessListUser(this.user);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}

class ScrollChanged extends HomeState {}

class HomeDescriptionChanged extends HomeState {}

class HomeLoadingUploadImage extends HomeState {}

class HomeSuccessUploadImage extends HomeState {
  final String imageUrl;

  HomeSuccessUploadImage(this.imageUrl);
}

class HomeErrorUploadImage extends HomeState {
  final String error;

  HomeErrorUploadImage(this.error);
}

class TweetImagePickedSuccessState extends HomeState {}

class TweetImagePickedErrorState extends HomeState {}

// create Tweet

class HomeLoadingCreateTweet extends HomeState {}

class HomeSuccessCreateTweet extends HomeState {
  final String id;

  HomeSuccessCreateTweet(this.id);
}

class HomeErrorCreateTweet extends HomeState {
  final String error;

  HomeErrorCreateTweet(this.error);
}

class HomeLoadingLocation extends HomeState {}

class HomeSuccessLocation extends HomeState {
  final Placemark placemark; // city, country

  HomeSuccessLocation(this.placemark);
}

class HomeErrorLocation extends HomeState {
  final String error;

  HomeErrorLocation(this.error);
}
