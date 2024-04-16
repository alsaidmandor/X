import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilits/constants_image.dart';

class CustomImageCircle extends StatelessWidget {
  const CustomImageCircle(
      {Key? key, this.path, this.height = 50, this.isBorder = false})
      : super(key: key);
  final String? path;
  final double height;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: Colors.grey.shade100, width: isBorder ? 2 : 0),
      ),
      child: CircleAvatar(
        maxRadius: height / 2,
        backgroundColor: Theme.of(context).cardColor,
        backgroundImage:
            customAdvanceNetworkImage(path ?? ConstantsImage.dummyProfilePic),
      ),
    );
  }
}

CachedNetworkImageProvider customAdvanceNetworkImage(String? path) {
  if (path ==
      'http://www.azembelani.co.za/wp-content/uploads/2016/07/20161014_58006bf6e7079-3.png') {
    path = ConstantsImage.dummyProfilePic;
  } else {
    path ??= ConstantsImage.dummyProfilePic;
  }
  return CachedNetworkImageProvider(
    path,
    cacheKey: path,
  );
}
