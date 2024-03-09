import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/widget/x_logo.dart';
import 'package:x/features/onboarding/widget/text_and_button_sign_up.dart';

import '../../core/widget/already_have_account_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              XLogo(),
              Spacer(),
              TextAndButtonSignUP(),
              Spacer(),
              AlreadyHaveAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
