import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/extensions.dart';
import 'package:x/features/onboarding/widget/text_and_button_sign_up.dart';
import 'package:x/features/onboarding/widget/x_logo.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const XLogo(),
              const Spacer(),
              const TextAndButtonSignUP(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account already?',
                    style: TextStyles.font14LightGrayRegular,
                  ),
                  TextButton(
                    child: Text(
                      'login',
                      style: TextStyles.font14BlueSemiBold,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.loginScreen);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
