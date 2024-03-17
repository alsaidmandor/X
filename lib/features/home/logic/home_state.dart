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

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
