import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XLogo extends StatelessWidget {
  const XLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset('assets/svgs/logo_icon.svg'));
  }
}
