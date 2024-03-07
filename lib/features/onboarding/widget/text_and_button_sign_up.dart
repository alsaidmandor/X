import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/extensions.dart';
import 'package:x/core/helper/spacing.dart';
import 'package:x/core/widget/app_text_botton.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/styles.dart';

class TextAndButtonSignUP extends StatelessWidget {
  const TextAndButtonSignUP({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'See what\'s happening in the world right now.',
          style: TextStyles.font24BlackBold,
        ),
        verticalSpace(20.h),
        AppTextButton(
            buttonText: 'Create Account',
            textStyle: TextStyles.font16WhiteMedium,
            onPressed: () {
              context.pushNamed(Routes.signUpScreen);
            })
      ],
    );
  }
}
