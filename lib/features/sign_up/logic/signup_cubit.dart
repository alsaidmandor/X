import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x/core/utilits/constants_image.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../core/utilits/utility.dart';
import '../data/models/user_model.dart';
import '../data/repository/sign_up_repo.dart';

part 'signup_cubit.freezed.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;

  SignupCubit(this._signupRepo) : super(const SignupState.initial());

// set text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    emit(const SignupState.signupLoading());
    // TODO: Add signup logic
    //get random number for profile
    Random random = Random();
    int randomNumber = random.nextInt(8);
    // create user model
    UserModel user = UserModel(
      displayName: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      bio: 'Edit profile to update bio',
      dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
          .toString(),
      location: 'Somewhere in universe',
      profilePic: ConstantsImage.dummyProfilePicList[randomNumber],
      isVerified: false,
    );

    final response = await _signupRepo.signUp(
        email: emailController.text,
        password: passwordController.text,
        user: user);
    response.when(success: (signupResponse) {
      CacheHelper.saveData(
          key: CacheConstants.uId, value: signupResponse.user!.uid);
      if (kDebugMode) {
        print(" uId => ${CacheHelper.getData(key: 'uId').toString()}");
      }
      emit(SignupState.signupSuccess(signupResponse));
    }, failure: (error) {
      emit(SignupState.signupError(error: error.message ?? ''));
    });
  }
}
