import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widget/x_logo.dart';

class LogoAndText extends StatelessWidget {
  const LogoAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: XLogo(
            height: 130.h,
          ),
        ),
        verticalSpace(40.h),
        Text(
          'Login to Twitter',
          style: TextStyles.font24BlackBold,
        ),
      ],
    );
  }
}
