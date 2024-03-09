import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/repository/login_repository.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loginLoading());
    final response = await _loginRepo
        .login(email: emailController.text, password: passwordController.text);
    response.when(
      success: (loginResponse) {
        emit(LoginState.loginSuccess(loginResponse));
      },
      failure: (error) {
        emit(LoginState.loginError(
            error.message ?? 'Something went wrong in login process'));
      },
    );
  }
}
