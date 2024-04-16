import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x/core/helper/extensions.dart';

class ComposeTweetImage extends StatelessWidget {
  final File? image;
  final VoidCallback onCrossIconPressed;

  const ComposeTweetImage(
      {Key? key, this.image, required this.onCrossIconPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image == null
          ? Container()
          : Stack(
              children: <Widget>[
                InteractiveViewer(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 220,
                      width: context.width * .8.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.file(image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black54),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 20,
                        onPressed: onCrossIconPressed,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
