import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/features/login/ui/widget/dont_have_account_text.dart';
import 'package:x/features/login/ui/widget/email_and_password.dart';
import 'package:x/features/login/ui/widget/login_bloc_listener.dart';
import 'package:x/features/login/ui/widget/logo_and_text.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widget/app_text_botton.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(30.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoAndText(),
                  verticalSpace(40.h),
                  const EmailAndPassword(),
                  verticalSpace(100.h),
                  AppTextButton(
                    buttonText: "Login",
                    textStyle: TextStyles.font16WhiteSemiBold,
                    onPressed: () {
                      validateThenDoLogin(context);
                    },
                  ),
                  verticalSpace(50.h),
                  const DontHaveAccountText(),

                  const LoginBlocListener(),
                ],
              ),
            )),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context
        .read<LoginCubit>()
        .formKey
        .currentState!
        .validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
