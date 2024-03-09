part of 'login_cubit.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs
@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.loginLoading() = LoginLoading;

  const factory LoginState.loginSuccess(T data) = LoginSuccess<T>;

  const factory LoginState.loginError(String error) = LoginError;
}
