import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/spacing.dart';
import 'package:x/core/theming/styles.dart';
import 'package:x/core/widget/already_have_account_text.dart';
import 'package:x/features/sign_up/ui/widget/sign_up_bloc_listener.dart';
import 'package:x/features/sign_up/ui/widget/sign_up_form.dart';

import '../../../core/widget/app_text_botton.dart';
import '../../../core/widget/x_logo.dart';
import '../logic/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const XLogo(
                  height: 50,
                ),
                verticalSpace(40.h),
                Text(
                  'Sign up to Twitter',
                  style: TextStyles.font24BlackBold,
                ),
                verticalSpace(40.h),
                const SignupForm(),
                verticalSpace(40),
                AppTextButton(
                  buttonText: "Create Account",
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    validateThenDoSignup(context);
                  },
                ),
                verticalSpace(30),
                const AlreadyHaveAccountText(),
                const SignupBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignupCubit>().formKey.currentState!.validate()) {
      context.read<SignupCubit>().emitSignupStates();
    }
  }
}
